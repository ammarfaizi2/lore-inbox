Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQLKAAo>; Sun, 10 Dec 2000 19:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbQLJX7k>; Sun, 10 Dec 2000 18:59:40 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:13578 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131524AbQLJX7Z>;
	Sun, 10 Dec 2000 18:59:25 -0500
Date: Mon, 11 Dec 2000 00:28:50 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: davej@suse.de
Cc: Martin Mares <mj@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
Message-ID: <20001211002850.A14393@pcep-jamie.cern.ch>
In-Reply-To: <20001209160403.A28562@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0012091803270.571-100000@neo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012091803270.571-100000@neo.local>; from davej@suse.de on Sat, Dec 09, 2000 at 06:11:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few more:

 net/acenic.c: pci_write_config_byte(ap->pdev, PCI_CACHE_LINE_SIZE,
 net/gmac.c: PCI_CACHE_LINE_SIZE, 8);
 scsi/sym53c8xx.c: printk(NAME53C8XX ": PCI_CACHE_LINE_SIZE set to %d (fix-up).\n",
 video/pm2fb.c: WR32(p->pci_config, PCI_CACHE_LINE_SIZE, 0xff00);

-- Jamie

davej@suse.de wrote:
> > > 1. Is there reason for the drivers to be setting this themselves
> > >    to hardcoded values ?
> > 
> > Definitely not unless the devices are buggy and need a work-around.
> 
> Maybe that's the case. The culprits are mostly IDE interfaces. Andre ?
> 
> drivers/ide/cmd64x.c:   (void) pci_write_config_byte(dev,PCI_CACHE_LINE_SIZE, 0x10);
> drivers/ide/cs5530.c:   pci_write_config_byte(cs5530_0,PCI_CACHE_LINE_SIZE, 0x04);
> drivers/ide/hpt366.c:   pci_write_config_byte(dev,PCI_CACHE_LINE_SIZE, 0x08);
> drivers/ide/ns87415.c:  (void) pci_write_config_byte(dev,PCI_CACHE_LINE_SIZE, 0x10);
> 
> drivers/atm/eni.c:      pci_write_config_byte(eni_dev->pci_dev,PCI_CACHE_LINE_SIZE, 0x10);
> drivers/media/video/planb.c:    pci_write_config_byte (pdev,PCI_CACHE_LINE_SIZE, 0x8);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
