Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262427AbTCROkK>; Tue, 18 Mar 2003 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262438AbTCROkK>; Tue, 18 Mar 2003 09:40:10 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:32242 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262427AbTCROkJ>;
	Tue, 18 Mar 2003 09:40:09 -0500
Date: Tue, 18 Mar 2003 15:49:43 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-ntfs-dev@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: NTFS byte swapping
Message-ID: <Pine.GSO.4.21.0303181546500.17808-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling NTFS support in 2.5.65 on a big-endian machine (m68k), I get:

| fs/ntfs/compress.c:167: warning: passing arg 1 of `__swab16p' from incompatible pointer type
| fs/ntfs/compress.c:207: warning: passing arg 1 of `__swab16p' from incompatible pointer type
| fs/ntfs/compress.c:228: warning: passing arg 1 of `__swab16p' from incompatible pointer type
| fs/ntfs/compress.c:333: warning: passing arg 1 of `__swab16p' from incompatible pointer type

The offending code does `le16_to_cpup(cb)', with cb a pointer to a u8.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

