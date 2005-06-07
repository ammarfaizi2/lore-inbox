Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVFGFUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVFGFUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVFGFUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:20:12 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:55653 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261718AbVFGFUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:20:05 -0400
Date: Mon, 6 Jun 2005 22:19:49 -0700
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050607051949.GB17734@suse.de>
References: <20050603224551.GA10014@kroah.com> <524qcft3m6.fsf@topspin.com> <20050606225826.GB11184@suse.de> <52acm3j9qi.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52acm3j9qi.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 05:23:17PM -0700, Roland Dreier wrote:
>     Greg> Motherboard quirks are one thing.  Broken devices are a
>     Greg> totally different thing.  If there are too many of them,
>     Greg> then the current situation is acceptable to me.  Does ib
>     Greg> have devices that will break with MSI?
> 
> Yes, I believe some versions of the firmware for Mellanox HCAs have
> problems with MSI.

Ick ick ick, and people think writing drivers is "easy"...

>     Greg> In looking at that, I don't see a way to get rid of the msix
>     Greg> stuff.  So that's probably just going to stay the same.
> 
> OK -- we'll just have to make sure that the switch from MSI mode to
> MSI-X mode is implementated correctly.

Hm good point, I think I got that wrong in my patch, let me go fix that
up...

thanks,

greg k-h
