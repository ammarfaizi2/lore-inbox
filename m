Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUIXVVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUIXVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUIXVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 17:21:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:62903 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268894AbUIXVVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 17:21:14 -0400
Date: Fri, 24 Sep 2004 14:19:12 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       davej@codemonkey.org.uk, hpa@zytor.com
Subject: Re: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is present
Message-ID: <20040924211912.GC7619@kroah.com>
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com> <20040924200231.A30391@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924200231.A30391@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:02:31PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 23, 2004 at 03:26:40PM -0700, Hanna Linder wrote:
> > 
> > Greg asked in a previous janitors thread:
> > "What we need is a simple "Is this pci device present right now" type
> > function, to solve the mess that logic like this needs."
> > 
> > OK. How about this one? It uses pci_get_device but instead of returning
> > the dev it returns 1 if the device is present and 0 if it isnt. This take the
> > burdon off the driver from having to know when to use pci_dev_put or
> > not and should be cleaner for future maintenance work.
> > 
> > Ive tested it with two patches that will follow.
> 
> Please include subdevice/subvendor id

Good idea, but do you see any places in the kernel that would use those
fields, instead of always setting them to PCI_ANY_ID?

thanks,

greg k-h
