Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQKJG4h>; Fri, 10 Nov 2000 01:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbQKJG42>; Fri, 10 Nov 2000 01:56:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26632 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129786AbQKJG4V>; Fri, 10 Nov 2000 01:56:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [i386] CPU detection cleanup version 2
Date: 9 Nov 2000 22:55:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ug65n$53t$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have produced another version of the CPU detection cleanup patch.
Now I have ported over mtrr.c, and fix a small handful of places I had
missed because of the configurations I had used.

The number one thing I *haven't* yet done with it -- which I'd like to
-- is to integrate the handling of bugs (except the P6 SEP bug) into
the same framework and pretty much eliminate asm/bugs.h, as well as
splitting off the CPU detection into a separate file.  However, due to
the very late stage in the game, I wanted to worry about things that
are important for correctness for now.

Please do keep in mind this is not merely a cosmetic change.  The old
code was rather shockingly klugy and incorrect in a number of places.
A lot of problems I thought were AMD CPUID bugs were in fact caused by
Linux trying to use the Intel-defined and the AMD-defined flags as
interchangeable (they're not.)

The patch is at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/cpuid-2.4.0-test11-pre2-2.diff

Please give me reports on works/not works with output from
/proc/cpuinfo and the cpuid.c program (in the same directory as the
patch.)

	-hpa








-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
