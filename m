Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSDPKWP>; Tue, 16 Apr 2002 06:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311641AbSDPKWO>; Tue, 16 Apr 2002 06:22:14 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:16091 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S293458AbSDPKWN>; Tue, 16 Apr 2002 06:22:13 -0400
Subject: [2.4.19-pre7 bkpatch] Fix LDM compilation.
To: marcelo@conectiva.com.br
Date: Tue, 16 Apr 2002 11:22:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16xQ6C-0006P6-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please apply below patch which fixes LDM compilation in 2.4.19-pre7 (there
is a missing header file include).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- ldm-2.4.patch ---
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.417   -> 1.418  
#	 fs/partitions/ldm.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/16	aia21@cam.ac.uk	1.418
# LDM: Add missing include.
# --------------------------------------------
#
diff -Nru a/fs/partitions/ldm.c b/fs/partitions/ldm.c
--- a/fs/partitions/ldm.c	Tue Apr 16 11:18:59 2002
+++ b/fs/partitions/ldm.c	Tue Apr 16 11:18:59 2002
@@ -29,6 +29,7 @@
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>
 #include "check.h"
 #include "ldm.h"
 #include "msdos.h"

