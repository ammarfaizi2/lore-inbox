Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265656AbTABFqB>; Thu, 2 Jan 2003 00:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbTABFqB>; Thu, 2 Jan 2003 00:46:01 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:50823 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265656AbTABFqA>; Thu, 2 Jan 2003 00:46:00 -0500
Date: Wed, 1 Jan 2003 21:53:43 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: chexum@shadow.banki.hu, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.54/fs/romfs/inode.c compilation fix
Message-ID: <20030101215343.A10139@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.54/fs/romfs/inode.c needs to include <asm/statfs.h>
(which is new to 2.5.54) to compile again.  Here is the one line
patch.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="romfs.diff"

--- linux-2.5.54/fs/romfs/inode.c	2003-01-01 19:22:29.000000000 -0800
+++ linux/fs/romfs/inode.c	2003-01-01 21:49:37.000000000 -0800
@@ -75,6 +75,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
+#include <asm/statfs.h>
 #include <asm/uaccess.h>
 
 struct romfs_inode_info {

--4Ckj6UjgE2iN1+kY--
