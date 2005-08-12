Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVHLVth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVHLVth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVHLVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:49:37 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:24915 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751291AbVHLVtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:49:36 -0400
Date: Fri, 12 Aug 2005 14:49:29 -0700
From: Greg KH <gregkh@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Brett Russ <russb@emc.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12.3] PCI/libata INTx cleanup
Message-ID: <20050812214929.GA24518@suse.de>
References: <20050803204709.8BA0720B06@lns1058.lss.emc.com> <42FBA08C.5040103@pobox.com> <20050812171043.CF61020E8B@lns1058.lss.emc.com> <20050812182253.GA7842@suse.de> <42FD1828.6030003@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FD1828.6030003@didntduck.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 05:44:08PM -0400, Brian Gerst wrote:
> Greg KH wrote:
> >On Fri, Aug 12, 2005 at 01:10:43PM -0400, Brett Russ wrote:
> >
> >>Jeff Garzik wrote:
> >>
> >>>Brett Russ wrote:
> >>>
> >>>
> >>>>Simple cleanup to eliminate X copies of the same function in libata.  
> >>>>Moved pci_enable_intx() to pci.c, added pci_disable_intx() as well, 
> >>>>and use them throughout libata and msi.c.
> >>>>
> >>>>Signed-off-by: Brett Russ <russb@emc.com>
> >>>
> >>>
> >>>Though there is nothing wrong with this patch, I would prefer a single 
> >>>function, pci_intx(), as found in drivers/scsi/ahci.c.
> >>>
> >>>Would you be willing to move that one to the PCI layer, eliminate the 
> >>>multiple copies of pci_enable_intx(), and replace the calls to 
> >>>pci_enable_intx() with calls to pci_intx() ?
> >>
> >>Sounds like what I did, except for the naming change.  I did away with
> >>pci_disable_intx() and changed the names.  Look ok?
> >
> >
> >Looks ok to me, care to resend it with a Signed-off-by: and a new
> >changelog entry so I can apply it?
> >
> >
> >>+EXPORT_SYMBOL(pci_intx);
> >
> >
> >Hm, for new pci functions, I prefer to have them marked as
> >EXPORT_SYMBOL_GPL(), is that ok with you?
> 
> It's not really "new".  It's simply a trivial wrapper around other pci 
> functions.

It's a newly exported function.

thanks,

greg k-h
