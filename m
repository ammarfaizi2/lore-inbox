Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTERWXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTERWXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:23:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22285
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262232AbTERWXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:23:05 -0400
Date: Sun, 18 May 2003 15:13:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: alan@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] 2.4.21-rc1 pointless IDE noise reduction
In-Reply-To: <20030518130627.GC12766@fs.tum.de>
Message-ID: <Pine.LNX.4.10.10305181510170.32050-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just maybe people would like to know if there is a secret OS on the tail
of their drive, or the potential for one being there.

Go research EDDS BEER PARTIES and you will find out this is not a joke.

If the noise pisses you off turn down your kernel printk noise makers.
Better yet stub it out in your own kernel.

Do not remove items that have meaning or valid tests.

Erik, get over it and just live with a stub out.

Cheers,

On Sun, 18 May 2003, Adrian Bunk wrote:

> Below is a 2.5 version of the patch to remove 
> idedisk_supports_host_protected_area.
> 
> I've tested the compilation with 2.5.69-mm6.
> 
> cu
> Adrian
> 
> 
> --- linux-2.5.69-mm6/drivers/ide/ide-disk.c.old	2003-05-18 14:55:31.000000000 +0200
> +++ linux-2.5.69-mm6/drivers/ide/ide-disk.c	2003-05-18 14:56:17.000000000 +0200
> @@ -1064,18 +1064,6 @@
>  #endif /* CONFIG_IDEDISK_STROKE */
>  
>  /*
> - * Tests if the drive supports Host Protected Area feature.
> - * Returns true if supported, false otherwise.
> - */
> -static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
> -{
> -	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
> -	if (flag)
> -		printk(KERN_INFO "%s: host protected area => %d\n", drive->name, flag);
> -	return flag;
> -}
> -
> -/*
>   * Compute drive->capacity, the full capacity of the drive
>   * Called with drive->id != NULL.
>   *
> @@ -1101,8 +1089,6 @@
>  	drive->capacity48 = 0;
>  	drive->select.b.lba = 0;
>  
> -	(void) idedisk_supports_host_protected_area(drive);
> -
>  	if (id->cfs_enable_2 & 0x0400) {
>  		capacity_2 = id->lba_capacity_2;
>  		drive->head		= drive->bios_head = 255;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

