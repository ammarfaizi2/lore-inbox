Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282378AbRLEPdl>; Wed, 5 Dec 2001 10:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282924AbRLEPdc>; Wed, 5 Dec 2001 10:33:32 -0500
Received: from mail.sonytel.be ([193.74.243.200]:24801 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S282378AbRLEPdW>;
	Wed, 5 Dec 2001 10:33:22 -0500
Date: Wed, 5 Dec 2001 16:32:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <20011102074532.C708-100000@gerard>
Message-ID: <Pine.GSO.4.21.0112051628480.5865-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, [ISO-8859-1] Gérard Roudier wrote:
> On Thu, 1 Nov 2001, Geert Uytterhoeven wrote:
> As driver sym-2 is planned to replace sym53c8xx in the future, it would be
> interesting to give it a try on your hardware. There are some source
> available from ftp.tux.org, but I can provide you with a flat patch
> against the stock kernel version you want. You may let me know.

I tried sym-2 (2.4.17-pre2) and it didn't show up the problem, which is good!

More news from the old driver:

    1.5c            OK
    1.5d            OK
    1.5e            page fault in interrupt handler 0xa53c0c68
    1.5f            lock up
    1.5pre-g1       lock up
    1.5pre-g2       lock up
    1.5pre-g3       corruption
    1.5g            corruption

So it happened somewhere in between 1.5d and 1.5pre-g3. I'll see whether I can
get any of the intermediates to run...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

