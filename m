Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289209AbSAGNgH>; Mon, 7 Jan 2002 08:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289219AbSAGNfu>; Mon, 7 Jan 2002 08:35:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289204AbSAGNeu>; Mon, 7 Jan 2002 08:34:50 -0500
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
To: rguenth@tat.physik.uni-tuebingen.de (Richard Guenther)
Date: Mon, 7 Jan 2002 13:45:44 +0000 (GMT)
Cc: pstadt@stud.fh-heilbronn.de (Oliver Paukstadt),
        akpm@zip.com.au (Andrew Morton),
        matti.aarnio@zmailer.org (Matti Aarnio),
        linux-kernel@vger.kernel.org (Linux-Kernel),
        linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201071047410.17279-100000@bellatrix.tat.physik.uni-tuebingen.de> from "Richard Guenther" at Jan 07, 2002 10:51:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Na5w-0001G7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see dropped frames while watching TV (bttv chip, xawtv in overlay mode,
> XFree 4.1.0)
> since I use ext3 (2.4.16&17). Always during disk activity (IDE, umask irq
> and dma enabled). From what I know the bttv driver does it seems to loose
> interrupts!? This doesnt happen with ext2.

The really important bit there is that you see dropped frames in overlay
mode. Overlay mode the hardware is copying directly. The only way you should
lose frames in overlay mode is if the chip couldnt sync to that frame or
the PCI bus was fully loaded by other traffic and the transfer failed. There
are some other corner cases too (certainly video cards can run out of
bandwidth during accelerated operations like bitblt)

Alan
