Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273702AbRIXAAY>; Sun, 23 Sep 2001 20:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273705AbRIXAAK>; Sun, 23 Sep 2001 20:00:10 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37893 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273702AbRIXAAB>; Sun, 23 Sep 2001 20:00:01 -0400
Subject: Re: Linux-2.4.10 - necessary patches
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Mon, 24 Sep 2001 01:04:58 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3BAE64E8.EC552B76@eyal.emu.id.au> from "Eyal Lebedinsky" at Sep 24, 2001 08:40:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lJF4-0000rL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> --- linux-2.4.10-pre7/include/scsi/scsi.h	Fri Apr 27 13:59:19 2001
> +++ linux/include/scsi/scsi.h	Mon Sep 10 03:53:58 2001
> @@ -214,6 +214,12 @@
>  /* Used to get the PCI location of a device */
>  #define SCSI_IOCTL_GET_PCI 0x5387
>  
> +/* Used to invoke Target Defice Reset for Fibre Channel */
> +#define SCSI_IOCTL_FC_TDR 0x5388
> +
> +/* Used to get Fibre Channel WWN and port_id from device */
> +#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5389
> +

These are compaq made up ioctls. They shouldnt be merged like that. Instead
there needs to be proper discussion about what is actualyl needed
