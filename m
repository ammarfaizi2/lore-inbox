Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313584AbSDQT1C>; Wed, 17 Apr 2002 15:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313582AbSDQT1B>; Wed, 17 Apr 2002 15:27:01 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:2329 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313584AbSDQT1A>; Wed, 17 Apr 2002 15:27:00 -0400
Subject: [2.5.9-patchlet] missing include file in lib/radix-tree.c
To: torvalds@transmeta.com
Date: Wed, 17 Apr 2002 20:26:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xv51-0001wt-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply below patchlet which adds a missing #include <linux/string.h>
to lib/radix-tree.c. Without this, gcc emits "implicit declaration of
function memset" warning.

Patch is tested. (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- radix.patch ---
--- linux-2.5.9/lib/radix-tree.c	Wed Apr 17 20:02:17 2002
+++ linux-2.5.9-aia/lib/radix-tree.c	Wed Apr 17 20:06:41 2002
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/radix-tree.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 /*
  * Radix tree node definition.
