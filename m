Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267847AbUG3VaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267847AbUG3VaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUG3VaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:30:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:27369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267847AbUG3VaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:30:02 -0400
Date: Fri, 30 Jul 2004 14:29:30 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040730212930.GA30979@kroah.com>
References: <200407301409.05638.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301409.05638.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 02:09:05PM -0700, Jesse Barnes wrote:
> 
> Thoughts?  I've tried to add cleanup code, but I'm not sure how acceptable it 
> is and I don't have any way of testing it.

You don't have access to a cardbus machine?  Or how about using the
fakephp driver to "remove" pci devices?  You should be able to test this
code path with either one of those methods...

> +void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
> +{
> +	/* Don't need to free config entries since they're static & global */

What do you mean by this?  You should still remove all files we added in
the pci_create_sysfs_dev_files() function here, not just the rom file.

thanks,

greg k-h
