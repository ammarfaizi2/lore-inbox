Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292832AbSBVH7X>; Fri, 22 Feb 2002 02:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292833AbSBVH7N>; Fri, 22 Feb 2002 02:59:13 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:51840 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292832AbSBVH7A>; Fri, 22 Feb 2002 02:59:00 -0500
Date: Fri, 22 Feb 2002 02:58:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202220758.g1M7wn707473@devserv.devel.redhat.com>
To: Magnus Stenman <stone@hkust.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Seagate IDE tape problems
In-Reply-To: <mailman.1014321006.12055.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1014321006.12055.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having trouble with a Seagate IDE tape drive that previously
> worked with 2.2.x kernels. (tape is a STT8000A travan drive)
>[...]
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: SAMSUNG SV2042H, ATA DISK drive
> hdc: SAMSUNG SV3063H, ATA DISK drive
> hdd: Seagate STT8000A, ATAPI TAPE drive

Make sure you switched DMA off with hdparm -d0.
You must find corresponding /dev/hdX, hdparm does not work
on /dev/ht0. If is a known problem (Red Hat bug #54517).

BTW, if you have trouble with Red Hat kernels, you may find
better luck trying Red Hat support. What if I did not see
your message here?

-- Pete
