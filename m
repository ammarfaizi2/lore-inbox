Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVCUXQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVCUXQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVCUXNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:13:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:16813 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262190AbVCUXGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:06:42 -0500
Date: Mon, 21 Mar 2005 10:40:20 -0800
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI: remove pci_find_device usage from pci sysfs code.
Message-ID: <20050321184020.GA5472@kroah.com>
References: <11099696382684@kroah.com> <11099696382576@kroah.com> <200503201554.05010.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503201554.05010.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 03:53:58PM +0100, Rolf Eike Beer wrote:
> Greg KH wrote:
> > ChangeSet 1.1998.11.23, 2005/02/25 08:26:11-08:00, gregkh@suse.de
> >
> > PCI: remove pci_find_device usage from pci sysfs code.
> 
> > diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > --- a/drivers/pci/pci-sysfs.c	2005-03-04 12:41:33 -08:00
> > +++ b/drivers/pci/pci-sysfs.c	2005-03-04 12:41:33 -08:00
> > @@ -481,7 +481,7 @@
> >  	struct pci_dev *pdev = NULL;
> >
> >  	sysfs_initialized = 1;
> > -	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
> > +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL)
> >  		pci_create_sysfs_dev_files(pdev);
> >
> >  	return 0;
> 
> Any reasons why you are not using "for_each_pci_dev(pdev)" here?

Nope, I forgot it was there :)

Care to send a patch?

thanks,

greg k-h
