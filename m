Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWERMT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWERMT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 08:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWERMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 08:19:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31438 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751319AbWERMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 08:19:26 -0400
Date: Thu, 18 May 2006 14:18:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul.Clements@steeleye.com, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] nbd: kill obsolete changelog, add GPL
Message-ID: <20060518121839.GA2187@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nbd abuses file header as a changelog (and obsolete one, too), and
fails to mention GPL. This fixes it.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8bca490..7f554f2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -7,39 +7,9 @@
  * Copyright 1997-2000 Pavel Machek <pavel@ucw.cz>
  * Parts copyright 2001 Steven Whitehouse <steve@chygwyn.com>
  *
- * (part of code stolen from loop.c)
+ * This file is released under GPLv2 or later.
  *
- * 97-3-25 compiled 0-th version, not yet tested it 
- *   (it did not work, BTW) (later that day) HEY! it works!
- *   (bit later) hmm, not that much... 2:00am next day:
- *   yes, it works, but it gives something like 50kB/sec
- * 97-4-01 complete rewrite to make it possible for many requests at 
- *   once to be processed
- * 97-4-11 Making protocol independent of endianity etc.
- * 97-9-13 Cosmetic changes
- * 98-5-13 Attempt to make 64-bit-clean on 64-bit machines
- * 99-1-11 Attempt to make 64-bit-clean on 32-bit machines <ankry@mif.pg.gda.pl>
- * 01-2-27 Fix to store proper blockcount for kernel (calculated using
- *   BLOCK_SIZE_BITS, not device blocksize) <aga@permonline.ru>
- * 01-3-11 Make nbd work with new Linux block layer code. It now supports
- *   plugging like all the other block devices. Also added in MSG_MORE to
- *   reduce number of partial TCP segments sent. <steve@chygwyn.com>
- * 01-12-6 Fix deadlock condition by making queue locks independent of
- *   the transmit lock. <steve@chygwyn.com>
- * 02-10-11 Allow hung xmit to be aborted via SIGKILL & various fixes.
- *   <Paul.Clements@SteelEye.com> <James.Bottomley@SteelEye.com>
- * 03-06-22 Make nbd work with new linux 2.5 block layer design. This fixes
- *   memory corruption from module removal and possible memory corruption
- *   from sending/receiving disk data. <ldl@aros.net>
- * 03-06-23 Cosmetic changes. <ldl@aros.net>
- * 03-06-23 Enhance diagnostics support. <ldl@aros.net>
- * 03-06-24 Remove unneeded blksize_bits field from nbd_device struct.
- *   <ldl@aros.net>
- * 03-06-24 Cleanup PARANOIA usage & code. <ldl@aros.net>
- * 04-02-19 Remove PARANOIA, plus various cleanups (Paul Clements)
- * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
- * why not: would need access_ok and friends, would share yet another
- *          structure with userland
+ * (part of code stolen from loop.c)
  */
 
 #include <linux/major.h>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
