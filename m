Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbTCDHxm>; Tue, 4 Mar 2003 02:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269319AbTCDHxm>; Tue, 4 Mar 2003 02:53:42 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:32004 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S269318AbTCDHxl>;
	Tue, 4 Mar 2003 02:53:41 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs/mount.c missing include
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 04 Mar 2003 03:04:02 -0500
Message-ID: <m3n0kb8snh.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mount.c:sysfs_init() is marked __init but linux/init.h is not #included.

-JimC

 fs/sysfs/mount.c |    1 +
 1 files changed, 1 insertion(+)

diff -Nru a/fs/sysfs/mount.c b/fs/sysfs/mount.c
--- a/fs/sysfs/mount.c	Tue Mar  4 02:58:57 2003
+++ b/fs/sysfs/mount.c	Tue Mar  4 02:58:57 2003
@@ -5,6 +5,7 @@
 #define DEBUG 
 
 #include <linux/fs.h>
+#include <linux/init.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 

