Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVBQX0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVBQX0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVBQXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:24:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:57495 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261208AbVBQXVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:21:16 -0500
Date: Thu, 17 Feb 2005 15:18:01 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: Piotr Kaczuba <pepe@attika.ath.cx>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: PCI access mode on x86_64
Message-ID: <20050217231801.GC22195@kroah.com>
References: <20050213213117.GA18812@attika.ath.cx> <m1oeenh53g.fsf@muc.de> <20050214094701.GA323@attika.ath.cx> <20050214120205.GA33348@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214120205.GA33348@muc.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 01:02:05PM +0100, Andi Kleen wrote:
> On Mon, Feb 14, 2005 at 10:47:01AM +0100, Piotr Kaczuba wrote:
> > On Mon, Feb 14, 2005 at 10:18:43AM +0100, Andi Kleen wrote:
> > > Piotr Kaczuba <pepe@attika.ath.cx> writes:
> > > > Is there a reason why "PCI access mode" config option isn't available for
> > > > x86_64? Due to this, PCIE config options aren't available either.
> > > 
> > > There is no 64bit PCI BIOS, so access is always direct.
> > > 
> > > I assume you mean mmconfig access with "PCIE config options", that is
> > > a separate config option and available.
> > 
> > I mean the PCIEPORTBUS option which depends on PCI_GOMMCONFIG or
> > PCI_GOANY. I assume that due to PCI_MMCONFIG / PCI_GOMMCONFIG mismatch
> > it's not available on x86_64.
> 
> Ok, that's a bug in PCIEPORTBUS.  Best is probably to 
> completely remove the dependency, it doesn't make much sense
> (the code has to handle the case of mmconfig not being available at 
> runtime anyways) 
> 
> -Andi
> 
> Remove bogus dependency in PCI Express root driver.

Applied, thanks.

greg k-h

