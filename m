Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbTFWSna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbTFWSn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:43:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59889 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266095AbTFWSnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:43:23 -0400
Date: Mon, 23 Jun 2003 20:57:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Richard Russon <ldm@flatcap.org>, Anton Altaparmakov <aia21@cantab.net>,
       Jakob Kemi <jakob.kemi@telia.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] postfix two ldm.h constants with ULL
Message-ID: <20030623185722.GI3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes two constants in fs/partitions/ldm.h that are 
on 32 bit archs too big for an int with ULL.

cu
Adrian

--- linux-2.5.73-not-full/fs/partitions/ldm.h.old	2003-06-23 20:53:02.000000000 +0200
+++ linux-2.5.73-not-full/fs/partitions/ldm.h	2003-06-23 20:53:25.000000000 +0200
@@ -38,8 +38,8 @@
 /* Magic numbers in CPU format. */
 #define MAGIC_VMDB	0x564D4442		/* VMDB */
 #define MAGIC_VBLK	0x56424C4B		/* VBLK */
-#define MAGIC_PRIVHEAD	0x5052495648454144	/* PRIVHEAD */
-#define MAGIC_TOCBLOCK	0x544F43424C4F434B	/* TOCBLOCK */
+#define MAGIC_PRIVHEAD	0x5052495648454144ULL	/* PRIVHEAD */
+#define MAGIC_TOCBLOCK	0x544F43424C4F434BULL	/* TOCBLOCK */
 
 /* The defined vblk types. */
 #define VBLK_VOL5		0x51		/* Volume,     version 5 */
