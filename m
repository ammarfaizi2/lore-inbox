Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSLPTlH>; Mon, 16 Dec 2002 14:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSLPTlH>; Mon, 16 Dec 2002 14:41:07 -0500
Received: from mg01.austin.ibm.com ([192.35.232.18]:15343 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261295AbSLPTkz>; Mon, 16 Dec 2002 14:40:55 -0500
Subject: Re: [PATCH] BIN_TO_BCD consolidation
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1040064165.10740.31.camel@granite.austin.ibm.com>
References: <1040064165.10740.31.camel@granite.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 13:53:52 -0600
Message-Id: <1040068432.1100.45.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:
> 
> Has anyone else noticed the number of BCD_TO_BIN / BIN_TO_BCD
> definitions?

This is the updated version. Some users had already redefined the BCD
macros to not make assignments, but kept the same name.

-Hollis
-- 
PowerPC Linux
IBM Linux Technology Center

 arch/alpha/kernel/time.c              |    1
 arch/arm/kernel/time.c                |    8 -------
 arch/cris/drivers/ds1302.c            |    1
 arch/cris/kernel/time.c               |    1
 arch/i386/kernel/time.c               |    1
 arch/m68k/atari/time.c                |    1
 arch/m68k/sun3x/time.c                |   32 +++++++++++++----------------
 arch/mips/ddb5xxx/common/rtc_ds1386.c |   37 ++++++++++++++--------------------
 arch/mips/dec/time.c                  |    1
 arch/mips/kernel/old-time.c           |    1
 arch/mips64/sgi-ip27/ip27-rtc.c       |    1
 arch/mips64/sgi-ip27/ip27-timer.c     |    1
 arch/ppc/iSeries/mf.c                 |    1
 arch/ppc/platforms/chrp_time.c        |    1
 arch/ppc/platforms/gemini_setup.c     |    1
 arch/ppc/platforms/prep_time.c        |    1
 arch/ppc/syslib/todc_time.c           |    1
 arch/ppc64/kernel/mf.c                |    1
 arch/ppc64/kernel/rtc.c               |    1
 arch/sh/kernel/rtc.c                  |    9 --------
 arch/sparc64/kernel/time.c            |    9 --------
 arch/x86_64/kernel/time.c             |    1
 drivers/acorn/char/pcf8583.c          |    1
 drivers/acpi/sleep.c                  |    1
 drivers/char/rtc.c                    |    1
 drivers/scsi/sr_vendor.c              |   15 ++++++-------
 drivers/sgi/char/ds1286.c             |    1
 include/asm-arm/arch-ebsa285/time.h   |    1
 include/asm-cris/rtc.h                |    5 ----
 include/asm-generic/rtc.h             |    1
 include/asm-mips/ds1286.h             |   11 ----------
 include/asm-mips64/ds1286.h           |   11 ----------
 include/asm-mips64/m48t35.h           |    8 -------
 include/asm-ppc/m48t35.h              |    9 --------
 include/asm-ppc/mk48t59.h             |    8 -------
 include/asm-ppc/nvram.h               |    8 -------
 include/asm-ppc/todc.h                |    8 -------
 include/asm-ppc64/nvram.h             |    8 -------
 include/linux/bcd.h                   |   20 ++++++++++++++++++
 include/linux/mc146818rtc.h           |   11 ----------
 40 files changed, 83 insertions(+), 157 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.744   -> 1.746  
#	include/asm-ppc/m48t35.h	1.5     -> 1.6    
#	drivers/acpi/sleep.c	1.8     -> 1.9    
#	arch/ppc/platforms/chrp_time.c	1.7     -> 1.8    
#	include/asm-cris/rtc.h	1.2     -> 1.3    
#	include/asm-ppc/mk48t59.h	1.4     -> 1.5    
#	drivers/sgi/char/ds1286.c	1.6     -> 1.7    
#	arch/mips64/sgi-ip27/ip27-timer.c	1.3     -> 1.4    
#	  drivers/char/rtc.c	1.18    -> 1.19   
#	include/asm-ppc64/nvram.h	1.2     -> 1.3    
#	include/asm-generic/rtc.h	1.1     -> 1.2    
#	arch/ppc/iSeries/mf.c	1.2     -> 1.3    
#	arch/mips64/sgi-ip27/ip27-rtc.c	1.5     -> 1.6    
#	drivers/scsi/sr_vendor.c	1.10    -> 1.12   
#	arch/i386/kernel/time.c	1.22    -> 1.23   
#	arch/ppc/platforms/prep_time.c	1.7     -> 1.8    
#	arch/sparc64/kernel/time.c	1.18    -> 1.19   
#	include/asm-mips64/m48t35.h	1.1     -> 1.2    
#	arch/ppc/platforms/gemini_setup.c	1.12    -> 1.13   
#	arch/alpha/kernel/time.c	1.11    -> 1.12   
#	arch/cris/kernel/time.c	1.6     -> 1.7    
#	arch/ppc64/kernel/rtc.c	1.3     -> 1.4    
#	include/asm-mips/ds1286.h	1.1     -> 1.2    
#	arch/m68k/sun3x/time.c	1.4     -> 1.6    
#	include/asm-mips64/ds1286.h	1.2     -> 1.3    
#	arch/x86_64/kernel/time.c	1.5     -> 1.6    
#	arch/arm/kernel/time.c	1.11    -> 1.12   
#	arch/mips/kernel/old-time.c	1.3     -> 1.4    
#	arch/ppc64/kernel/mf.c	1.3     -> 1.4    
#	include/asm-ppc/todc.h	1.1     -> 1.2    
#	arch/ppc/syslib/todc_time.c	1.4     -> 1.5    
#	arch/m68k/atari/time.c	1.3     -> 1.4    
#	arch/mips/dec/time.c	1.2     -> 1.3    
#	arch/mips/ddb5xxx/common/rtc_ds1386.c	1.1     -> 1.3    
#	include/linux/mc146818rtc.h	1.2     -> 1.3    
#	arch/sh/kernel/rtc.c	1.5     -> 1.6    
#	arch/cris/drivers/ds1302.c	1.4     -> 1.5    
#	drivers/acorn/char/pcf8583.c	1.5     -> 1.6    
#	include/asm-ppc/nvram.h	1.4     -> 1.5    
#	include/asm-arm/arch-ebsa285/time.h	1.5     -> 1.6    
#	               (new)	        -> 1.1     include/linux/bcd.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/12	hollis@granite.austin.ibm.com	1.745
# consolidate all the BCD_TO_BIN / BIN_TO_BCD definitions into bcd.h
# --------------------------------------------
# 02/12/16	hollis@granite.austin.ibm.com	1.746
# some people had already redefined the old BCD macros without the
# assignment. fix those places to use the new bcd.h
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/alpha/kernel/time.c	Mon Dec 16 13:49:27 2002
@@ -37,6 +37,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
diff -Nru a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
--- a/arch/arm/kernel/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/arm/kernel/time.c	Mon Dec 16 13:49:27 2002
@@ -47,14 +47,6 @@
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY	(1000000/HZ)
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 static int dummy_set_rtc(void)
 {
 	return 0;
diff -Nru a/arch/cris/drivers/ds1302.c b/arch/cris/drivers/ds1302.c
--- a/arch/cris/drivers/ds1302.c	Mon Dec 16 13:49:27 2002
+++ b/arch/cris/drivers/ds1302.c	Mon Dec 16 13:49:27 2002
@@ -97,6 +97,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/delay.h>
+#include <linux/bcd.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
diff -Nru a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
--- a/arch/cris/kernel/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/cris/kernel/time.c	Mon Dec 16 13:49:27 2002
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/delay.h>
+#include <linux/bcd.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/i386/kernel/time.c	Mon Dec 16 13:49:27 2002
@@ -43,6 +43,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/bcd.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
diff -Nru a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
--- a/arch/m68k/atari/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/m68k/atari/time.c	Mon Dec 16 13:49:27 2002
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
 
 #include <asm/rtc.h>
 
diff -Nru a/arch/m68k/sun3x/time.c b/arch/m68k/sun3x/time.c
--- a/arch/m68k/sun3x/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/m68k/sun3x/time.c	Mon Dec 16 13:49:27 2002
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -36,9 +37,6 @@
 #define C_SIGN    0x20
 #define C_CALIB   0x1f
 
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#define BIN_TO_BCD(val) (((val/10) << 4) | (val % 10))
-
 int sun3x_hwclk(int set, struct rtc_time *t)
 {
 	volatile struct mostek_dt *h = 
@@ -49,23 +47,23 @@
 	
 	if(set) {
 		h->csr |= C_WRITE;
-		h->sec = BIN_TO_BCD(t->tm_sec);
-		h->min = BIN_TO_BCD(t->tm_min);
-		h->hour = BIN_TO_BCD(t->tm_hour);
-		h->wday = BIN_TO_BCD(t->tm_wday);
-		h->mday = BIN_TO_BCD(t->tm_mday);
-		h->month = BIN_TO_BCD(t->tm_mon);
-		h->year = BIN_TO_BCD(t->tm_year);
+		h->sec = BIN2BCD(t->tm_sec);
+		h->min = BIN2BCD(t->tm_min);
+		h->hour = BIN2BCD(t->tm_hour);
+		h->wday = BIN2BCD(t->tm_wday);
+		h->mday = BIN2BCD(t->tm_mday);
+		h->month = BIN2BCD(t->tm_mon);
+		h->year = BIN2BCD(t->tm_year);
 		h->csr &= ~C_WRITE;
 	} else {
 		h->csr |= C_READ;
-		t->tm_sec = BCD_TO_BIN(h->sec);
-		t->tm_min = BCD_TO_BIN(h->min);
-		t->tm_hour = BCD_TO_BIN(h->hour);
-		t->tm_wday = BCD_TO_BIN(h->wday);
-		t->tm_mday = BCD_TO_BIN(h->mday);
-		t->tm_mon = BCD_TO_BIN(h->month);
-		t->tm_year = BCD_TO_BIN(h->year);
+		t->tm_sec = BCD2BIN(h->sec);
+		t->tm_min = BCD2BIN(h->min);
+		t->tm_hour = BCD2BIN(h->hour);
+		t->tm_wday = BCD2BIN(h->wday);
+		t->tm_mday = BCD2BIN(h->mday);
+		t->tm_mon = BCD2BIN(h->month);
+		t->tm_year = BCD2BIN(h->year);
 		h->csr &= ~C_READ;
 	}
 
diff -Nru a/arch/mips/ddb5xxx/common/rtc_ds1386.c b/arch/mips/ddb5xxx/common/rtc_ds1386.c
--- a/arch/mips/ddb5xxx/common/rtc_ds1386.c	Mon Dec 16 13:49:27 2002
+++ b/arch/mips/ddb5xxx/common/rtc_ds1386.c	Mon Dec 16 13:49:27 2002
@@ -20,6 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 
 #include <asm/time.h>
 #include <asm/addrspace.h>
@@ -28,12 +29,6 @@
 
 #define	EPOCH		2000
 
-#undef BCD_TO_BIN
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-
-#undef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
-
 #define	READ_RTC(x)	*(volatile unsigned char*)(rtc_base+x)
 #define	WRITE_RTC(x, y)	*(volatile unsigned char*)(rtc_base+x) = y
 
@@ -52,11 +47,11 @@
 	WRITE_RTC(0xB, byte);
 
 	/* read time data */
-	year = BCD_TO_BIN(READ_RTC(0xA)) + EPOCH;
-	month = BCD_TO_BIN(READ_RTC(0x9) & 0x1f);
-	day = BCD_TO_BIN(READ_RTC(0x8));
-	minute = BCD_TO_BIN(READ_RTC(0x2));
-	second = BCD_TO_BIN(READ_RTC(0x1));
+	year = BCD2BIN(READ_RTC(0xA)) + EPOCH;
+	month = BCD2BIN(READ_RTC(0x9) & 0x1f);
+	day = BCD2BIN(READ_RTC(0x8));
+	minute = BCD2BIN(READ_RTC(0x2));
+	second = BCD2BIN(READ_RTC(0x1));
 
 	/* hour is special - deal with it later */
 	temp = READ_RTC(0x4);
@@ -68,11 +63,11 @@
 	/* calc hour */
 	if (temp & 0x40) {
 		/* 12 hour format */
-		hour = BCD_TO_BIN(temp & 0x1f);
+		hour = BCD2BIN(temp & 0x1f);
 		if (temp & 0x20) hour += 12; 		/* PM */
 	} else {
 		/* 24 hour format */
-		hour = BCD_TO_BIN(temp & 0x3f);
+		hour = BCD2BIN(temp & 0x3f);
 	}
 
 	return mktime(year, month, day, hour, minute, second);
@@ -95,19 +90,19 @@
 	to_tm(t, &tm);
 
 	/* check each field one by one */
-	year = BIN_TO_BCD(tm.tm_year - EPOCH);
+	year = BIN2BCD(tm.tm_year - EPOCH);
 	if (year != READ_RTC(0xA)) {
 		WRITE_RTC(0xA, year);
 	}
 
 	temp = READ_RTC(0x9);
-	month = BIN_TO_BCD(tm.tm_mon);
+	month = BIN2BCD(tm.tm_mon);
 	if (month != (temp & 0x1f)) {
 		WRITE_RTC( 0x9,
 			   (month & 0x1f) | (temp & ~0x1f) );
 	}
 
-	day = BIN_TO_BCD(tm.tm_mday);
+	day = BIN2BCD(tm.tm_mday);
 	if (day != READ_RTC(0x8)) {
 		WRITE_RTC(0x8, day);
 	}
@@ -117,22 +112,22 @@
 		/* 12 hour format */
 		hour = 0x40;
 		if (tm.tm_hour > 12) {
-			hour |= 0x20 | (BIN_TO_BCD(hour-12) & 0x1f);
+			hour |= 0x20 | (BIN2BCD(hour-12) & 0x1f);
 		} else {
-			hour |= BIN_TO_BCD(tm.tm_hour);
+			hour |= BIN2BCD(tm.tm_hour);
 		}
 	} else {
 		/* 24 hour format */
-		hour = BIN_TO_BCD(tm.tm_hour) & 0x3f;
+		hour = BIN2BCD(tm.tm_hour) & 0x3f;
 	}
 	if (hour != temp) WRITE_RTC(0x4, hour);
 
-	minute = BIN_TO_BCD(tm.tm_min);
+	minute = BIN2BCD(tm.tm_min);
 	if (minute != READ_RTC(0x2)) {
 		WRITE_RTC(0x2, minute);
 	}
 
-	second = BIN_TO_BCD(tm.tm_sec);
+	second = BIN2BCD(tm.tm_sec);
 	if (second != READ_RTC(0x1)) {
 		WRITE_RTC(0x1, second);
 	}
diff -Nru a/arch/mips/dec/time.c b/arch/mips/dec/time.c
--- a/arch/mips/dec/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/mips/dec/time.c	Mon Dec 16 13:49:27 2002
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/bcd.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
diff -Nru a/arch/mips/kernel/old-time.c b/arch/mips/kernel/old-time.c
--- a/arch/mips/kernel/old-time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/mips/kernel/old-time.c	Mon Dec 16 13:49:27 2002
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/bcd.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
diff -Nru a/arch/mips64/sgi-ip27/ip27-rtc.c b/arch/mips64/sgi-ip27/ip27-rtc.c
--- a/arch/mips64/sgi-ip27/ip27-rtc.c	Mon Dec 16 13:49:27 2002
+++ b/arch/mips64/sgi-ip27/ip27-rtc.c	Mon Dec 16 13:49:27 2002
@@ -35,6 +35,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/bcd.h>
 
 #include <asm/m48t35.h>
 #include <asm/sn/ioc3.h>
diff -Nru a/arch/mips64/sgi-ip27/ip27-timer.c b/arch/mips64/sgi-ip27/ip27-timer.c
--- a/arch/mips64/sgi-ip27/ip27-timer.c	Mon Dec 16 13:49:27 2002
+++ b/arch/mips64/sgi-ip27/ip27-timer.c	Mon Dec 16 13:49:27 2002
@@ -11,6 +11,7 @@
 #include <linux/param.h>
 #include <linux/timex.h>
 #include <linux/mm.h>		
+#include <linux/bcd.h>		
 
 #include <asm/pgtable.h>
 #include <asm/sgialib.h>
diff -Nru a/arch/ppc/iSeries/mf.c b/arch/ppc/iSeries/mf.c
--- a/arch/ppc/iSeries/mf.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc/iSeries/mf.c	Mon Dec 16 13:49:27 2002
@@ -40,6 +40,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
 #include <linux/pci.h>
+#include <linux/bcd.h>
 

 /*
diff -Nru a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc/platforms/chrp_time.c	Mon Dec 16 13:49:27 2002
@@ -20,6 +20,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
diff -Nru a/arch/ppc/platforms/gemini_setup.c b/arch/ppc/platforms/gemini_setup.c
--- a/arch/ppc/platforms/gemini_setup.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc/platforms/gemini_setup.c	Mon Dec 16 13:49:27 2002
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/bcd.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
diff -Nru a/arch/ppc/platforms/prep_time.c b/arch/ppc/platforms/prep_time.c
--- a/arch/ppc/platforms/prep_time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc/platforms/prep_time.c	Mon Dec 16 13:49:27 2002
@@ -19,6 +19,7 @@
 #include <linux/timex.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
 
 #include <asm/sections.h>
 #include <asm/segment.h>
diff -Nru a/arch/ppc/syslib/todc_time.c b/arch/ppc/syslib/todc_time.c
--- a/arch/ppc/syslib/todc_time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc/syslib/todc_time.c	Mon Dec 16 13:49:27 2002
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/bcd.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
diff -Nru a/arch/ppc64/kernel/mf.c b/arch/ppc64/kernel/mf.c
--- a/arch/ppc64/kernel/mf.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc64/kernel/mf.c	Mon Dec 16 13:49:27 2002
@@ -40,6 +40,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
 #include <linux/pci.h>
+#include <linux/bcd.h>
 
 extern struct pci_dev * iSeries_vio_dev;
 
diff -Nru a/arch/ppc64/kernel/rtc.c b/arch/ppc64/kernel/rtc.c
--- a/arch/ppc64/kernel/rtc.c	Mon Dec 16 13:49:27 2002
+++ b/arch/ppc64/kernel/rtc.c	Mon Dec 16 13:49:27 2002
@@ -32,6 +32,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/bcd.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -Nru a/arch/sh/kernel/rtc.c b/arch/sh/kernel/rtc.c
--- a/arch/sh/kernel/rtc.c	Mon Dec 16 13:49:27 2002
+++ b/arch/sh/kernel/rtc.c	Mon Dec 16 13:49:27 2002
@@ -9,17 +9,10 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 
 #include <asm/io.h>
 #include <asm/rtc.h>
-
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
 
 void sh_rtc_gettimeofday(struct timeval *tv)
 {
diff -Nru a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/sparc64/kernel/time.c	Mon Dec 16 13:49:27 2002
@@ -23,6 +23,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/delay.h>
 #include <linux/profile.h>
+#include <linux/bcd.h>
 
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -329,14 +330,6 @@
 
 	return (data1 == data2);	/* Was the write blocked? */
 }
-
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
-#endif
 
 /* Probe for the real time clock chip. */
 static void __init set_system_time(void)
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Mon Dec 16 13:49:27 2002
+++ b/arch/x86_64/kernel/time.c	Mon Dec 16 13:49:27 2002
@@ -21,6 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/bcd.h>
 #include <asm/vsyscall.h>
 #include <asm/timex.h>
 
diff -Nru a/drivers/acorn/char/pcf8583.c b/drivers/acorn/char/pcf8583.c
--- a/drivers/acorn/char/pcf8583.c	Mon Dec 16 13:49:27 2002
+++ b/drivers/acorn/char/pcf8583.c	Mon Dec 16 13:49:27 2002
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/mc146818rtc.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
 
 #include "pcf8583.h"
 
diff -Nru a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
--- a/drivers/acpi/sleep.c	Mon Dec 16 13:49:27 2002
+++ b/drivers/acpi/sleep.c	Mon Dec 16 13:49:27 2002
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
+#include <linux/bcd.h>
 
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
diff -Nru a/drivers/char/rtc.c b/drivers/char/rtc.c
--- a/drivers/char/rtc.c	Mon Dec 16 13:49:27 2002
+++ b/drivers/char/rtc.c	Mon Dec 16 13:49:27 2002
@@ -72,6 +72,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysctl.h>
 #include <linux/wait.h>
+#include <linux/bcd.h>
 
 #include <asm/current.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/scsi/sr_vendor.c b/drivers/scsi/sr_vendor.c
--- a/drivers/scsi/sr_vendor.c	Mon Dec 16 13:49:27 2002
+++ b/drivers/scsi/sr_vendor.c	Mon Dec 16 13:49:27 2002
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/bcd.h>
 
 #include <linux/blk.h>
 #include "scsi.h"
@@ -151,8 +152,6 @@
 /* This function gets called after a media change. Checks if the CD is
    multisession, asks for offset etc. */
 
-#define BCD_TO_BIN(x)    ((((int)x & 0xf0) >> 4)*10 + ((int)x & 0x0f))
-
 int sr_cd_check(struct cdrom_device_info *cdi)
 {
 	Scsi_CD *cd = cdi->handle;
@@ -223,9 +222,9 @@
 				no_multi = 1;
 				break;
 			}
-			min = BCD_TO_BIN(buffer[15]);
-			sec = BCD_TO_BIN(buffer[16]);
-			frame = BCD_TO_BIN(buffer[17]);
+			min = BCD2BIN(buffer[15]);
+			sec = BCD2BIN(buffer[16]);
+			frame = BCD2BIN(buffer[17]);
 			sector = min * CD_SECS * CD_FRAMES + sec * CD_FRAMES + frame;
 			break;
 		}
@@ -252,9 +251,9 @@
 			}
 			if (rc != 0)
 				break;
-			min = BCD_TO_BIN(buffer[1]);
-			sec = BCD_TO_BIN(buffer[2]);
-			frame = BCD_TO_BIN(buffer[3]);
+			min = BCD2BIN(buffer[1]);
+			sec = BCD2BIN(buffer[2]);
+			frame = BCD2BIN(buffer[3]);
 			sector = min * CD_SECS * CD_FRAMES + sec * CD_FRAMES + frame;
 			if (sector)
 				sector -= CD_MSF_OFFSET;
diff -Nru a/drivers/sgi/char/ds1286.c b/drivers/sgi/char/ds1286.c
--- a/drivers/sgi/char/ds1286.c	Mon Dec 16 13:49:27 2002
+++ b/drivers/sgi/char/ds1286.c	Mon Dec 16 13:49:27 2002
@@ -36,6 +36,7 @@
 #include <linux/poll.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
+#include <linux/bcd.h>
 
 #include <asm/ds1286.h>
 #include <asm/io.h>
diff -Nru a/include/asm-arm/arch-ebsa285/time.h b/include/asm-arm/arch-ebsa285/time.h
--- a/include/asm-arm/arch-ebsa285/time.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-arm/arch-ebsa285/time.h	Mon Dec 16 13:49:27 2002
@@ -18,6 +18,7 @@
 #define RTC_ALWAYS_BCD		0
 
 #include <linux/mc146818rtc.h>
+#include <linux/bcd.h>
 
 #include <asm/hardware/dec21285.h>
 #include <asm/leds.h>
diff -Nru a/include/asm-cris/rtc.h b/include/asm-cris/rtc.h
--- a/include/asm-cris/rtc.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-cris/rtc.h	Mon Dec 16 13:49:27 2002
@@ -39,11 +39,6 @@
 #define RTC_INIT() (-1)
 #endif
 
-/* conversions to and from the stupid RTC internal format */
-
-#define BCD_TO_BIN(x) x = (((x & 0xf0) >> 3) * 5 + (x & 0xf))
-#define BIN_TO_BCD(x) x = (x % 10) | ((x / 10) << 4) 
-
 /*
  * The struct used to pass data via the following ioctl. Similar to the
  * struct tm in <time.h>, but it needs to be here so that the kernel 
diff -Nru a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
--- a/include/asm-generic/rtc.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-generic/rtc.h	Mon Dec 16 13:49:27 2002
@@ -16,6 +16,7 @@
 
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
 
 #define RTC_PIE 0x40		/* periodic interrupt enable */
 #define RTC_AIE 0x20		/* alarm interrupt enable */
diff -Nru a/include/asm-mips/ds1286.h b/include/asm-mips/ds1286.h
--- a/include/asm-mips/ds1286.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-mips/ds1286.h	Mon Dec 16 13:49:27 2002
@@ -57,15 +57,4 @@
 #define RTC_IPSW		0x40
 #define RTC_TE			0x80
 
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _ASM_DS1286_h */
diff -Nru a/include/asm-mips64/ds1286.h b/include/asm-mips64/ds1286.h
--- a/include/asm-mips64/ds1286.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-mips64/ds1286.h	Mon Dec 16 13:49:27 2002
@@ -56,15 +56,4 @@
 #define RTC_IPSW		0x40
 #define RTC_TE			0x80
 
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _ASM_DS1286_h */
diff -Nru a/include/asm-mips64/m48t35.h b/include/asm-mips64/m48t35.h
--- a/include/asm-mips64/m48t35.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-mips64/m48t35.h	Mon Dec 16 13:49:27 2002
@@ -21,12 +21,4 @@
 #define M48T35_RTC_STOPPED  0x80
 #define M48T35_RTC_READ     0x40
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=(((x)/10)<<4) + (x)%10)
-#endif
-
 #endif
diff -Nru a/include/asm-ppc/m48t35.h b/include/asm-ppc/m48t35.h
--- a/include/asm-ppc/m48t35.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-ppc/m48t35.h	Mon Dec 16 13:49:27 2002
@@ -74,13 +74,4 @@
 #define M48T35_RTC_READ     0x40
 

-/* read/write conversions */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=(((x)/10)<<4) + (x)%10)
-#endif
-
 #endif
diff -Nru a/include/asm-ppc/mk48t59.h b/include/asm-ppc/mk48t59.h
--- a/include/asm-ppc/mk48t59.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-ppc/mk48t59.h	Mon Dec 16 13:49:27 2002
@@ -24,12 +24,4 @@
 #define MK48T59_RTC_CONTROLB		0x1FF9
 #define MK48T59_RTC_CB_STOP		0x80
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _PPC_MK48T59_H */
diff -Nru a/include/asm-ppc/nvram.h b/include/asm-ppc/nvram.h
--- a/include/asm-ppc/nvram.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-ppc/nvram.h	Mon Dec 16 13:49:27 2002
@@ -23,14 +23,6 @@
 #define MOTO_RTC_CONTROLA            0x1FF8
 #define MOTO_RTC_CONTROLB            0x1FF9
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 /* PowerMac specific nvram stuffs */
 
 enum {
diff -Nru a/include/asm-ppc/todc.h b/include/asm-ppc/todc.h
--- a/include/asm-ppc/todc.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-ppc/todc.h	Mon Dec 16 13:49:27 2002
@@ -355,14 +355,6 @@
 	todc_info->flags         = clock_type ##_FLAGS;			\
 }
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 extern todc_info_t *todc_info;
 
 unsigned char todc_direct_read_val(int addr);
diff -Nru a/include/asm-ppc64/nvram.h b/include/asm-ppc64/nvram.h
--- a/include/asm-ppc64/nvram.h	Mon Dec 16 13:49:27 2002
+++ b/include/asm-ppc64/nvram.h	Mon Dec 16 13:49:27 2002
@@ -28,12 +28,4 @@
 #define MOTO_RTC_CONTROLA       0x1FF8
 #define MOTO_RTC_CONTROLB       0x1FF9
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _PPC64_NVRAM_H */
diff -Nru a/include/linux/bcd.h b/include/linux/bcd.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/bcd.h	Mon Dec 16 13:49:27 2002
@@ -0,0 +1,20 @@
+/* Permission is hereby granted to copy, modify and redistribute this code
+ * in terms of the GNU Library General Public License, Version 2 or later,
+ * at your option.
+ */
+
+/* macros to translate to/from binary and binary-coded decimal (frequently
+ * found in RTC chips).
+ */
+
+#ifndef _BCD_H
+#define _BCD_H
+
+#define BCD2BIN(val)	(((val) & 0x0f) + ((val)>>4)*10)
+#define BIN2BCD(val)	((((val)/10)<<4) + (val)%10)
+
+/* backwards compat */
+#define BCD_TO_BIN(val) ((val)=BCD2BIN(val))
+#define BIN_TO_BCD(val) ((val)=BIN2BCD(val))
+
+#endif /* _BCD_H */
diff -Nru a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
--- a/include/linux/mc146818rtc.h	Mon Dec 16 13:49:27 2002
+++ b/include/linux/mc146818rtc.h	Mon Dec 16 13:49:27 2002
@@ -87,15 +87,4 @@
 # define RTC_VRT 0x80		/* valid RAM and time */
 /**********************************************************************/
 
-/* example: !(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) 
- * determines if the following two #defines are needed
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _MC146818RTC_H */

