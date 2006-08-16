Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWHPMJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHPMJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHPMJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:09:32 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:37471 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751133AbWHPMJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:09:32 -0400
Date: Wed, 16 Aug 2006 14:09:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: empty function defines.
Message-ID: <20060816120928.GF24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] empty function defines.

Use do { } while (0) constructs instead of empty defines to avoid
subtle compile bugs.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.h      |   16 ++++++++--------
 drivers/s390/net/iucv.c      |    4 ++--
 drivers/s390/scsi/zfcp_def.h |    8 ++++----
 include/asm-s390/dma.h       |    2 +-
 include/asm-s390/io.h        |    2 +-
 include/asm-s390/smp.h       |    2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2006-08-16 13:36:49.000000000 +0200
@@ -191,49 +191,49 @@ enum qdio_irq_states {
 #if QDIO_VERBOSE_LEVEL>8
 #define QDIO_PRINT_STUPID(x...) printk( KERN_DEBUG QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_STUPID(x...)
+#define QDIO_PRINT_STUPID(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>7
 #define QDIO_PRINT_ALL(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_ALL(x...)
+#define QDIO_PRINT_ALL(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>6
 #define QDIO_PRINT_INFO(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_INFO(x...)
+#define QDIO_PRINT_INFO(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>5
 #define QDIO_PRINT_WARN(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_WARN(x...)
+#define QDIO_PRINT_WARN(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>4
 #define QDIO_PRINT_ERR(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_ERR(x...)
+#define QDIO_PRINT_ERR(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>3
 #define QDIO_PRINT_CRIT(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_CRIT(x...)
+#define QDIO_PRINT_CRIT(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>2
 #define QDIO_PRINT_ALERT(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_ALERT(x...)
+#define QDIO_PRINT_ALERT(x...) do { } while (0)
 #endif
 
 #if QDIO_VERBOSE_LEVEL>1
 #define QDIO_PRINT_EMERG(x...) printk( QDIO_PRINTK_HEADER x)
 #else
-#define QDIO_PRINT_EMERG(x...)
+#define QDIO_PRINT_EMERG(x...) do { } while (0)
 #endif
 
 #define HEXDUMP16(importance,header,ptr) \
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2006-08-16 13:36:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2006-08-16 13:36:49.000000000 +0200
@@ -335,8 +335,8 @@ do { \
 
 #else
 
-#define iucv_debug(lvl, fmt, args...)
-#define iucv_dumpit(title, buf, len)
+#define iucv_debug(lvl, fmt, args...)	do { } while (0)
+#define iucv_dumpit(title, buf, len)	do { } while (0)
 
 #endif
 
diff -urpN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2006-08-16 13:36:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2006-08-16 13:36:49.000000000 +0200
@@ -543,7 +543,7 @@ do { \
 } while (0)
 	
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_NORMAL
-# define ZFCP_LOG_NORMAL(fmt, args...)
+# define ZFCP_LOG_NORMAL(fmt, args...)	do { } while (0)
 #else
 # define ZFCP_LOG_NORMAL(fmt, args...) \
 do { \
@@ -553,7 +553,7 @@ do { \
 #endif
 
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_INFO
-# define ZFCP_LOG_INFO(fmt, args...)
+# define ZFCP_LOG_INFO(fmt, args...)	do { } while (0)
 #else
 # define ZFCP_LOG_INFO(fmt, args...) \
 do { \
@@ -563,14 +563,14 @@ do { \
 #endif
 
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_DEBUG
-# define ZFCP_LOG_DEBUG(fmt, args...)
+# define ZFCP_LOG_DEBUG(fmt, args...)	do { } while (0)
 #else
 # define ZFCP_LOG_DEBUG(fmt, args...) \
 	ZFCP_LOG(ZFCP_LOG_LEVEL_DEBUG, fmt , ##args)
 #endif
 
 #if ZFCP_LOG_LEVEL_LIMIT < ZFCP_LOG_LEVEL_TRACE
-# define ZFCP_LOG_TRACE(fmt, args...)
+# define ZFCP_LOG_TRACE(fmt, args...)	do { } while (0)
 #else
 # define ZFCP_LOG_TRACE(fmt, args...) \
 	ZFCP_LOG(ZFCP_LOG_LEVEL_TRACE, fmt , ##args)
diff -urpN linux-2.6/include/asm-s390/dma.h linux-2.6-patched/include/asm-s390/dma.h
--- linux-2.6/include/asm-s390/dma.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/dma.h	2006-08-16 13:36:49.000000000 +0200
@@ -11,6 +11,6 @@
 
 #define MAX_DMA_ADDRESS         0x80000000
 
-#define free_dma(x)
+#define free_dma(x)	do { } while (0)
 
 #endif /* _ASM_DMA_H */
diff -urpN linux-2.6/include/asm-s390/io.h linux-2.6-patched/include/asm-s390/io.h
--- linux-2.6/include/asm-s390/io.h	2006-08-16 13:36:16.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/io.h	2006-08-16 13:36:49.000000000 +0200
@@ -116,7 +116,7 @@ extern void iounmap(void *addr);
 #define outb(x,addr) ((void) writeb(x,addr))
 #define outb_p(x,addr) outb(x,addr)
 
-#define mmiowb()
+#define mmiowb()	do { } while (0)
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
diff -urpN linux-2.6/include/asm-s390/smp.h linux-2.6-patched/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	2006-08-16 13:36:16.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/smp.h	2006-08-16 13:36:49.000000000 +0200
@@ -104,7 +104,7 @@ smp_call_function_on(void (*func) (void 
 #define smp_cpu_not_running(cpu)	1
 #define smp_get_cpu(cpu) ({ 0; })
 #define smp_put_cpu(cpu) ({ 0; })
-#define smp_setup_cpu_possible_map()
+#define smp_setup_cpu_possible_map()	do { } while (0)
 #endif
 
 #endif
