Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135428AbRDMHET>; Fri, 13 Apr 2001 03:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135430AbRDMHEJ>; Fri, 13 Apr 2001 03:04:09 -0400
Received: from aeon.tvd.be ([195.162.196.20]:42476 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S135428AbRDMHD4>;
	Fri, 13 Apr 2001 03:03:56 -0400
Date: Fri, 13 Apr 2001 09:02:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: lomarcan@tin.it
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape Corruption - update
In-Reply-To: <20010412084318.LESP2878.fep02-svc.tin.it@fep41-svc.tin.it>
Message-ID: <Pine.LNX.4.05.10104130858220.2653-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001 lomarcan@tin.it wrote:
> Still experimenting with my SDT-9000... tried connecting it to another
> controller
> (2940AU in place of 2904, sorry but I've only Adaptec stuff :). Same
> problem.
> Tried with another tape (even with an old DDS-2 tape). Same. Even tried
> another
> cable/removing the CDWR drive from the bus.
> 
> It seems that the tape is written incorrectly. I wrote some large file
> (300MB)
> and read it back four time. The read copies are all the same. They differ
> from the original only in 32 consecutive bytes (the replaced values SEEM
> random). Of course, 32 bytes in 300MB tar.gz files are TOO MUCH to be 
> accepted :)

As Gérard already replied, I have the same problem on my PPC box (cfr. my
postings last month) with DDS-1 tape drive. It has 2 SCSI adapters (MESH and
Sym53c875), and it seems to happen with the '875 only (but the MESH sucks
anyway and has other problems making it unusable for my DDS-1).

In my case, the 32 bad bytes are always a copy of the 32 bytes 10K before (10K
= blocksize of tar). Can you verify that's the case for you as well? For
reference, I have approx. 6 sequences of corrupted data when writing 256 MB to
tape. Reading gives no problems.

The problem does not appear in 2.2.13 (yep, that's old, but so far the latest
2.2.x kernel that runs on my CHRP LongTrail). I have to fix later kernels
first.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

