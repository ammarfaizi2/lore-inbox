Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269466AbUIZArp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269466AbUIZArp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 20:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269462AbUIZArp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 20:47:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7406 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269466AbUIZAqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 20:46:52 -0400
Subject: Re: SiI3112 Serial ATA Maxtor 6Y120M0 incorrect geometry detected
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: micah milano <micaho@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e04092515157e9b72ef@mail.gmail.com>
References: <70fda320409251214129bba57@mail.gmail.com>
	 <70fda3204092514037c6dc039@mail.gmail.com>
	 <58cb370e04092515157e9b72ef@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096155867.17188.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Sep 2004 00:44:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-25 at 23:15, Bartlomiej Zolnierkiewicz wrote:
> - BIOS CHS is _useless_ for IDE driver
> - IDE driver returns different geometry for 2.[2,4,6].x kernels
> - Andries removed ide-geometry.c in 2.5 but didn't HDIO_GETGEO ioctl
> - BIOS CHS is available through EDD driver now
(Occasionally 8)
> - this is a parted problem
(and fixed in parted patches)

> - remove CHS info from IDE printks and /proc/ide/
> - add BLKGETSTART ioctl for getting partition's start sector
>   (this is the only legitimate use of HDIO_GETGEO currently)

If you drop the CHS/LBA/.. information from the printk's it might be
nice to replace ith with "in CHS" "in LBA28" "in LBA48" mode information
since that is the only thing it really told people.

