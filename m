Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131523AbRCSRMN>; Mon, 19 Mar 2001 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbRCSRMD>; Mon, 19 Mar 2001 12:12:03 -0500
Received: from aeon.tvd.be ([195.162.196.20]:25514 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S131523AbRCSRLt>;
	Mon, 19 Mar 2001 12:11:49 -0500
Date: Mon, 19 Mar 2001 18:10:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: st corruption with 2.4.3-pre4
Message-ID: <Pine.LNX.4.05.10103191802380.13975-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While doing some tests with my DDS drive, I noticed some file corruption. The
data was written to the tape incorrectly, since reading always gives the same
result. The drive didn't notice any write error.

My test consisted of tarring up some kernel sources and splitting them in
files of 16 MB. Then I archived the files on the tape using tar.

Some of the files are corrupted. Each corruption consists of 32 consecutive
bytes being changed. The corrupted bytes are not random, but seem to contain
parts of the kernel sources. This indicates that some data got copied from
somewhere in the buffer cache.

The disk with the test files is connected to a MESH SCSI interface.
The tape drive is a HP C1536 DDS and is connected to a Sym53c875 SCSI card.
The machine is a CHRP LongTrail running the 2.4.3-pre4 kernel for PPC.

Anyone who saw something similar?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

