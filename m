Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289689AbSAOWCe>; Tue, 15 Jan 2002 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289692AbSAOWCY>; Tue, 15 Jan 2002 17:02:24 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:12294 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289689AbSAOWCP>; Tue, 15 Jan 2002 17:02:15 -0500
Date: Tue, 15 Jan 2002 22:02:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: New CRC32 fails to build (with JFFS2 builtin)
Message-ID: <20020115220208.A7897@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that crc32.o is not built when JFFS2 is built into the kernel.
The following patch fixes this problem.

Please apply.

--- orig/fs/Makefile.lib	Tue Jan 15 14:16:23 2002
+++ linux/fs/Makefile.lib	Tue Jan 15 21:56:40 2002
@@ -1,2 +1,2 @@
-obj-$(CONFIG_FS_JFFS2)		+= crc32.o
+obj-$(CONFIG_JFFS2_FS)		+= crc32.o
 obj-$(CONFIG_EFI_PARTITION)	+= crc32.o

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

