Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135428AbRAGDLA>; Sat, 6 Jan 2001 22:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135521AbRAGDKu>; Sat, 6 Jan 2001 22:10:50 -0500
Received: from linux.sisa.be ([194.88.100.134]:5381 "HELO socrates.sisa.be")
	by vger.kernel.org with SMTP id <S135428AbRAGDKi>;
	Sat, 6 Jan 2001 22:10:38 -0500
Message-ID: <20010107031038.7029.qmail@mail.mind.be>
Date: Sun, 7 Jan 2001 04:10:38 +0100 (CET)
From: Dag Wieers <dag@mind.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Typo in drivers/video/vesafb.c for 2.4.0-ac3
User-Agent: Mutt/1.2i
X-Mailer: Evolution 1.0 (Stable release)
Organization: Mind Linux Solutions in Leuven/Belgium - http://mind.be/
X-Extra: If you can read this and Linux is your thing. Work for us !
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Due to a typo in vesafb_init, compiling failes.

Here's more information:

--- drivers/video/vesafb.c.orig Sun Jan  7 03:59:45 2001
+++ drivers/video/vesafb.c      Sun Jan  7 03:59:52 2001
@@ -637,7 +637,7 @@
                int temp_size = video_size;
                /* Find the largest power-of-two */
                while (temp_size & (temp_size - 1))
-                       temp_sze &= (temp_size - 1);
+                       temp_size &= (temp_size - 1);

                 /* Try and find a power of two to add */
                while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {

--  dag wieers, <dag@mind.be>, http://mind.be/  --
            Out of swap, out of luck.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
