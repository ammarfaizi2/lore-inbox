Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136225AbRAHBFw>; Sun, 7 Jan 2001 20:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136254AbRAHBFn>; Sun, 7 Jan 2001 20:05:43 -0500
Received: from mofo.meme.com ([64.1.120.129]:9344 "EHLO mofo.meme.com")
	by vger.kernel.org with ESMTP id <S136225AbRAHBFc>;
	Sun, 7 Jan 2001 20:05:32 -0500
Date: Sun, 7 Jan 2001 19:07:28 -0600
Message-Id: <200101080107.TAA01299@mofo.meme.com>
To: linux-kernel@vger.kernel.org
From: "Karl O. Pinc" <kop@meme.com>
Cc: C.Pollmeier@gmx.net, lpp@freelords.org
Subject: Bug: Frame-buffer (icon) rotates right in 2.4.0 when SMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apoligies in advance if this is not the right place to send this
report.

When displaying a screen-wide icon in the frame buffer for the
graphics console:

Linux version 2.4.0

Console Drivers
  Video mode selection support
    Support for frame buffer devices (EXPERMENTAL)
      VESA VGA graphics console

I found the right edge of the image to be displayed on the left edge
-- perhaps 8 pixels worth?

I compiled for a pentium III, SMP on.  I've a dual processor Pentium
III with a Matrox Graphics, Inc. MGA G400 AGP video card.  I
discovered this using the lpp-0.2.0 patch at http://lpp.freelords.org,
which displays a startup screen.

Fix:  turning SMP off fixed the problem.

FYI: fbcon_show_logo() in drivers/video/fbcon.c seems to have a for
loop with an odd smp_num_cpus reference.

Please contact me if you need any more information or wish to tell me
where to send this report.

Regards,

Karl <kop@meme.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
