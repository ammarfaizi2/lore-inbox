Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRBNU2R>; Wed, 14 Feb 2001 15:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRBNU2H>; Wed, 14 Feb 2001 15:28:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48401 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129274AbRBNU16>; Wed, 14 Feb 2001 15:27:58 -0500
Subject: Re: IDE DMA Problems...system hangs
To: jsidhu@arraycomm.com (Jasmeet Sidhu)
Date: Wed, 14 Feb 2001 20:28:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010214115941.02471bb8@pop.arraycomm.com> from "Jasmeet Sidhu" at Feb 14, 2001 12:09:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T8XO-0005wN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody else having these problems with a ide raid 5?
> The Raid 5 performance should also be questioned..here are some number 
> returned by hdparam

You will get horribly bad performance off raid5 if you have stripes on both
hda/hdb  or hdc/hdd etc.

> Feb 13 05:23:27 bertha kernel: hdo: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Feb 13 05:23:27 bertha kernel: hdo: dma_intr: error=0x84 { DriveStatusError 
> BadCRC }

You have inadequate cabling. CRC errors are indications of that. Make sure you
are using sufficiently short cables for ATA33 and proper 80pin ATA66 cables.

> Feb 13 12:12:42 bertha kernel: hdg: irq timeout: status=0x50 { DriveReady 
> SeekComplete }
> Feb 13 12:13:02 bertha kernel: hdg: timeout waiting for DMA

This could be cabling too, cant be sure

> Feb 13 12:13:12 bertha kernel: hdg: DMA disabled

It gave up using DMA

> Feb 13 12:13:12 bertha kernel: ide3: reset: success	<------- * SYSTEM HUNG 
> AT THIS POINT *

Ok thats a reasonable behaviour, except it shouldnt have then hung.
