Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135245AbRDVSjr>; Sun, 22 Apr 2001 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135243AbRDVSji>; Sun, 22 Apr 2001 14:39:38 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:20240 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S135242AbRDVSj0>;
	Sun, 22 Apr 2001 14:39:26 -0400
Date: Sun, 22 Apr 2001 20:37:38 +0200
From: Victor Julien <v.p.p.julien@xs4all.nl>
To: Manuel McLure <manuel@mclure.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Message-ID: <20010422203738.A449@victor>
In-Reply-To: <20010422194713.A321@victor> <20010422110902.C1093@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010422110902.C1093@ulthar.internal.mclure.org>; from manuel@mclure.org on Sun, Apr 22, 2001 at 20:09:02 +0200
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow! Now it not only boots right, the sound distortion problem also seems
to be fixed!!! Great work! However another problem is still here, i see
only one of the two ide-channels of the PDC20265.


> 
> On 2001.04.22 10:47 Victor Julien wrote:
> 
> > 2.4.4-pre6 did only compile when I aplied the '__builtin_expect'-patch.
> > It
> > crashed at boot however, when initializing my onboard raidcontroller
> > (PDC20265 on a MSI K7T Turbo-R). It seems to be the same problem as
> > reported by Manuel A. McLure. So no word yet about the sound
> > distortion-problem being fixed.
> 
> The PCD20265 crash is fixed in 2.4.3-ac12 and should be fixed in the next
> -pre.
> In the meantime you can apply the following patch from Alan Cox:
> 
> *** drivers/ide/ide-pci.c.orig	Sun Apr 22 11:07:51 2001
> --- drivers/ide/ide-pci.c	Sat Apr 21 20:07:09 2001
> ***************
> *** 596,602 ****
>   		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265))
>   		{
>   			printk(KERN_INFO "ide: Found promise 20265 in
> RAID mode.\n");
> ! 			if(dev->bus->self->vendor == PCI_VENDOR_ID_INTEL
> &&
>   				dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960)
>   			{
>   				printk(KERN_INFO "ide: Skipping Promise
> PDC20265 attached to I2O RAID controller.\n");
> --- 596,602 ----
>   		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265))
>   		{
>   			printk(KERN_INFO "ide: Found promise 20265 in
> RAID mode.\n");
> ! 			if(dev->bus->self && dev->bus->self->vendor ==
> PCI_VENDOR_ID_INTEL &&
>   				dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960)
>   			{
>   				printk(KERN_INFO "ide: Skipping Promise
> PDC20265 attached to I2O RAID controller.\n");
> 
> 
> 
> -- 
> Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
> <manuel@mclure.org>     | and significant law, no man may kill a cat.
> <http://www.mclure.org> |             -- H.P. Lovecraft
> 
> 
> 


