Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWBHDR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWBHDR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBHDR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:17:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54656 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751132AbWBHDR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:17:58 -0500
To: torvalds@osdl.org
Subject: [PATCH 01/29] remove bogus asm/bug.h includes.
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fq8-0006BE-Uq@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:17:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1134626823 -0500

A bunch of asm/bug.h includes are both not needed (since it will get
pulled anyway) and bogus (since they are done too early).  Removed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 crypto/scatterwalk.c                |    1 -
 drivers/cdrom/viocd.c               |    2 --
 drivers/net/hamradio/baycom_par.c   |    1 -
 drivers/tc/tc.c                     |    1 -
 drivers/video/backlight/backlight.c |    1 -
 drivers/video/backlight/lcd.c       |    1 -
 drivers/video/pmag-ba-fb.c          |    1 -
 drivers/video/pmagb-b-fb.c          |    1 -
 fs/reiserfs/hashes.c                |    1 -
 include/asm-mips/io.h               |    1 -
 include/asm-powerpc/dma-mapping.h   |    1 -
 include/linux/cpumask.h             |    1 -
 include/linux/dcache.h              |    1 -
 include/linux/jbd.h                 |    1 -
 include/linux/mtd/map.h             |    1 -
 include/linux/nodemask.h            |    1 -
 include/linux/smp.h                 |    1 -
 kernel/compat.c                     |    1 -
 net/dccp/ccids/lib/tfrc_equation.c  |    1 -
 net/ipv4/xfrm4_policy.c             |    1 -
 net/ipv6/raw.c                      |    1 -
 net/ipv6/xfrm6_policy.c             |    1 -
 net/xfrm/xfrm_policy.c              |    1 -
 23 files changed, 0 insertions(+), 24 deletions(-)

1b8623545b42c03eb92e51b28c84acf4b8ba00a3
diff --git a/crypto/scatterwalk.c b/crypto/scatterwalk.c
index 47ac90e..2953e2c 100644
--- a/crypto/scatterwalk.c
+++ b/crypto/scatterwalk.c
@@ -17,7 +17,6 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
-#include <asm/bug.h>
 #include <asm/scatterlist.h>
 #include "internal.h"
 #include "scatterwalk.h"
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index 193446e..e276172 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -42,8 +42,6 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
-#include <asm/bug.h>
-
 #include <asm/vio.h>
 #include <asm/scatterlist.h>
 #include <asm/iseries/hv_types.h>
diff --git a/drivers/net/hamradio/baycom_par.c b/drivers/net/hamradio/baycom_par.c
index 3b1bef1..77411a0 100644
--- a/drivers/net/hamradio/baycom_par.c
+++ b/drivers/net/hamradio/baycom_par.c
@@ -86,7 +86,6 @@
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
 
-#include <asm/bug.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
diff --git a/drivers/tc/tc.c b/drivers/tc/tc.c
index a0e5af6..4a51e56 100644
--- a/drivers/tc/tc.c
+++ b/drivers/tc/tc.c
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
-#include <asm/bug.h>
 #include <asm/errno.h>
 #include <asm/io.h>
 #include <asm/paccess.h>
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 9d5015e..bd39bbd 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -13,7 +13,6 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/fb.h>
-#include <asm/bug.h>
 
 static ssize_t backlight_show_power(struct class_device *cdev, char *buf)
 {
diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 68c6906..9e32485 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -13,7 +13,6 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/fb.h>
-#include <asm/bug.h>
 
 static ssize_t lcd_show_power(struct class_device *cdev, char *buf)
 {
diff --git a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
index f3927b6..f5361cd 100644
--- a/drivers/video/pmag-ba-fb.c
+++ b/drivers/video/pmag-ba-fb.c
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-#include <asm/bug.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
diff --git a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
index 25148de..eeeac92 100644
--- a/drivers/video/pmagb-b-fb.c
+++ b/drivers/video/pmagb-b-fb.c
@@ -27,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-#include <asm/bug.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
diff --git a/fs/reiserfs/hashes.c b/fs/reiserfs/hashes.c
index a3ec238..e664ac1 100644
--- a/fs/reiserfs/hashes.c
+++ b/fs/reiserfs/hashes.c
@@ -21,7 +21,6 @@
 #include <linux/kernel.h>
 #include <linux/reiserfs_fs.h>
 #include <asm/types.h>
-#include <asm/bug.h>
 
 #define DELTA 0x9E3779B9
 #define FULLROUNDS 10		/* 32 is overkill, 16 is strong crypto */
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index d426857..a9fa125 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -18,7 +18,6 @@
 #include <linux/types.h>
 
 #include <asm/addrspace.h>
-#include <asm/bug.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 837756a..2ac63f5 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -15,7 +15,6 @@
 #include <linux/mm.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
-#include <asm/bug.h>
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 13e9f4a..20b446f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -84,7 +84,6 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
-#include <asm/bug.h>
 
 typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
 extern cpumask_t _unused_cpumask_arg_;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a3f0994..4361f37 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -8,7 +8,6 @@
 #include <linux/spinlock.h>
 #include <linux/cache.h>
 #include <linux/rcupdate.h>
-#include <asm/bug.h>
 
 struct nameidata;
 struct vfsmount;
diff --git a/include/linux/jbd.h b/include/linux/jbd.h
index 751bb38..0fe4aa8 100644
--- a/include/linux/jbd.h
+++ b/include/linux/jbd.h
@@ -239,7 +239,6 @@ typedef struct journal_superblock_s
 
 #include <linux/fs.h>
 #include <linux/sched.h>
-#include <asm/bug.h>
 
 #define JBD_ASSERTIONS
 #ifdef JBD_ASSERTIONS
diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index fedfbc8..7dfd6e1 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -15,7 +15,6 @@
 #include <asm/unaligned.h>
 #include <asm/system.h>
 #include <asm/io.h>
-#include <asm/bug.h>
 
 #ifdef CONFIG_MTD_MAP_BANK_WIDTH_1
 #define map_bankwidth(map) 1
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 4726ef7..b959a45 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -84,7 +84,6 @@
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/numa.h>
-#include <asm/bug.h>
 
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9dfa3ee..44153fd 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -17,7 +17,6 @@ extern void cpu_idle(void);
 #include <linux/compiler.h>
 #include <linux/thread_info.h>
 #include <asm/smp.h>
-#include <asm/bug.h>
 
 /*
  * main cross-CPU interfaces, handles INIT, TLB flush, STOP, etc.
diff --git a/kernel/compat.c b/kernel/compat.c
index 1867290..8c9cd88 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -23,7 +23,6 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
-#include <asm/bug.h>
 
 int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
 {
diff --git a/net/dccp/ccids/lib/tfrc_equation.c b/net/dccp/ccids/lib/tfrc_equation.c
index d2b5933..add3cae 100644
--- a/net/dccp/ccids/lib/tfrc_equation.c
+++ b/net/dccp/ccids/lib/tfrc_equation.c
@@ -15,7 +15,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
-#include <asm/bug.h>
 #include <asm/div64.h>
 
 #include "tfrc.h"
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 42196ba..45f7ae5 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -8,7 +8,6 @@
  * 	
  */
 
-#include <asm/bug.h>
 #include <linux/compiler.h>
 #include <linux/config.h>
 #include <linux/inetdevice.h>
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 66f1d12..738376c 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -35,7 +35,6 @@
 #include <linux/skbuff.h>
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
-#include <asm/bug.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 69bd957..91cce8b 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -11,7 +11,6 @@
  * 
  */
 
-#include <asm/bug.h>
 #include <linux/compiler.h>
 #include <linux/config.h>
 #include <linux/netdevice.h>
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 077bbf9..dbf4620 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -13,7 +13,6 @@
  *
  */
 
-#include <asm/bug.h>
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
-- 
0.99.9.GIT

