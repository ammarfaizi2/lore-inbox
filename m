Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314394AbSESMio>; Sun, 19 May 2002 08:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSESMio>; Sun, 19 May 2002 08:38:44 -0400
Received: from mail.sonytel.be ([193.74.243.200]:40666 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S314394AbSESMin>;
	Sun, 19 May 2002 08:38:43 -0400
Date: Sun, 19 May 2002 14:38:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4/2.5 SCSI considerably slower than FreeBSD
In-Reply-To: <20020517115319.GA3204@merlin.emma.line.org>
Message-ID: <Pine.GSO.4.21.0205191435340.27746-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Matthias Andree wrote:
> Marco Flohrer has posted an inquiry to de.comp.os.unix.linux.hardware
> [German] <slrnae8q66.go4.marco.flohrer@diamond.csn.tu-chemnitz.de> that his
> Seagate 36ES2 was slow with a DawiControl 2976UW (SYM53C875), only
> around 25 MB/s. I have the same observation with a Fujitsu MAH3182MP
> with an Adaptec 2940UW Pro which is not much faster. Either bus has an
> active LVD/SE terminator.
> 
> Single-user mode,
> time dd if=/dev/XXX of=/dev/null bs=65536 count=10240
> (671,1 MB) linear read.
> 
> Table shows throughput in decimal MB/s (M = 1,000,000)
> 
>                                2.5  2.4  FBSD        max.
> UWSCSI Fuj MAH3182MP  7200/min 32,1 29,4 35,1 TQ     40
> UDMA66 Max 4W060H4    5400/min 27,1 26,7 25,7        66
> UDMA66 IBM DTLA307045 7200/min 37,2 37,5 37,2 TQ 2.5 66
> UDMA66 WDC AC420400D  5400/min 15,5 15,5 15,5 TQ 2.5 66
>                                --------------
> table is in decimal MB/s.

I used to get 17 MiB/s with a Quantum Viking II U2W connected to the wide chain
of a DawiControl 2976UW (SYM53C875) on my PPC box. This was using the old
sym53c8xx driver (don't remember whether I ever rerun the test with sym2).

I just reran the test (both dd and hdparm) using my current kernel
(2.4.17-pre2, using sym2) and I got only 12 MiB/s.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

