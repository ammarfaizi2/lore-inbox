Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSCMHqY>; Wed, 13 Mar 2002 02:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSCMHqP>; Wed, 13 Mar 2002 02:46:15 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26820 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292648AbSCMHqJ>; Wed, 13 Mar 2002 02:46:09 -0500
Date: Wed, 13 Mar 2002 02:45:56 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Hank Yang <hanky@promise.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, dalecki@evision-ventures.com
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Message-ID: <20020313024556.B11441@devserv.devel.redhat.com>
In-Reply-To: <E16jKMr-0006AG-00@the-village.bc.nu> <03f301c1ca61$a050c190$59cca8c0@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <03f301c1ca61$a050c190$59cca8c0@hank>; from hanky@promise.com.tw on Wed, Mar 13, 2002 at 03:35:12PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 03:35:12PM +0800, Hank Yang wrote:
> We do hope the linux kernel add some code on ide-pci.c like following.
> 
> void __init ide_scan_pcidev (struct pci_dev *dev)
> {
>  ide_pci_devid_t  devid;
>  ide_pci_device_t *d;
> 
>  devid.vid = dev->vendor;
>  devid.did = dev->device;
>  for (d = ide_pci_chipsets; d->devid.vid && !IDE_PCI_DEVID_EQ(d->devid,
> devid); ++d);
>  //Ignored by Promise
>  if ((dev->vendor==PCI_VENDOR_ID_PROMISE) && ((dev->class
> >>8)==PCI_CLASS_STORAGE_RAID))
>  {
>   printk("%s: ignored FastTrak series by PROMISE.\n", d->name);
>   return;
>  }
> 
> Then, we won't affect other IDE controller or ATA-RAID controllers.
> We can provide our ATA-RAID controller's driver by our own.

send the source under GPL first. Until then people
need the linux ataraid driver for promise. 

