Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbUJYB5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbUJYB5e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUJYB4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:56:31 -0400
Received: from thunk.org ([69.25.196.29]:65441 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261661AbUJYB4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:56:23 -0400
To: perex@suse.cz
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH][Trivial] sound/pci/intel8x0.c: Fix dangling #endif
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1CLu5Z-0007L4-Na@thunk.org>
Date: Sun, 24 Oct 2004 21:56:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following changeset:

	ChangeSet@1.1757.1.270, 2004-10-23 10:31:03+02:00, perex@suse.cz
	  Merge

apparently nuked joystick support in sound/pci/intel8x0.c (whether or
not this was deliberate is not clear) but did so in a way that left the
intel8x0.c file broken with a dangling #endif.  The following patch
allows the driver to compile again.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>

--- 1.125/sound/pci/intel8x0.c  2004-10-23 05:12:56 -04:00
+++ edited/sound/pci/intel8x0.c 2004-10-24 21:34:10 -04:00
@@ -69,7 +69,6 @@
 static int ac97_quirk[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = AC97_TUNE_DEFAULT};
 static int buggy_irq[SNDRV_CARDS];
 static int xbox[SNDRV_CARDS];
-#endif
 #ifdef SUPPORT_MIDI
 static int mpu_port[SNDRV_CARDS]; /* disabled */
 #endif


