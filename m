Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267853AbUG3Vfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267853AbUG3Vfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267855AbUG3Vff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:35:35 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34951 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267853AbUG3VfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:35:20 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Fri, 30 Jul 2004 14:34:50 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@yahoo.com>
References: <200407301409.05638.jbarnes@engr.sgi.com> <20040730212930.GA30979@kroah.com>
In-Reply-To: <20040730212930.GA30979@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301434.50373.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 2:29 pm, Greg KH wrote:
> On Fri, Jul 30, 2004 at 02:09:05PM -0700, Jesse Barnes wrote:
> > Thoughts?  I've tried to add cleanup code, but I'm not sure how
> > acceptable it is and I don't have any way of testing it.
>
> You don't have access to a cardbus machine?  Or how about using the
> fakephp driver to "remove" pci devices?  You should be able to test this
> code path with either one of those methods...

I've never tried fakephp, I'll look into it.  And I do have a laptop at home 
that I could mess around on too, though I don't think I have any devices with 
ROMs...

> > +void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
> > +{
> > +	/* Don't need to free config entries since they're static & global */
>
> What do you mean by this?  You should still remove all files we added in
> the pci_create_sysfs_dev_files() function here, not just the rom file.

What will happen if we don't?  They didn't used to be removed, and there's 
only one global copy afaict.  I'll add code to kill them at any rate.

Thanks,
Jesse
