Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265767AbUABX3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUABX3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:29:49 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:23701 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265767AbUABX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:26:16 -0500
Date: Sat, 3 Jan 2004 00:24:59 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marek Michalkiewicz <marekm@linux.org.pl>,
       Steve Hill <steve@navaho.co.uk>,
       Heiko Ronsdorf <hero@ihg.uni-duisburg.de>,
       Rodolfo Giometti <giometti@ascensit.com>,
       Nils Faerber <nils@kernelconcepts.de>, Charles Howes <chowes@vsol.net>,
       Guido Guenther <agx@sigxcpu.org>,
       Fernando Fuganti <fuganti@conectiva.com.br>,
       Gergely Madarasz <gorgo@itc.hu>, Ken Hollis <khollis@bitgate.com>,
       Oleg Drokin <green@crimea.edu>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       Christer Weinigel <wingel@nano-system.com>,
       Paul Mundt <lethal@linux-sh.org>, P?draig Brady <P@draigBrady.com>,
       Justin Cormack <justin@street-vision.com>,
       Phil Blundell <pb@nexus.co.uk>, Woody Suwalski <woody@netwinder.org>,
       Rob Radez <rob@osinvestor.com>
Subject: [PATCH] 2.6.0-rc1 - Watchdog patches
Message-ID: <20040103002459.K30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/acquirewdt.c   |   46 ++++-----
 drivers/char/watchdog/advantechwdt.c |    2 
 drivers/char/watchdog/alim7101_wdt.c |    2 
 drivers/char/watchdog/amd7xx_tco.c   |   89 ++++++++++--------
 drivers/char/watchdog/cpu5wdt.c      |   34 ++-----
 drivers/char/watchdog/eurotechwdt.c  |   94 +++++++++----------
 drivers/char/watchdog/i810-tco.c     |   36 ++++---
 drivers/char/watchdog/ib700wdt.c     |   72 ++++++---------
 drivers/char/watchdog/indydog.c      |   19 ++--
 drivers/char/watchdog/machzwd.c      |  166 ++++++++++++++++-------------------
 drivers/char/watchdog/mixcomwd.c     |   51 +++++-----
 drivers/char/watchdog/pcwd.c         |   79 ++++++++--------
 drivers/char/watchdog/sa1100_wdt.c   |    1 
 drivers/char/watchdog/sc1200wdt.c    |   18 +--
 drivers/char/watchdog/scx200_wdt.c   |   58 ++++++------
 drivers/char/watchdog/shwdt.c        |   14 +-
 drivers/char/watchdog/softdog.c      |   29 +++---
 drivers/char/watchdog/w83627hf_wdt.c |    2 
 drivers/char/watchdog/wafer5823wdt.c |    2 
 drivers/char/watchdog/wdt.c          |  119 ++++++++++++-------------
 drivers/char/watchdog/wdt285.c       |   12 +-
 drivers/char/watchdog/wdt977.c       |   15 +--
 drivers/char/watchdog/wdt_pci.c      |  107 +++++++++++-----------
 23 files changed, 531 insertions(+), 536 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/01/02 1.1569)
   [WATCHDOG] 2.6.0-rc1 - iminor(inode).patch
   
   get rid of unnecessary iminor(inode) code in watchdog's open and close functions.

<wim@iguana.be> (04/01/02 1.1570)
   [WATCHDOG] 2.6.0-rc1 expect_close.patch
   
   Made the behaviour and syntax of expect_close the same for all watchdog-drivers

<wim@iguana.be> (04/01/02 1.1571)
   [WATCHDOG] 2.6.0-rc1 i810-tco.c.nowayout.patch
   
   Fix nowayout handling to the way all other watchdog-drivers do it

<wim@iguana.be> (04/01/02 1.1572)
   [WATCHDOG] 2.6.0-rc1 _is_open.patch
   
   Make _is_open code consistent for all watchdog-drivers

<wim@iguana.be> (04/01/02 1.1573)
   [WATCHDOG] 2.6.0-rc1 cleanup-spaces-tabs.patch
   
   Cleanup of trailing spaces, tabs, ...

<wim@iguana.be> (04/01/02 1.1574)
   [WATCHDOG] 2.6.0-rc1 -ENOIOCTLCMD.patch
   
   Make the default return value for the ioctl commands that don't exist = -ENOIOCTLCMD

<wim@iguana.be> (04/01/02 1.1575)
   [WATCHDOG] 2.6.0-rc1 ib700wdt-version-comment.patch
   
   remove "for Linux 2.4.x" in the ib700wdt.c driver

<wim@iguana.be> (04/01/02 1.1576)
   [WATCHDOG] 2.6.0-rc1 amd7xx_tco.module_param.patch
   
   Made nowayout a module_parameter


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	Sat Jan  3 00:00:31 2004
+++ b/drivers/char/watchdog/cpu5wdt.c	Sat Jan  3 00:00:31 2004
@@ -134,23 +134,15 @@
 
 static int cpu5wdt_open(struct inode *inode, struct file *file)
 {
-	switch(iminor(inode)) {
-		case WATCHDOG_MINOR:
-			if ( test_and_set_bit(0, &cpu5wdt_device.inuse) )
-				return -EBUSY;
-			break;
-		default:
-			return -ENODEV;
-	}
+	if ( test_and_set_bit(0, &cpu5wdt_device.inuse) )
+		return -EBUSY;
 	return 0;
 
 }
 
 static int cpu5wdt_release(struct inode *inode, struct file *file)
 {
-	if(iminor(inode)==WATCHDOG_MINOR) {
-		clear_bit(0, &cpu5wdt_device.inuse);
-	}
+	clear_bit(0, &cpu5wdt_device.inuse);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:00:31 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:00:31 2004
@@ -217,38 +217,32 @@
 static int
 ibwdt_open(struct inode *inode, struct file *file)
 {
-	if (iminor(inode) == WATCHDOG_MINOR) {
-		spin_lock(&ibwdt_lock);
-		if (ibwdt_is_open) {
-			spin_unlock(&ibwdt_lock);
-			return -EBUSY;
-		}
-		if (nowayout)
-			__module_get(THIS_MODULE);
-
-		/* Activate */
-		ibwdt_is_open = 1;
-		ibwdt_ping();
+	spin_lock(&ibwdt_lock);
+	if (ibwdt_is_open) {
 		spin_unlock(&ibwdt_lock);
-		return 0;
-	} else {	
-		return -ENODEV;
+		return -EBUSY;
 	}
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	/* Activate */
+	ibwdt_is_open = 1;
+	ibwdt_ping();
+	spin_unlock(&ibwdt_lock);
+	return 0;
 }
 
 static int
 ibwdt_close(struct inode *inode, struct file *file)
 {
-	if (iminor(inode) == WATCHDOG_MINOR) {
-		spin_lock(&ibwdt_lock);
-		if (expect_close)
-			outb_p(wd_times[wd_margin], WDT_STOP);
-		else
-			printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
+	spin_lock(&ibwdt_lock);
+	if (expect_close)
+		outb_p(wd_times[wd_margin], WDT_STOP);
+	else
+		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 
-		ibwdt_is_open = 0;
-		spin_unlock(&ibwdt_lock);
-	}
+	ibwdt_is_open = 0;
+	spin_unlock(&ibwdt_lock);
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:00:31 2004
+++ b/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:00:31 2004
@@ -376,46 +376,38 @@
 
 static int zf_open(struct inode *inode, struct file *file)
 {
-	switch(iminor(inode)){
-		case WATCHDOG_MINOR:
-			spin_lock(&zf_lock);
-			if(zf_is_open){
-				spin_unlock(&zf_lock);
-				return -EBUSY;
-			}
-
-			if (nowayout)
-				__module_get(THIS_MODULE);
-
-			zf_is_open = 1;
-
-			spin_unlock(&zf_lock);
-
-			zf_timer_on();
-
-			return 0;
-		default:
-			return -ENODEV;
+	spin_lock(&zf_lock);
+	if(zf_is_open){
+		spin_unlock(&zf_lock);
+		return -EBUSY;
 	}
+
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	zf_is_open = 1;
+
+	spin_unlock(&zf_lock);
+
+	zf_timer_on();
+
+	return 0;
 }
 
 static int zf_close(struct inode *inode, struct file *file)
 {
-	if(iminor(inode) == WATCHDOG_MINOR){
-
-		if(zf_expect_close){
-			zf_timer_off();
-		} else {
-			del_timer(&zf_timer);
-			printk(KERN_ERR PFX ": device file closed unexpectedly. Will not stop the WDT!\n");
-		}
+	if(zf_expect_close){
+		zf_timer_off();
+	} else {
+		del_timer(&zf_timer);
+		printk(KERN_ERR PFX ": device file closed unexpectedly. Will not stop the WDT!\n");
+	}
 		
-		spin_lock(&zf_lock);
-		zf_is_open = 0;
-		spin_unlock(&zf_lock);
+	spin_lock(&zf_lock);
+	zf_is_open = 0;
+	spin_unlock(&zf_lock);
 
-		zf_expect_close = 0;
-	}
+	zf_expect_close = 0;
 	
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/amd7xx_tco.c b/drivers/char/watchdog/amd7xx_tco.c
--- a/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:00:52 2004
@@ -57,7 +57,7 @@
 static struct pci_dev *dev;
 static struct semaphore open_sem;
 static spinlock_t amdtco_lock;	/* only for device access */
-static int expect_close = 0;
+static char expect_close;
 
 MODULE_PARM(timeout, "i");
 MODULE_PARM_DESC(timeout, "range is 0-38 seconds, default is 38");
@@ -223,7 +223,7 @@
 
 static int amdtco_fop_release(struct inode *inode, struct file *file)
 {
-	if (expect_close) {
+	if (expect_close == 42) {
 		amdtco_disable();	
 		printk(KERN_INFO PFX "Watchdog disabled\n");
 	} else {
@@ -231,6 +231,7 @@
 		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds\n", timeout);
 	}	
 	
+	expect_close = 0;
 	up(&open_sem);
 	return 0;
 }
@@ -252,7 +253,7 @@
 				return -EFAULT;
 
 			if (c == 'V')
-				expect_close = 1;
+				expect_close = 42;
 		}
 #endif
 		amdtco_ping();
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:00:52 2004
@@ -50,7 +50,7 @@
 
 static int ibwdt_is_open;
 static spinlock_t ibwdt_lock;
-static int expect_close = 0;
+static char expect_close;
 
 #define PFX "ib700wdt: "
 
@@ -157,7 +157,7 @@
 				if (get_user(c, buf + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		ibwdt_ping();
@@ -236,12 +236,13 @@
 ibwdt_close(struct inode *inode, struct file *file)
 {
 	spin_lock(&ibwdt_lock);
-	if (expect_close)
+	if (expect_close == 42)
 		outb_p(wd_times[wd_margin], WDT_STOP);
 	else
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 
 	ibwdt_is_open = 0;
+	expect_close = 0;
 	spin_unlock(&ibwdt_lock);
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/indydog.c	Sat Jan  3 00:00:52 2004
@@ -26,7 +26,7 @@
 
 static unsigned long indydog_alive;
 static struct sgimc_misc_ctrl *mcmisc_regs; 
-static int expect_close = 0;
+static char expect_close;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -77,7 +77,7 @@
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
 
-	if (expect_close) {
+	if (expect_close == 42) {
 		u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
 		mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
 		mcmisc_regs->cpuctrl0 = mc_ctrl0;
@@ -86,6 +86,7 @@
 		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 	clear_bit(0,&indydog_alive);
+	expect_close = 0;
 	return 0;
 }
 
@@ -109,7 +110,7 @@
 				if (get_user(c, data + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		indydog_ping();
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:00:52 2004
@@ -131,7 +131,7 @@
 
 static int zf_action = GEN_RESET;
 static int zf_is_open = 0;
-static int zf_expect_close = 0;
+static char zf_expect_close;
 static spinlock_t zf_lock;
 static spinlock_t zf_port_lock;
 static struct timer_list zf_timer;
@@ -330,8 +330,8 @@
 				if (get_user(c, buf + ofs))
 					return -EFAULT;
 				if (c == 'V'){
-					zf_expect_close = 1;
-					dprintk("zf_expect_close 1\n");
+					zf_expect_close = 42;
+					dprintk("zf_expect_close = 42\n");
 				}
 			}
 		}
@@ -396,7 +396,7 @@
 
 static int zf_close(struct inode *inode, struct file *file)
 {
-	if(zf_expect_close){
+	if(zf_expect_close == 42){
 		zf_timer_off();
 	} else {
 		del_timer(&zf_timer);
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:00:52 2004
@@ -60,7 +60,7 @@
 static int watchdog_port;
 static int mixcomwd_timer_alive;
 static struct timer_list mixcomwd_timer = TIMER_INITIALIZER(NULL, 0, 0);
-static int expect_close = 0;
+static char expect_close;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -113,7 +113,7 @@
 
 static int mixcomwd_release(struct inode *inode, struct file *file)
 {
-	if (expect_close) {
+	if (expect_close == 42) {
 		if(mixcomwd_timer_alive) {
 			printk(KERN_ERR "mixcomwd: release called while internal timer alive");
 			return -EBUSY;
@@ -129,6 +129,7 @@
 	}
 
 	clear_bit(0,&mixcomwd_opened);
+	expect_close=0;
 	return 0;
 }
 
@@ -152,7 +153,7 @@
 				if (get_user(c, data + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		mixcomwd_ping();
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Jan  3 00:00:52 2004
@@ -86,7 +86,7 @@
 #define	WD_TIMEOUT		4	/* 2 seconds for a timeout */
 static int timeout_val = WD_TIMEOUT;
 static int timeout = 2;
-static int expect_close = 0;
+static char expect_close;
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)"); 
@@ -415,7 +415,7 @@
 				if (get_user(c, buf + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		pcwd_send_heartbeat();
@@ -477,7 +477,7 @@
 static int pcwd_close(struct inode *ino, struct file *filep)
 {
 	if (iminor(ino)==WATCHDOG_MINOR) {
-		if (expect_close) {
+		if (expect_close == 42) {
 			/*  Disable the board  */
 			if (revision == PCWD_REVISION_C) {
 				spin_lock(&io_lock);
@@ -488,6 +488,7 @@
 			atomic_inc( &open_allowed );
 		}
 	}
+	expect_close = 0;
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/sa1100_wdt.c b/drivers/char/watchdog/sa1100_wdt.c
--- a/drivers/char/watchdog/sa1100_wdt.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/sa1100_wdt.c	Sat Jan  3 00:00:52 2004
@@ -77,6 +77,7 @@
 	}
 
 	clear_bit(1, &sa1100wdt_users);
+	expect_close = 0;
 
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/scx200_wdt.c	Sat Jan  3 00:00:52 2004
@@ -51,7 +51,7 @@
 
 static u16 wdto_restart;
 static struct semaphore open_semaphore;
-static unsigned expect_close;
+static char expect_close;
 
 /* Bits of the WDCNFG register */
 #define W_ENABLE 0x00fa		/* Enable watchdog */
@@ -98,18 +98,18 @@
         if (down_trylock(&open_semaphore))
                 return -EBUSY;
 	scx200_wdt_enable();
-	expect_close = 0;
 
 	return 0;
 }
 
 static int scx200_wdt_release(struct inode *inode, struct file *file)
 {
-	if (!expect_close) {
+	if (expect_close != 42) {
 		printk(KERN_WARNING NAME ": watchdog device closed unexpectedly, will not disable the watchdog timer\n");
 	} else if (!nowayout) {
 		scx200_wdt_disable();
 	}
+	expect_close = 0;
         up(&open_semaphore);
 
 	return 0;
@@ -149,7 +149,7 @@
 			if (get_user(c, data+i))
 				return -EFAULT;
 			if (c == 'V')
-				expect_close = 1;
+				expect_close = 42;
 		}
 
 		return len;
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/softdog.c	Sat Jan  3 00:00:52 2004
@@ -49,7 +49,7 @@
 
 #define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
 
-static int expect_close = 0;
+static char expect_close;
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
 #ifdef ONLY_TESTING
 static int soft_noboot = 1;
@@ -120,12 +120,13 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
-	if (expect_close) {
+	if (expect_close == 42) {
 		del_timer(&watchdog_ticktock);
 	} else {
 		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
 	clear_bit(0, &timer_alive);
+	expect_close = 0;
 	return 0;
 }
 
@@ -151,7 +152,7 @@
 				if (get_user(c, data + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/wdt.c	Sat Jan  3 00:00:52 2004
@@ -49,7 +49,7 @@
 #include "wd501p.h"
 
 static unsigned long wdt_is_open;
-static int expect_close;
+static char expect_close;
 
 /*
  *	You must set these - there is no sane way to probe for this board.
@@ -261,7 +261,7 @@
 				if (get_user(c, buf + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		wdt_ping();
@@ -414,13 +414,14 @@
 {
 	if(iminor(inode)==WATCHDOG_MINOR)
 	{
-		if (expect_close) {
+		if (expect_close == 42) {
 			inb_p(WDT_DC);		/* Disable counters */
 			wdt_ctr_load(2,0);	/* 0 length reset pulses now */
 		} else {
 			printk(KERN_CRIT "wdt: WDT device closed unexpectedly.  WDT will not stop!\n");
 		}
 		clear_bit(0, &wdt_is_open);
+		expect_close = 0;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/wdt977.c	Sat Jan  3 00:00:52 2004
@@ -43,7 +43,7 @@
 static	int timeoutM = DEFAULT_TIMEOUT;		/* timeout in minutes */
 static	unsigned long timer_alive;
 static	int testmode;
-static int expect_close = 0;
+static	char expect_close;
 
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,"Watchdog timeout in seconds (60..15300), default=60");
@@ -165,7 +165,7 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
-	if (!nowayout)
+	if (expect_close == 42)
 	{
 		/* unlock the SuperIO chip */
 		outb(0x87,0x370);
@@ -202,6 +202,7 @@
 	} else {
 		printk(KERN_CRIT "WDT device closed unexpectedly.  WDT will not stop!\n");
 	}
+	expect_close = 0;
 	return 0;
 }
 
@@ -235,7 +236,7 @@
 				if (get_user(c, buf + i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Sat Jan  3 00:00:52 2004
+++ b/drivers/char/watchdog/wdt_pci.c	Sat Jan  3 00:00:52 2004
@@ -72,7 +72,7 @@
 
 static struct semaphore open_sem;
 static spinlock_t wdtpci_lock;
-static int expect_close = 0;
+static char expect_close;
 
 static int io;
 static int irq;
@@ -247,7 +247,7 @@
 				if(get_user(c, buf+i))
 					return -EFAULT;
 				if (c == 'V')
-					expect_close = 1;
+					expect_close = 42;
 			}
 		}
 		wdtpci_ping();
@@ -425,7 +425,7 @@
 
 	if (iminor(inode)==WATCHDOG_MINOR) {
 		unsigned long flags;
-		if (expect_close) {
+		if (expect_close == 42) {
 			spin_lock_irqsave(&wdtpci_lock, flags);
 			inb_p(WDT_DC);		/* Disable counters */
 			wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
@@ -434,6 +434,7 @@
 			printk(KERN_CRIT PFX "Unexpected close, not stopping timer!");
 			wdtpci_ping();
 		}
+		expect_close = 0;
 		up(&open_sem);
 	}
 	return 0;
diff -Nru a/drivers/char/watchdog/i810-tco.c b/drivers/char/watchdog/i810-tco.c
--- a/drivers/char/watchdog/i810-tco.c	Sat Jan  3 00:01:13 2004
+++ b/drivers/char/watchdog/i810-tco.c	Sat Jan  3 00:01:13 2004
@@ -197,7 +197,7 @@
 	/*
 	 *      Shut off the timer.
 	 */
-	if (tco_expect_close == 42 && !nowayout) {
+	if (tco_expect_close == 42) {
 		tco_timer_stop ();
 	} else {
 		tco_timer_reload ();
@@ -217,17 +217,21 @@
 
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
-		size_t i;
+		if (!nowayout) {
+			size_t i;
 
-		tco_expect_close = 0;
+			/* note: just in case someone wrote the magic character
+			 * five months ago... */
+			tco_expect_close = 0;
 
-		/* scan to see whether or not we got the magic character */
-		for (i = 0; i != len; i++) {
-			u8 c;
-			if(get_user(c, data+i))
-				return -EFAULT;
-			if (c == 'V')
-				tco_expect_close = 42;
+			/* scan to see whether or not we got the magic character */
+			for (i = 0; i != len; i++) {
+				u8 c;
+				if(get_user(c, data+i))
+					return -EFAULT;
+				if (c == 'V')
+					tco_expect_close = 42;
+			}
 		}
 
 		/* someone wrote to us, we should reload the timer */
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:01:34 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:01:34 2004
@@ -48,7 +48,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-static int ibwdt_is_open;
+static unsigned long ibwdt_is_open;
 static spinlock_t ibwdt_lock;
 static char expect_close;
 
@@ -184,9 +184,7 @@
 	  break;
 
 	case WDIOC_GETSTATUS:
-	  if (copy_to_user((int *)arg, &ibwdt_is_open,  sizeof(int)))
-	    return -EFAULT;
-	  break;
+	  return put_user(0, (int *) arg);
 
 	case WDIOC_KEEPALIVE:
 	  ibwdt_ping();
@@ -218,7 +216,7 @@
 ibwdt_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&ibwdt_lock);
-	if (ibwdt_is_open) {
+	if (test_and_set_bit(0, &ibwdt_is_open)) {
 		spin_unlock(&ibwdt_lock);
 		return -EBUSY;
 	}
@@ -226,7 +224,6 @@
 		__module_get(THIS_MODULE);
 
 	/* Activate */
-	ibwdt_is_open = 1;
 	ibwdt_ping();
 	spin_unlock(&ibwdt_lock);
 	return 0;
@@ -241,7 +238,7 @@
 	else
 		printk(KERN_CRIT PFX "WDT device closed unexpectedly.  WDT will not stop!\n");
 
-	ibwdt_is_open = 0;
+	clear_bit(0, &ibwdt_is_open);
 	expect_close = 0;
 	spin_unlock(&ibwdt_lock);
 	return 0;
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:01:34 2004
+++ b/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:01:34 2004
@@ -130,7 +130,7 @@
 MODULE_PARM_DESC(action, "after watchdog resets, generate: 0 = RESET(*)  1 = SMI  2 = NMI  3 = SCI");
 
 static int zf_action = GEN_RESET;
-static int zf_is_open = 0;
+static unsigned long zf_is_open;
 static char zf_expect_close;
 static spinlock_t zf_lock;
 static spinlock_t zf_port_lock;
@@ -359,9 +359,7 @@
 			break;
 	  
 		case WDIOC_GETSTATUS:
-			if (copy_to_user((int *)arg, &zf_is_open, sizeof(int)))
-				return -EFAULT;
-			break;
+			return put_user(0, (int *) arg);
 
 		case WDIOC_KEEPALIVE:
 			zf_ping(0);
@@ -377,7 +375,7 @@
 static int zf_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&zf_lock);
-	if(zf_is_open){
+	if(test_and_set_bit(0, &zf_is_open)) {
 		spin_unlock(&zf_lock);
 		return -EBUSY;
 	}
@@ -385,8 +383,6 @@
 	if (nowayout)
 		__module_get(THIS_MODULE);
 
-	zf_is_open = 1;
-
 	spin_unlock(&zf_lock);
 
 	zf_timer_on();
@@ -404,7 +400,7 @@
 	}
 		
 	spin_lock(&zf_lock);
-	zf_is_open = 0;
+	clear_bit(0, &zf_is_open);
 	spin_unlock(&zf_lock);
 
 	zf_expect_close = 0;
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:01:34 2004
+++ b/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:01:34 2004
@@ -55,7 +55,7 @@
 #define FLASHCOM_WATCHDOG_OFFSET 0x4
 #define FLASHCOM_ID 0x18
 
-static long mixcomwd_opened; /* long req'd for setbit --RR */
+static unsigned long mixcomwd_opened; /* long req'd for setbit --RR */
 
 static int watchdog_port;
 static int mixcomwd_timer_alive;
diff -Nru a/drivers/char/watchdog/acquirewdt.c b/drivers/char/watchdog/acquirewdt.c
--- a/drivers/char/watchdog/acquirewdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/acquirewdt.c	Sat Jan  3 00:01:55 2004
@@ -263,33 +263,33 @@
 		goto unreg_stop;
 	}
 
-        ret = register_reboot_notifier(&acq_notifier);
-        if (ret != 0) {
-                printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
-                        ret);
-                goto unreg_regions;
-        }
-                                                                                                 
-        ret = misc_register(&acq_miscdev);
-        if (ret != 0) {
-                printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
-                        WATCHDOG_MINOR, ret);
-                goto unreg_reboot;
-        }
-                                                                                                 
-        printk (KERN_INFO PFX "initialized. (nowayout=%d)\n",
-                nowayout);
-                                                                                                 
+	ret = register_reboot_notifier(&acq_notifier);
+	if (ret != 0) {
+		printk (KERN_ERR PFX "cannot register reboot notifier (err=%d)\n",
+			ret);
+		goto unreg_regions;
+	}
+
+	ret = misc_register(&acq_miscdev);
+	if (ret != 0) {
+		printk (KERN_ERR PFX "cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto unreg_reboot;
+	}
+
+	printk (KERN_INFO PFX "initialized. (nowayout=%d)\n",
+		nowayout);
+
 out:
-        return ret;
+	return ret;
 unreg_reboot:
-        unregister_reboot_notifier(&acq_notifier);
+	unregister_reboot_notifier(&acq_notifier);
 unreg_regions:
-        release_region(wdt_start, 1);
+	release_region(wdt_start, 1);
 unreg_stop:
-        if (wdt_stop != wdt_start)
-                release_region(wdt_stop, 1);
-        goto out;
+	if (wdt_stop != wdt_start)
+		release_region(wdt_stop, 1);
+	goto out;
 }
 
 static void __exit acq_exit(void)
diff -Nru a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/alim7101_wdt.c	Sat Jan  3 00:01:55 2004
@@ -374,7 +374,7 @@
 err_out_miscdev:
 	misc_deregister(&wdt_miscdev);
 err_out:
-        return rc;
+	return rc;
 }
 
 module_init(alim7101_wdt_init);
diff -Nru a/drivers/char/watchdog/amd7xx_tco.c b/drivers/char/watchdog/amd7xx_tco.c
--- a/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:01:55 2004
@@ -45,7 +45,7 @@
 #define TCO_TIMEOUT_MASK	0x3f
 #define TCO_STATUS1_REG 0x44
 #define TCO_STATUS2_REG	0x46
-#define NDTO_STS2	(1 << 1)	/* we're interested in the second timeout */ 
+#define NDTO_STS2	(1 << 1)	/* we're interested in the second timeout */
 #define BOOT_STS	(1 << 2)	/* will be set if NDTO_STS2 was set before reboot */
 #define TCO_CTRL1_REG	0x48
 #define TCO_HALT	(1 << 11)
@@ -124,7 +124,7 @@
 static inline void amdtco_enable(void)
 {
 	u16 reg;
-	
+
 	spin_lock(&amdtco_lock);
 	reg = inw(pmbase+TCO_CTRL1_REG);
 	reg &= ~TCO_HALT;
@@ -152,13 +152,13 @@
 		timeout = MAX_TIMEOUT;
 
 	amdtco_disable();
-	amdtco_settimeout(timeout);	
+	amdtco_settimeout(timeout);
 	amdtco_global_enable();
 	amdtco_enable();
 	amdtco_ping();
 	printk(KERN_INFO PFX "Watchdog enabled, timeout = %ds of %ds\n",
 		amdtco_gettimeout(), timeout);
-	
+
 	return 0;
 }
 
@@ -170,12 +170,12 @@
 
 	static struct watchdog_info ident = {
 		.options	= WDIOF_SETTIMEOUT | WDIOF_CARDRESET,
-		.identity	= "AMD 766/768"
+		.identity	= "AMD 766/768",
 	};
 
 	switch (cmd) {
 		default:
-			return -ENOTTY;	
+			return -ENOTTY;
 
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof ident))
@@ -184,7 +184,7 @@
 
 		case WDIOC_GETSTATUS:
 			return put_user(amdtco_status(), (int *)arg);
-	
+
 		case WDIOC_KEEPALIVE:
 			amdtco_ping();
 			return 0;
@@ -192,10 +192,10 @@
 		case WDIOC_SETTIMEOUT:
 			if (get_user(new_timeout, (int *)arg))
 				return -EFAULT;
-			
+
 			if (new_timeout < 0)
 				return -EINVAL;
-		
+
 			if (new_timeout > MAX_TIMEOUT)
 				new_timeout = MAX_TIMEOUT;
 
@@ -205,17 +205,17 @@
 
 		case WDIOC_GETTIMEOUT:
 			return put_user(amdtco_gettimeout(), (int *)arg);
-		
+
 		case WDIOC_SETOPTIONS:
 			if (copy_from_user(&tmp, (int *)arg, sizeof tmp))
-                                return -EFAULT;
+				return -EFAULT;
 
 			if (tmp & WDIOS_DISABLECARD)
 				amdtco_disable();
 
 			if (tmp & WDIOS_ENABLECARD)
 				amdtco_enable();
-			
+
 			return 0;
 	}
 }
@@ -224,13 +224,13 @@
 static int amdtco_fop_release(struct inode *inode, struct file *file)
 {
 	if (expect_close == 42) {
-		amdtco_disable();	
+		amdtco_disable();
 		printk(KERN_INFO PFX "Watchdog disabled\n");
 	} else {
 		amdtco_ping();
 		printk(KERN_CRIT PFX "Unexpected close!, timeout in %d seconds\n", timeout);
-	}	
-	
+	}
+
 	expect_close = 0;
 	up(&open_sem);
 	return 0;
@@ -241,13 +241,13 @@
 {
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
-	
+
 	if (len) {
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 		size_t i;
 		char c;
 		expect_close = 0;
-		
+
 		for (i = 0; i != len; i++) {
 			if (get_user(c, data + i))
 				return -EFAULT;
@@ -274,7 +274,7 @@
 
 static struct notifier_block amdtco_notifier =
 {
-	.notifier_call = amdtco_notify_sys
+	.notifier_call = amdtco_notify_sys,
 };
 
 static struct file_operations amdtco_fops =
@@ -283,20 +283,20 @@
 	.write		= amdtco_fop_write,
 	.ioctl		= amdtco_fop_ioctl,
 	.open		= amdtco_fop_open,
-	.release	= amdtco_fop_release
+	.release	= amdtco_fop_release,
 };
 
 static struct miscdevice amdtco_miscdev =
 {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
-	.fops	= &amdtco_fops
+	.fops	= &amdtco_fops,
 };
 
 static struct pci_device_id amdtco_pci_tbl[] = {
 	/* AMD 766 PCI_IDs here */
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443, PCI_ANY_ID, PCI_ANY_ID, },
-	{ 0, }
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE (pci, amdtco_pci_tbl);
@@ -317,7 +317,7 @@
 	return -ENODEV;
 
 found_one:
-	
+
 	if ((ret = register_reboot_notifier(&amdtco_notifier))) {
 		printk(KERN_ERR PFX "Unable to register reboot notifier err = %d\n", ret);
 		goto out_clean;
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/cpu5wdt.c	Sat Jan  3 00:01:55 2004
@@ -105,8 +105,8 @@
 {
 	if ( !cpu5wdt_device.queue ) {
 		cpu5wdt_device.queue = 1;
-		outb(0, port + CPU5WDT_TIME_A_REG);  
-		outb(0, port + CPU5WDT_TIME_B_REG);  
+		outb(0, port + CPU5WDT_TIME_A_REG);
+		outb(0, port + CPU5WDT_TIME_B_REG);
 		outb(1, port + CPU5WDT_MODE_REG);
 		outb(0, port + CPU5WDT_RESET_REG);
 		outb(0, port + CPU5WDT_ENABLE_REG);
@@ -152,15 +152,15 @@
 	static struct watchdog_info ident =
 	{
 		.options = WDIOF_CARDRESET,
-		.identity = "CPU5 WDT"
+		.identity = "CPU5 WDT",
 	};
-  
+
 	switch(cmd) {
 		case WDIOC_KEEPALIVE:
 			cpu5wdt_reset();
 			break;
-		case WDIOC_GETSTATUS:    
-			value = inb(port + CPU5WDT_STATUS_REG); 
+		case WDIOC_GETSTATUS:
+			value = inb(port + CPU5WDT_STATUS_REG);
 			value = (value >> 2) & 1;
 			if ( copy_to_user((int *)arg, (int *)&value, sizeof(int)) )
 				return -EFAULT;
@@ -192,7 +192,7 @@
 {
 	if ( !count )
 		return -EIO;
-	
+
 	cpu5wdt_reset();
 	return count;
 
@@ -209,7 +209,7 @@
 static struct miscdevice cpu5wdt_misc = {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
-	.fops	= &cpu5wdt_fops
+	.fops	= &cpu5wdt_fops,
 };
 
 /* init/exit function */
@@ -234,7 +234,7 @@
 	}
 
 	/* watchdog reboot? */
-	val = inb(port + CPU5WDT_STATUS_REG); 
+	val = inb(port + CPU5WDT_STATUS_REG);
 	val = (val >> 2) & 1;
 	if ( !val )
 		printk(KERN_INFO PFX "sorry, was my fault\n");
diff -Nru a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c	Sat Jan  3 00:01:54 2004
+++ b/drivers/char/watchdog/eurotechwdt.c	Sat Jan  3 00:01:54 2004
@@ -1,5 +1,5 @@
 /*
- *	Eurotech CPU-1220/1410 on board WDT driver for Linux 2.4.x
+ *	Eurotech CPU-1220/1410 on board WDT driver
  *
  *	(c) Copyright 2001 Ascensit <support@ascensit.com>
  *	(c) Copyright 2001 Rodolfo Giometti <giometti@ascensit.com>
@@ -64,11 +64,11 @@
  * You must set these - there is no sane way to probe for this board.
  * You can use eurwdt=x,y to set these now.
  */
- 
+
 static int io = 0x3f0;
 static int irq = 10;
 static char *ev = "int";
- 
+
 #define WDT_TIMEOUT		60                /* 1 minute */
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -81,7 +81,7 @@
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
- * Some symbolic names 
+ * Some symbolic names
  */
 
 #define WDT_CTRL_REG		0x30
@@ -92,7 +92,7 @@
 #define WDT_UNIT_SECS		0x80
 #define WDT_TIMEOUT_VAL		0xf2
 #define WDT_TIMER_CFG		0xf3
- 
+
 
 #ifndef MODULE
 
@@ -104,26 +104,26 @@
  * get the user to tell us the configuration. Sane people build it
  * modular but the others come here.
  */
- 
+
 static int __init eurwdt_setup(char *str)
 {
 	int ints[4];
- 
+
 str = get_options (str, ARRAY_SIZE(ints), ints);
- 
+
 	if (ints[0] > 0) {
 		io = ints[1];
 		if (ints[0] > 1)
 			irq = ints[2];
 	}
- 
+
 	return 1;
 }
- 
+
 __setup("eurwdt=", eurwdt_setup);
 
 #endif /* !MODULE */
- 
+
 MODULE_PARM(io, "i");
 MODULE_PARM_DESC(io, "Eurotech WDT io port (default=0x3f0)");
 MODULE_PARM(irq, "i");
@@ -162,7 +162,7 @@
 {
 	eurwdt_set_timeout(0);
 }
- 
+
 static void eurwdt_activate_timer(void)
 {
 	eurwdt_disable_timer();
@@ -180,18 +180,18 @@
 	eurwdt_write_reg(WDT_TIMER_CFG, irq<<4);
 
 	eurwdt_write_reg(WDT_UNIT_SEL, WDT_UNIT_SECS);	/* we use seconds */
-	eurwdt_set_timeout(0);	/* the default timeout */ 
+	eurwdt_set_timeout(0);	/* the default timeout */
 }
 
 
 /*
  * Kernel methods.
  */
- 
+
 static irqreturn_t eurwdt_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	printk(KERN_CRIT "timeout WDT timeout\n");
- 
+
 #ifdef ONLY_TESTING
 	printk(KERN_CRIT "Would Reboot.\n");
 #else
@@ -207,13 +207,13 @@
  *
  * Reload counter one with the watchdog timeout.
  */
- 
+
 static void eurwdt_ping(void)
 {
 	/* Write the watchdog default value */
 	eurwdt_set_timeout(eurwdt_timeout);
 }
- 
+
 /**
  * eurwdt_write:
  * @file: file handle to the watchdog
@@ -224,14 +224,14 @@
  * A write to a watchdog device is defined as a keepalive signal. Any
  * write of data will do, as we we don't define content meaning.
  */
- 
+
 static ssize_t eurwdt_write(struct file *file, const char *buf, size_t count,
 loff_t *ppos)
 {
 	/*  Can't seek (pwrite) on this device  */
 	if (ppos != &file->f_pos)
 	return -ESPIPE;
- 
+
 	if (count) 	{
 		if (!nowayout) {
 			size_t i;
@@ -262,7 +262,7 @@
  * The watchdog API defines a common set of functions for all watchdogs
  * according to their available features.
  */
- 
+
 static int eurwdt_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
@@ -274,7 +274,7 @@
 
 	int time;
 	int options, retval = -EINVAL;
- 
+
 	switch(cmd) {
 	default:
 		return -ENOTTY;
@@ -282,7 +282,7 @@
 	case WDIOC_GETSUPPORT:
 		return copy_to_user((struct watchdog_info *)arg, &ident,
 			sizeof(ident)) ? -EFAULT : 0;
- 
+
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(0, (int *) arg);
@@ -299,8 +299,8 @@
 		if (time < 0 || time > 255)
 			return -EINVAL;
 
-		eurwdt_timeout = time; 
-		eurwdt_set_timeout(time); 
+		eurwdt_timeout = time;
+		eurwdt_set_timeout(time);
 		/* Fall */
 
 	case WDIOC_GETTIMEOUT:
@@ -330,7 +330,7 @@
  * The misc device has been opened. The watchdog device is single
  * open and on opening we load the counter.
  */
- 
+
 static int eurwdt_open(struct inode *inode, struct file *file)
 {
 	if (test_and_set_bit(0, &eurwdt_is_open))
@@ -340,7 +340,7 @@
 	eurwdt_activate_timer();
 	return 0;
 }
- 
+
 /**
  * eurwdt_release:
  * @inode: inode to board
@@ -352,7 +352,7 @@
  * reboots. In the former case we disable the counters, in the latter
  * case you have to open it again very soon.
  */
- 
+
 static int eurwdt_release(struct inode *inode, struct file *file)
 {
 	if (eur_expect_close == 42) {
@@ -360,12 +360,12 @@
 	} else {
 		printk(KERN_CRIT "eurwdt: Unexpected close, not stopping watchdog!\n");
 		eurwdt_ping();
-    }
+	}
 	clear_bit(0, &eurwdt_is_open);
 	eur_expect_close = 0;
 	return 0;
 }
- 
+
 /**
  * eurwdt_notify_sys:
  * @this: our notifier block
@@ -377,7 +377,7 @@
  * test or worse yet during the following fsck. This would suck, in fact
  * trust me - if it happens it does suck.
  */
- 
+
 static int eurwdt_notify_sys(struct notifier_block *this, unsigned long code,
 	void *unused)
 {
@@ -388,12 +388,12 @@
 
 	return NOTIFY_DONE;
 }
- 
+
 /*
  * Kernel Interfaces
  */
- 
- 
+
+
 static struct file_operations eurwdt_fops = {
 	.owner	= THIS_MODULE,
 	.llseek	= no_llseek,
@@ -406,18 +406,18 @@
 static struct miscdevice eurwdt_miscdev = {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
-	.fops	= &eurwdt_fops
+	.fops	= &eurwdt_fops,
 };
- 
+
 /*
  * The WDT card needs to learn about soft shutdowns in order to
  * turn the timebomb registers off.
  */
- 
+
 static struct notifier_block eurwdt_notifier = {
 	.notifier_call = eurwdt_notify_sys,
 };
- 
+
 /**
  * cleanup_module:
  *
@@ -427,7 +427,7 @@
  * will not touch PC memory so all is fine. You just have to load a new
  * module in 60 seconds or reboot.
  */
- 
+
 static void __exit eurwdt_exit(void)
 {
 	eurwdt_lock_chip();
@@ -438,15 +438,15 @@
 	release_region(io, 2);
 	free_irq(irq, NULL);
 }
- 
+
 /**
  * eurwdt_init:
  *
- * Set up the WDT watchdog board. After grabbing the resources 
+ * Set up the WDT watchdog board. After grabbing the resources
  * we require we need also to unlock the device.
  * The open() function will actually kick the board off.
  */
- 
+
 static int __init eurwdt_init(void)
 {
 	int ret;
@@ -477,15 +477,15 @@
 	}
 
 	eurwdt_unlock_chip();
- 
+
 	ret = 0;
 	printk(KERN_INFO "Eurotech WDT driver 0.01 at %X (Interrupt %d)"
-		" - timeout event: %s\n", 
+		" - timeout event: %s\n",
 		io, irq, (!strcmp("int", ev) ? "int" : "reboot"));
 
 out:
 	return ret;
- 
+
 outreg:
 	release_region(io, 2);
 
@@ -496,10 +496,10 @@
 	misc_deregister(&eurwdt_miscdev);
 	goto out;
 }
- 
+
 module_init(eurwdt_init);
 module_exit(eurwdt_exit);
- 
+
 MODULE_AUTHOR("Rodolfo Giometti");
 MODULE_DESCRIPTION("Driver for Eurotech CPU-1220/1410 on board watchdog");
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/char/watchdog/i810-tco.c b/drivers/char/watchdog/i810-tco.c
--- a/drivers/char/watchdog/i810-tco.c	Sat Jan  3 00:01:54 2004
+++ b/drivers/char/watchdog/i810-tco.c	Sat Jan  3 00:01:54 2004
@@ -8,7 +8,7 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
+ *
  *	Neither kernel concepts nor Nils Faerber admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
@@ -112,7 +112,7 @@
 	outb (val, TCO1_CNT + 1);
 	val = inb (TCO1_CNT + 1);
 	spin_unlock(&tco_lock);
-	
+
 	if (val & 0x08)
 		return -1;
 	return 0;
@@ -131,7 +131,7 @@
 	outb (val, TCO1_CNT + 1);
 	val = inb (TCO1_CNT + 1);
 	spin_unlock(&tco_lock);
-	
+
 	if ((val & 0x08) == 0)
 		return -1;
 	return 0;
@@ -148,7 +148,7 @@
 	/* "Values of 0h-3h are ignored and should not be attempted" */
 	if (tmrval > 0x3f || tmrval < 0x04)
 		return -1;
-	
+
 	spin_lock(&tco_lock);
 	val = inb (TCO1_TMR);
 	val &= 0xc0;
@@ -156,7 +156,7 @@
 	outb (val, TCO1_TMR);
 	val = inb (TCO1_TMR);
 	spin_unlock(&tco_lock);
-	
+
 	if ((val & 0x3f) != tmrval)
 		return -1;
 
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:01:55 2004
@@ -28,7 +28,7 @@
  *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
  *           Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  *           Added timeout module option to override default
- * 
+ *
  */
 
 #include <linux/config.h>
@@ -174,7 +174,7 @@
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
-		.identity = "IB700 WDT"
+		.identity = "IB700 WDT",
 	};
 
 	switch (cmd) {
@@ -274,7 +274,7 @@
 static struct miscdevice ibwdt_miscdev = {
 	.minor = WATCHDOG_MINOR,
 	.name = "watchdog",
-	.fops = &ibwdt_fops
+	.fops = &ibwdt_fops,
 };
 
 /*
@@ -285,7 +285,7 @@
 static struct notifier_block ibwdt_notifier = {
 	.notifier_call = ibwdt_notify_sys,
 	.next = NULL,
-	.priority = 0
+	.priority = 0,
 };
 
 static int __init ibwdt_init(void)
diff -Nru a/drivers/char/watchdog/indydog.c b/drivers/char/watchdog/indydog.c
--- a/drivers/char/watchdog/indydog.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/indydog.c	Sat Jan  3 00:01:55 2004
@@ -7,10 +7,10 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
+ *
  *	based on softdog.c by Alan Cox <alan@redhat.com>
  */
- 
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/types.h>
@@ -25,7 +25,7 @@
 #include <asm/sgi/sgimc.h>
 
 static unsigned long indydog_alive;
-static struct sgimc_misc_ctrl *mcmisc_regs; 
+static struct sgimc_misc_ctrl *mcmisc_regs;
 static char expect_close;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
@@ -50,7 +50,7 @@
 static int indydog_open(struct inode *inode, struct file *file)
 {
 	u32 mc_ctrl0;
-	
+
 	if( test_and_set_bit(0,&indydog_alive) )
 		return -EBUSY;
 
@@ -65,7 +65,7 @@
 	mc_ctrl0 = mcmisc_regs->cpuctrl0 | SGIMC_CCTRL0_WDOG;
 	mcmisc_regs->cpuctrl0 = mc_ctrl0;
 	indydog_ping();
-			
+
 	printk("Started watchdog timer.\n");
 	return 0;
 }
@@ -78,7 +78,7 @@
 	 */
 
 	if (expect_close == 42) {
-		u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
+		u32 mc_ctrl0 = mcmisc_regs->cpuctrl0;
 		mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
 		mcmisc_regs->cpuctrl0 = mc_ctrl0;
 		printk("Stopped watchdog timer.\n");
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:01:54 2004
+++ b/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:01:54 2004
@@ -1,7 +1,7 @@
 /*
  *  MachZ ZF-Logic Watchdog Timer driver for Linux
- *  
- * 
+ *
+ *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
  *  as published by the Free Software Foundation; either version
@@ -14,14 +14,14 @@
  *  Author: Fernando Fuganti <fuganti@conectiva.com.br>
  *
  *  Based on sbc60xxwdt.c by Jakob Oestergaard
- * 
  *
- *  We have two timers (wd#1, wd#2) driven by a 32 KHz clock with the 
+ *
+ *  We have two timers (wd#1, wd#2) driven by a 32 KHz clock with the
  *  following periods:
  *      wd#1 - 2 seconds;
  *      wd#2 - 7.2 ms;
- *  After the expiration of wd#1, it can generate a NMI, SCI, SMI, or 
- *  a system RESET and it starts wd#2 that unconditionaly will RESET 
+ *  After the expiration of wd#1, it can generate a NMI, SCI, SMI, or
+ *  a system RESET and it starts wd#2 that unconditionaly will RESET
  *  the system when the counter reaches zero.
  *
  *  14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
@@ -55,7 +55,7 @@
 
 /* indexes */			/* size */
 #define ZFL_VERSION	0x02	/* 16   */
-#define CONTROL 	0x10	/* 16   */	
+#define CONTROL 	0x10	/* 16   */
 #define STATUS		0x12	/* 8    */
 #define COUNTER_1	0x0C	/* 16   */
 #define COUNTER_2	0x0E	/* 8    */
@@ -111,9 +111,9 @@
 #define PFX "machzwd"
 
 static struct watchdog_info zf_info = {
-	.options		= WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE, 
-	.firmware_version	= 1, 
-	.identity		= "ZF-Logic watchdog"
+	.options		= WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.firmware_version	= 1,
+	.identity		= "ZF-Logic watchdog",
 };
 
 
@@ -225,7 +225,7 @@
 	del_timer_sync(&zf_timer);
 
 	spin_lock_irqsave(&zf_port_lock, flags);
-	/* stop watchdog timer */	
+	/* stop watchdog timer */
 	ctrl_reg = zf_get_control();
 	ctrl_reg |= (ENABLE_WD1|ENABLE_WD2);	/* disable wd1 and wd2 */
 	ctrl_reg &= ~(ENABLE_WD1|ENABLE_WD2);
@@ -237,13 +237,13 @@
 
 
 /*
- * start hardware timer 
+ * start hardware timer
  */
 static void zf_timer_on(void)
 {
 	unsigned int ctrl_reg = 0;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&zf_port_lock, flags);
 
 	zf_writeb(PULSE_LEN, 0xff);
@@ -272,26 +272,26 @@
 {
 	unsigned int ctrl_reg = 0;
 	unsigned long flags;
-		
+
 	zf_writeb(COUNTER_2, 0xff);
 
 	if(time_before(jiffies, next_heartbeat)){
 
 		dprintk("time_before: %ld\n", next_heartbeat - jiffies);
-		
-		/* 
+
+		/*
 		 * reset event is activated by transition from 0 to 1 on
 		 * RESET_WD1 bit and we assume that it is already zero...
 		 */
 
 		spin_lock_irqsave(&zf_port_lock, flags);
-		ctrl_reg = zf_get_control();    
-		ctrl_reg |= RESET_WD1;		
-		zf_set_control(ctrl_reg);	
-		
+		ctrl_reg = zf_get_control();
+		ctrl_reg |= RESET_WD1;
+		zf_set_control(ctrl_reg);
+
 		/* ...and nothing changes until here */
 		ctrl_reg &= ~(RESET_WD1);
-		zf_set_control(ctrl_reg);		
+		zf_set_control(ctrl_reg);
 		spin_unlock_irqrestore(&zf_port_lock, flags);
 
 		zf_timer.expires = jiffies + ZF_HW_TIMEO;
@@ -301,7 +301,7 @@
 	}
 }
 
-static ssize_t zf_write(struct file *file, const char *buf, size_t count, 
+static ssize_t zf_write(struct file *file, const char *buf, size_t count,
 								loff_t *ppos)
 {
 	/*  Can't seek (pwrite) on this device  */
@@ -317,13 +317,13 @@
 		 */
 		if (!nowayout) {
 			size_t ofs;
-			
-			/* 
+
+			/*
 			 * note: just in case someone wrote the magic character
 			 * five months ago...
 			 */
 			zf_expect_close = 0;
-			
+
 			/* now scan */
 			for (ofs = 0; ofs != count; ofs++){
 				char c;
@@ -342,7 +342,7 @@
 		 */
 		next_heartbeat = jiffies + ZF_USER_TIMEO;
 		dprintk("user ping at %ld\n", jiffies);
-		
+
 	}
 
 	return count;
@@ -353,11 +353,11 @@
 {
 	switch(cmd){
 		case WDIOC_GETSUPPORT:
-			if (copy_to_user((struct watchdog_info *)arg, 
+			if (copy_to_user((struct watchdog_info *)arg,
 					 &zf_info, sizeof(zf_info)))
 				return -EFAULT;
 			break;
-	  
+
 		case WDIOC_GETSTATUS:
 			return put_user(0, (int *) arg);
 
@@ -398,13 +398,13 @@
 		del_timer(&zf_timer);
 		printk(KERN_ERR PFX ": device file closed unexpectedly. Will not stop the WDT!\n");
 	}
-		
+
 	spin_lock(&zf_lock);
 	clear_bit(0, &zf_is_open);
 	spin_unlock(&zf_lock);
 
 	zf_expect_close = 0;
-	
+
 	return 0;
 }
 
@@ -416,9 +416,9 @@
 								void *unused)
 {
 	if(code == SYS_DOWN || code == SYS_HALT){
-		zf_timer_off();		
+		zf_timer_off();
 	}
-	
+
 	return NOTIFY_DONE;
 }
 
@@ -436,9 +436,9 @@
 static struct miscdevice zf_miscdev = {
 	.minor = WATCHDOG_MINOR,
 	.name = "watchdog",
-	.fops = &zf_fops
+	.fops = &zf_fops,
 };
-                                                                        
+ 
 
 /*
  * The device needs to learn about soft shutdowns in order to
@@ -447,20 +447,20 @@
 static struct notifier_block zf_notifier = {
 	.notifier_call = zf_notify_sys,
 	.next = NULL,
-	.priority = 0
+	.priority = 0,
 };
 
 static void __init zf_show_action(int act)
 {
 	char *str[] = { "RESET", "SMI", "NMI", "SCI" };
-	
+
 	printk(KERN_INFO PFX ": Watchdog using action = %s\n", str[act]);
 }
 
 static int __init zf_init(void)
 {
 	int ret;
-	
+
 	printk(KERN_INFO PFX ": MachZ ZF-Logic Watchdog driver initializing.\n");
 
 	ret = zf_get_ZFL_version();
@@ -474,12 +474,12 @@
 		zf_action = zf_action>>action;
 	} else
 		action = 0;
-	
+
 	zf_show_action(action);
 
 	spin_lock_init(&zf_lock);
 	spin_lock_init(&zf_port_lock);
-	
+
 	ret = misc_register(&zf_miscdev);
 	if (ret){
 		printk(KERN_ERR "can't misc_register on minor=%d\n",
@@ -500,7 +500,7 @@
 									ret);
 		goto no_reboot;
 	}
-	
+
 	zf_set_status(0);
 	zf_set_control(0);
 
@@ -508,7 +508,7 @@
 	init_timer(&zf_timer);
 	zf_timer.function = zf_ping;
 	zf_timer.data = 0;
-	
+
 	return 0;
 
 no_reboot:
@@ -519,11 +519,11 @@
 	return ret;
 }
 
-	
+
 void __exit zf_exit(void)
 {
 	zf_timer_off();
-	
+
 	misc_deregister(&zf_miscdev);
 	unregister_reboot_notifier(&zf_notifier);
 	release_region(ZF_IOBASE, 3);
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:01:55 2004
@@ -30,11 +30,11 @@
  *
  * Version 0.5 (2001/12/14) Matt Domsch <Matt_Domsch@dell.com>
  *              - added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
- *	
+ *
  */
 
-#define VERSION "0.5" 
-  
+#define VERSION "0.5"
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/config.h>
@@ -80,21 +80,21 @@
 static void mixcomwd_timerfun(unsigned long d)
 {
 	mixcomwd_ping();
-	
+
 	mod_timer(&mixcomwd_timer,jiffies+ 5*HZ);
 }
 
 /*
  *	Allow only one person to hold it open
  */
- 
+
 static int mixcomwd_open(struct inode *inode, struct file *file)
 {
 	if(test_and_set_bit(0,&mixcomwd_opened)) {
 		return -EBUSY;
 	}
 	mixcomwd_ping();
-	
+
 	if (nowayout) {
 		/*
 		 * fops_get() code via open() has already done
@@ -168,9 +168,9 @@
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
-		.identity = "MixCOM watchdog"
+		.identity = "MixCOM watchdog",
 	};
-                                        
+
 	switch(cmd)
 	{
 		case WDIOC_GETSTATUS:
@@ -183,7 +183,7 @@
 			}
 			break;
 		case WDIOC_GETSUPPORT:
-			if (copy_to_user((struct watchdog_info *)arg, &ident, 
+			if (copy_to_user((struct watchdog_info *)arg, &ident,
 			    sizeof(ident))) {
 				return -EFAULT;
 			}
@@ -208,9 +208,9 @@
 
 static struct miscdevice mixcomwd_miscdev=
 {
-	WATCHDOG_MINOR,
-	"watchdog",
-	&mixcomwd_fops
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &mixcomwd_fops,
 };
 
 static int __init mixcomwd_checkcard(int port)
@@ -221,7 +221,7 @@
 	if (!request_region(port, 1, "MixCOM watchdog")) {
 		return 0;
 	}
-	
+
 	id=inb_p(port) & 0x3f;
 	if(id!=MIXCOM_ID) {
 		release_region(port, 1);
@@ -233,12 +233,12 @@
 static int __init flashcom_checkcard(int port)
 {
 	int id;
-	
+
 	port += FLASHCOM_WATCHDOG_OFFSET;
 	if (!request_region(port, 1, "MixCOM watchdog")) {
 		return 0;
 	}
-	
+
 	id=inb_p(port);
  	if(id!=FLASHCOM_ID) {
 		release_region(port, 1);
@@ -246,7 +246,7 @@
 	}
  	return port;
  }
- 
+
 static int __init mixcomwd_init(void)
 {
 	int i;
@@ -259,7 +259,7 @@
 			found = 1;
 		}
 	}
-	
+
 	/* The FlashCOM card can be set up at 0x300 -> 0x378, in 0x8 jumps */
 	for (i = 0x300; !found && i < 0x380; i+=0x8) {
 		watchdog_port = flashcom_checkcard(i);
@@ -267,7 +267,7 @@
 			found = 1;
 		}
 	}
-	
+
 	if (!found) {
 		printk("mixcomwd: No card detected, or port not available.\n");
 		return -ENODEV;
@@ -279,11 +279,11 @@
 		release_region(watchdog_port, 1);
 		return ret;
 	}
-	
+
 	printk(KERN_INFO "MixCOM watchdog driver v%s, watchdog port at 0x%3x\n",VERSION,watchdog_port);
 
 	return 0;
-}	
+}
 
 static void __exit mixcomwd_exit(void)
 {
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Jan  3 00:01:54 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Jan  3 00:01:54 2004
@@ -34,7 +34,7 @@
  * 971222       Changed open/close for temperature handling
  *              Michael Meskes <meskes@debian.org>.
  * 980112       Used minor numbers from include/linux/miscdevice.h
- * 990403       Clear reset status after reading control status register in 
+ * 990403       Clear reset status after reading control status register in
  *              pcwd_showprevstate(). [Marc Boucher <marc@mbsi.ca>]
  * 990605	Made changes to code to support Firmware 1.22a, added
  *		fairly useless proc entry.
@@ -89,7 +89,7 @@
 static char expect_close;
 
 module_param(timeout, int, 0);
-MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)"); 
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=2)");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
@@ -248,9 +248,9 @@
 	int cdat, rv;
 	static struct watchdog_info ident=
 	{
-		WDIOF_OVERHEAT|WDIOF_CARDRESET,
-		1,
-		"PCWD"
+		.options =		WDIOF_OVERHEAT|WDIOF_CARDRESET,
+		.firmware_version =	1,
+		.identity =		"PCWD",
 	};
 
 	switch(cmd) {
@@ -264,19 +264,19 @@
 
 	case WDIOC_GETSTATUS:
 		spin_lock(&io_lock);
-		if (revision == PCWD_REVISION_A) 
+		if (revision == PCWD_REVISION_A)
 			cdat = inb(current_readport);
 		else
 			cdat = inb(current_readport + 1 );
 		spin_unlock(&io_lock);
 		rv = WDIOF_MAGICCLOSE;
 
-		if (revision == PCWD_REVISION_A) 
+		if (revision == PCWD_REVISION_A)
 		{
 			if (cdat & WD_WDRST)
 				rv |= WDIOF_CARDRESET;
 
-			if (cdat & WD_T110) 
+			if (cdat & WD_T110)
 			{
 				rv |= WDIOF_OVERHEAT;
 
@@ -286,12 +286,12 @@
 				}
 			}
 		}
-		else 
+		else
 		{
 			if (cdat & 0x01)
 				rv |= WDIOF_CARDRESET;
 
-			if (cdat & 0x04) 
+			if (cdat & 0x04)
 			{
 				rv |= WDIOF_OVERHEAT;
 
@@ -309,7 +309,7 @@
 	case WDIOC_GETBOOTSTATUS:
 		rv = 0;
 
-		if (revision == PCWD_REVISION_A) 
+		if (revision == PCWD_REVISION_A)
 		{
 			if (initial_status & WD_WDRST)
 				rv |= WDIOF_CARDRESET;
@@ -333,7 +333,7 @@
 	case WDIOC_GETTEMP:
 
 		rv = 0;
-		if ((supports_temp) && (mode_debug == 0)) 
+		if ((supports_temp) && (mode_debug == 0))
 		{
 			spin_lock(&io_lock);
 			rv = inb(current_readport);
@@ -345,19 +345,19 @@
 		return 0;
 
 	case WDIOC_SETOPTIONS:
-		if (revision == PCWD_REVISION_C) 
+		if (revision == PCWD_REVISION_C)
 		{
 			if(copy_from_user(&rv, (int*) arg, sizeof(int)))
 				return -EFAULT;
 
-			if (rv & WDIOS_DISABLECARD) 
+			if (rv & WDIOS_DISABLECARD)
 			{
 				spin_lock(&io_lock);
 				outb_p(0xA5, current_readport + 3);
 				outb_p(0xA5, current_readport + 3);
 				cdat = inb_p(current_readport + 2);
 				spin_unlock(&io_lock);
-				if ((cdat & 0x10) == 0) 
+				if ((cdat & 0x10) == 0)
 				{
 					printk(KERN_INFO "pcwd: Could not disable card.\n");
 					return -EIO;
@@ -366,13 +366,13 @@
 				return 0;
 			}
 
-			if (rv & WDIOS_ENABLECARD) 
+			if (rv & WDIOS_ENABLECARD)
 			{
 				spin_lock(&io_lock);
 				outb_p(0x00, current_readport + 3);
 				cdat = inb_p(current_readport + 2);
 				spin_unlock(&io_lock);
-				if (cdat & 0x10) 
+				if (cdat & 0x10)
 				{
 					printk(KERN_INFO "pcwd: Could not enable card.\n");
 					return -EIO;
@@ -380,13 +380,13 @@
 				return 0;
 			}
 
-			if (rv & WDIOS_TEMPPANIC) 
+			if (rv & WDIOS_TEMPPANIC)
 			{
 				temp_panic = 1;
 			}
 		}
 		return -EINVAL;
-		
+
 	case WDIOC_KEEPALIVE:
 		pcwd_send_heartbeat();
 		return 0;
@@ -456,14 +456,14 @@
 	/*  Can't seek (pread) on this device  */
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
-	switch(iminor(file->f_dentry->d_inode)) 
+	switch(iminor(file->f_dentry->d_inode))
 	{
 		case TEMP_MINOR:
 			/*
 			 * Convert metric to Fahrenheit, since this was
 			 * the decided 'standard' for this return value.
 			 */
-			
+
 			c = inb(current_readport);
 			cp = (c * 9 / 5) + 32;
 			if(copy_to_user(buf, &cp, 1))
@@ -501,7 +501,7 @@
 static inline int get_revision(void)
 {
 	int r = PCWD_REVISION_C;
-	
+
 	spin_lock(&io_lock);
 	if ((inb(current_readport + 2) == 0xFF) ||
 	    (inb(current_readport + 3) == 0xFF))
@@ -577,29 +577,29 @@
 };
 
 static struct miscdevice pcwd_miscdev = {
-	WATCHDOG_MINOR,
-	"watchdog",
-	&pcwd_fops
+	.minor =	WATCHDOG_MINOR,
+	.name =		"watchdog",
+	.fops =		&pcwd_fops,
 };
 
 static struct miscdevice temp_miscdev = {
-	TEMP_MINOR,
-	"temperature",
-	&pcwd_fops
+	.minor =	TEMP_MINOR,
+	.name =		"temperature",
+	.fops =		&pcwd_fops,
 };
- 
+
 static void __init pcwd_validate_timeout(void)
 {
 	timeout_val = timeout * 2;
 }
- 
+
 static int __init pcwatchdog_init(void)
 {
 	char *firmware;
 	int i, found = 0;
 	pcwd_validate_timeout();
 	spin_lock_init(&io_lock);
-	
+
 	revision = PCWD_REVISION_A;
 
 	printk(KERN_INFO "pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);
@@ -661,11 +661,11 @@
 
 	if (misc_register(&pcwd_miscdev))
 		return -ENODEV;
-	
+
 	if (supports_temp)
 		if (misc_register(&temp_miscdev)) {
 			misc_deregister(&pcwd_miscdev);
-			return -ENODEV;		
+			return -ENODEV;
 		}
 
 
@@ -674,10 +674,10 @@
 			misc_deregister(&pcwd_miscdev);
 			if (supports_temp)
 				misc_deregister(&pcwd_miscdev);
-			return -EIO;		
+			return -EIO;
 		}
 	}
-	else 
+	else
 		if (!request_region(current_readport, 4, "PCWD Rev.C (Berkshire)")) {
 			misc_deregister(&pcwd_miscdev);
 			if (supports_temp)
diff -Nru a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	Sat Jan  3 00:01:54 2004
+++ b/drivers/char/watchdog/sc1200wdt.c	Sat Jan  3 00:01:55 2004
@@ -175,7 +175,7 @@
 	static struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 		.firmware_version = 0,
-		.identity = "PC87307/PC97307"
+		.identity = "PC87307/PC97307",
 	};
 
 	switch (cmd) {
@@ -256,7 +256,7 @@
 {
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
-	
+
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -292,7 +292,7 @@
 
 static struct notifier_block sc1200wdt_notifier =
 {
-	notifier_call:	sc1200wdt_notify_sys
+	.notifier_call =	sc1200wdt_notify_sys,
 };
 
 static struct file_operations sc1200wdt_fops =
@@ -301,7 +301,7 @@
 	.write		= sc1200wdt_write,
 	.ioctl		= sc1200wdt_ioctl,
 	.open		= sc1200wdt_open,
-	.release	= sc1200wdt_release
+	.release	= sc1200wdt_release,
 };
 
 static struct miscdevice sc1200wdt_miscdev =
@@ -320,7 +320,7 @@
 	 * Nb. This could be done with accuracy by reading the SID registers, but
 	 * we don't have access to those io regions.
 	 */
-	
+
 	unsigned char reg;
 
 	sc1200wdt_read_data(PMC3, &reg);
@@ -334,7 +334,7 @@
 struct pnp_device_id scl200wdt_pnp_devices[] = {
 	/* National Semiconductor PC87307/PC97307 watchdog component */
 	{.id = "NSC0800", .driver_data = 0},
-	{.id = ""}
+	{.id = ""},
 };
 
 static int scl200wdt_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
@@ -409,7 +409,7 @@
 		ret = -EBUSY;
 		goto out_clean;
 	}
-	
+
 	ret = sc1200wdt_probe();
 	if (ret)
 		goto out_io;
@@ -438,7 +438,7 @@
 	release_region(io, io_len);
 
 	goto out_clean;
-}	
+}
 
 
 static void __exit sc1200wdt_exit(void)
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/scx200_wdt.c	Sat Jan  3 00:01:55 2004
@@ -1,4 +1,4 @@
-/* linux/drivers/char/scx200_wdt.c 
+/* drivers/char/watchdog/scx200_wdt.c
 
    National Semiconductor SCx200 Watchdog support
 
@@ -73,7 +73,7 @@
 
 static void scx200_wdt_enable(void)
 {
-	printk(KERN_DEBUG NAME ": enabling watchdog timer, wdto_restart = %d\n", 
+	printk(KERN_DEBUG NAME ": enabling watchdog timer, wdto_restart = %d\n",
 	       wdto_restart);
 
 	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
@@ -86,7 +86,7 @@
 static void scx200_wdt_disable(void)
 {
 	printk(KERN_DEBUG NAME ": disabling watchdog timer\n");
-		
+
 	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
 	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
 	outw(W_DISABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
@@ -94,9 +94,9 @@
 
 static int scx200_wdt_open(struct inode *inode, struct file *file)
 {
-        /* only allow one at a time */
-        if (down_trylock(&open_semaphore))
-                return -EBUSY;
+	/* only allow one at a time */
+	if (down_trylock(&open_semaphore))
+		return -EBUSY;
 	scx200_wdt_enable();
 
 	return 0;
@@ -110,34 +110,34 @@
 		scx200_wdt_disable();
 	}
 	expect_close = 0;
-        up(&open_semaphore);
+	up(&open_semaphore);
 
 	return 0;
 }
 
-static int scx200_wdt_notify_sys(struct notifier_block *this, 
+static int scx200_wdt_notify_sys(struct notifier_block *this,
 				      unsigned long code, void *unused)
 {
-        if (code == SYS_HALT || code == SYS_POWER_OFF)
+	if (code == SYS_HALT || code == SYS_POWER_OFF)
 		if (!nowayout)
 			scx200_wdt_disable();
 
-        return NOTIFY_DONE;
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block scx200_wdt_notifier =
 {
-        .notifier_call = scx200_wdt_notify_sys
+	.notifier_call = scx200_wdt_notify_sys,
 };
 
-static ssize_t scx200_wdt_write(struct file *file, const char *data, 
+static ssize_t scx200_wdt_write(struct file *file, const char *data,
 				     size_t len, loff_t *ppos)
 {
 	if (ppos != &file->f_pos)
 		return -ESPIPE;
 
 	/* check for a magic close character */
-	if (len) 
+	if (len)
 	{
 		size_t i;
 
@@ -163,16 +163,16 @@
 {
 	static struct watchdog_info ident = {
 		.identity = "NatSemi SCx200 Watchdog",
-		.firmware_version = 1, 
+		.firmware_version = 1,
 		.options = (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING),
 	};
 	int new_margin;
-	
+
 	switch (cmd) {
 	default:
 		return -ENOTTY;
 	case WDIOC_GETSUPPORT:
-		if(copy_to_user((struct watchdog_info *)arg, &ident, 
+		if(copy_to_user((struct watchdog_info *)arg, &ident,
 				sizeof(ident)))
 			return -EFAULT;
 		return 0;
@@ -220,7 +220,7 @@
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 Watchdog Driver\n");
 
 	/* First check that this really is a NatSemi SCx200 CPU */
-	if ((pci_find_device(PCI_VENDOR_ID_NS, 
+	if ((pci_find_device(PCI_VENDOR_ID_NS,
 			     PCI_DEVICE_ID_NS_SCx200_BRIDGE,
 			     NULL)) == NULL)
 		return -ENODEV;
@@ -231,8 +231,8 @@
 		return -ENODEV;
 	}
 
-	if (!request_region(SCx200_CB_BASE + SCx200_WDT_OFFSET, 
-			    SCx200_WDT_SIZE, 
+	if (!request_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+			    SCx200_WDT_SIZE,
 			    "NatSemi SCx200 Watchdog")) {
 		printk(KERN_WARNING NAME ": watchdog I/O region busy\n");
 		return -EBUSY;
@@ -251,20 +251,20 @@
 	}
 
 	r = register_reboot_notifier(&scx200_wdt_notifier);
-        if (r) {
-                printk(KERN_ERR NAME ": unable to register reboot notifier");
+	if (r) {
+		printk(KERN_ERR NAME ": unable to register reboot notifier");
 		misc_deregister(&scx200_wdt_miscdev);
 		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
 				SCx200_WDT_SIZE);
-                return r;
-        }
+		return r;
+	}
 
 	return 0;
 }
 
 static void __exit scx200_wdt_cleanup(void)
 {
-        unregister_reboot_notifier(&scx200_wdt_notifier);
+	unregister_reboot_notifier(&scx200_wdt_notifier);
 	misc_deregister(&scx200_wdt_miscdev);
 	release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
 		       SCx200_WDT_SIZE);
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/shwdt.c	Sat Jan  3 00:01:55 2004
@@ -36,7 +36,7 @@
 /*
  * Default clock division ratio is 5.25 msecs. For an additional table of
  * values, consult the asm-sh/watchdog.h. Overload this at module load
- * time. 
+ * time.
  *
  * In order for this to work reliably we need to have HZ set to 1000 or
  * something quite higher than 100 (or we need a proper high-res timer
@@ -122,7 +122,7 @@
 	csr = sh_wdt_read_rstcsr();
 	csr &= ~RSTCSR_RSTS;
 	sh_wdt_write_rstcsr(csr);
-#endif	
+#endif
 }
 
 /**
@@ -202,7 +202,7 @@
 
 	clear_bit(0, &shwdt_is_open);
 	shwdt_expect_close = 0;
-	
+
 	return 0;
 }
 
@@ -264,7 +264,7 @@
 					  sizeof(sh_wdt_info))) {
 				return -EFAULT;
 			}
-			
+
 			break;
 		case WDIOC_GETSTATUS:
 		case WDIOC_GETBOOTSTATUS:
@@ -299,7 +299,7 @@
 				sh_wdt_start();
 				retval = 0;
 			}
-			
+
 			return retval;
 		}
 		default:
@@ -311,7 +311,7 @@
 
 /**
  * 	sh_wdt_notify_sys - Notifier Handler
- * 	
+ *
  * 	@this: notifier block
  * 	@code: notifier event
  * 	@unused: unused
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/softdog.c	Sat Jan  3 00:01:55 2004
@@ -8,10 +8,10 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
@@ -28,14 +28,14 @@
  *	Made SMP safe for 2.3.x
  *
  *  20011127 Joel Becker (jlbec@evilplan.org>
- *	Added soft_noboot; Allows testing the softdog trigger without 
+ *	Added soft_noboot; Allows testing the softdog trigger without
  *	requiring a recompile.
  *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
  *
  *  20020530 Joel Becker <joel.becker@oracle.com>
  *  	Added Matt Domsch's nowayout module option.
  */
- 
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/config.h>
@@ -73,7 +73,7 @@
 /*
  *	Our timer
  */
- 
+
 static void watchdog_fire(unsigned long);
 
 static struct timer_list watchdog_ticktock =
@@ -84,7 +84,7 @@
 /*
  *	If the timer expires..
  */
- 
+
 static void watchdog_fire(unsigned long data)
 {
 	if (soft_noboot)
@@ -100,12 +100,12 @@
 /*
  *	Allow only one person to hold it open
  */
- 
+
 static int softdog_open(struct inode *inode, struct file *file)
 {
 	if(test_and_set_bit(0, &timer_alive))
 		return -EBUSY;
-	if (nowayout) 
+	if (nowayout)
 		__module_get(THIS_MODULE);
 	/*
 	 *	Activate timer
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/wdt.c	Sat Jan  3 00:01:55 2004
@@ -8,10 +8,10 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
@@ -55,7 +55,7 @@
  *	You must set these - there is no sane way to probe for this board.
  *	You can use wdt=x,y to set these now.
  */
- 
+
 static int io=0x240;
 static int irq=11;
 
@@ -80,10 +80,10 @@
  *	@str: command line string
  *
  *	Setup options. The board isn't really probe-able so we have to
- *	get the user to tell us the configuration. Sane people build it 
+ *	get the user to tell us the configuration. Sane people build it
  *	modular but the others come here.
  */
- 
+
 static int __init wdt_setup(char *str)
 {
 	int ints[4];
@@ -108,11 +108,11 @@
 MODULE_PARM_DESC(io, "WDT io port (default=0x240)");
 MODULE_PARM(irq, "i");
 MODULE_PARM_DESC(irq, "WDT irq (default=11)");
- 
+
 /*
  *	Programming support
  */
- 
+
 static void wdt_ctr_mode(int ctr, int mode)
 {
 	ctr<<=6;
@@ -130,29 +130,29 @@
 /*
  *	Kernel methods.
  */
- 
- 
+
+
 /**
  *	wdt_status:
- *	
+ *
  *	Extract the status information from a WDT watchdog device. There are
  *	several board variants so we have to know which bits are valid. Some
  *	bits default to one and some to zero in order to be maximally painful.
  *
  *	we then map the bits onto the status ioctl flags.
  */
- 
+
 static int wdt_status(void)
 {
 	/*
 	 *	Status register to bit flags
 	 */
-	 
+
 	int flag=0;
 	unsigned char status=inb_p(WDT_SR);
 	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;	
-	
+	status&=~FEATUREMAP2;
+
 	if(!(status&WDC_SR_TGOOD))
 		flag|=WDIOF_OVERHEAT;
 	if(!(status&WDC_SR_PSUOVER))
@@ -178,21 +178,21 @@
  *	map changes in what the board considers an interesting way. That means
  *	a failure condition occurring.
  */
- 
+
 static irqreturn_t wdt_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Read the status register see what is up and
-	 *	then printk it. 
+	 *	then printk it.
 	 */
-	 
+
 	unsigned char status=inb_p(WDT_SR);
-	
+
 	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;	
-	
+	status&=~FEATUREMAP2;
+
 	printk(KERN_CRIT "WDT status %d\n", status);
-	
+
 	if(!(status&WDC_SR_TGOOD))
 		printk(KERN_CRIT "Overheat alarm.(%d)\n",inb_p(WDT_RT));
 	if(!(status&WDC_SR_PSUOVER))
@@ -205,10 +205,10 @@
 #ifdef SOFTWARE_REBOOT
 #ifdef ONLY_TESTING
 		printk(KERN_CRIT "Would Reboot.\n");
-#else		
+#else
 		printk(KERN_CRIT "Initiating system reboot.\n");
 		machine_restart(NULL);
-#endif		
+#endif
 #else
 		printk(KERN_CRIT "Reset in 5ms.\n");
 #endif
@@ -220,9 +220,9 @@
  *	wdt_ping:
  *
  *	Reload counter one with the watchdog timeout. We don't bother reloading
- *	the cascade counter. 
+ *	the cascade counter.
  */
- 
+
 static void wdt_ping(void)
 {
 	/* Write a watchdog value */
@@ -235,14 +235,14 @@
 /**
  *	wdt_write:
  *	@file: file handle to the watchdog
- *	@buf: buffer to write (unused as data does not matter here 
+ *	@buf: buffer to write (unused as data does not matter here
  *	@count: count of bytes
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
  *	write of data will do, as we we don't define content meaning.
  */
- 
+
 static ssize_t wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	/*  Can't seek (pwrite) on this device  */
@@ -279,12 +279,12 @@
  *	Read reports the temperature in degrees Fahrenheit. The API is in
  *	farenheit. It was designed by an imperial measurement luddite.
  */
- 
+
 static ssize_t wdt_read(struct file *file, char *buf, size_t count, loff_t *ptr)
 {
 	unsigned short c=inb_p(WDT_RT);
 	unsigned char cp;
-	
+
 	/*  Can't seek (pread) on this device  */
 	if (ptr != &file->f_pos)
 		return -ESPIPE;
@@ -312,9 +312,9 @@
  *
  *	The watchdog API defines a common set of functions for all watchdogs
  *	according to their available features. We only actually usefully support
- *	querying capabilities and current status. 
+ *	querying capabilities and current status.
  */
- 
+
 static int wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
@@ -326,9 +326,9 @@
 					|WDIOF_EXTERN1|WDIOF_EXTERN2|WDIOF_FANFAULT
 					|WDIOF_SETTIMEOUT|WDIOF_MAGICCLOSE,
 		.firmware_version = 1,
-		.identity = "WDT500/501"
+		.identity = "WDT500/501",
 	};
-	
+
 	ident.options&=WDT_OPTION_MASK;	/* Mask down to the card we have */
 	switch(cmd)
 	{
@@ -364,12 +364,12 @@
  *	@file: file handle to device
  *
  *	One of our two misc devices has been opened. The watchdog device is
- *	single open and on opening we load the counters. Counter zero is a 
+ *	single open and on opening we load the counters. Counter zero is a
  *	100Hz cascade, into counter 1 which downcounts to reboot. When the
  *	counter triggers counter 2 downcounts the length of the reset pulse
- *	which set set to be as long as possible. 
+ *	which set set to be as long as possible.
  */
- 
+
 static int wdt_open(struct inode *inode, struct file *file)
 {
 	switch(iminor(inode))
@@ -378,9 +378,9 @@
 			if(test_and_set_bit(0, &wdt_is_open))
 				return -EBUSY;
 			/*
-			 *	Activate 
+			 *	Activate
 			 */
-	 
+
 			wdt_is_open=1;
 			inb_p(WDT_DC);		/* Disable */
 			wdt_ctr_mode(0,3);
@@ -403,13 +403,13 @@
  *	@inode: inode to board
  *	@file: file handle to board
  *
- *	The watchdog has a configurable API. There is a religious dispute 
- *	between people who want their watchdog to be able to shut down and 
+ *	The watchdog has a configurable API. There is a religious dispute
+ *	between people who want their watchdog to be able to shut down and
  *	those who want to be sure if the watchdog manager dies the machine
  *	reboots. In the former case we disable the counters, in the latter
  *	case you have to open it again very soon.
  */
- 
+
 static int wdt_release(struct inode *inode, struct file *file)
 {
 	if(iminor(inode)==WATCHDOG_MINOR)
@@ -449,12 +449,12 @@
 	}
 	return NOTIFY_DONE;
 }
- 
+
 /*
  *	Kernel Interfaces
  */
- 
- 
+
+
 static struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -469,7 +469,7 @@
 {
 	.minor	= WATCHDOG_MINOR,
 	.name	= "watchdog",
-	.fops	= &wdt_fops
+	.fops	= &wdt_fops,
 };
 
 #ifdef CONFIG_WDT_501
@@ -477,20 +477,20 @@
 {
 	.minor	= TEMP_MINOR,
 	.name	= "temperature",
-	.fops	= &wdt_fops
+	.fops	= &wdt_fops,
 };
 #endif
 
 /*
  *	The WDT card needs to learn about soft shutdowns in order to
- *	turn the timebomb registers off. 
+ *	turn the timebomb registers off.
  */
- 
+
 static struct notifier_block wdt_notifier=
 {
 	.notifier_call = wdt_notify_sys,
 	.next = NULL,
-	.priority = 0
+	.priority = 0,
 };
 
 /**
@@ -502,13 +502,13 @@
  *	will not touch PC memory so all is fine. You just have to load a new
  *	module in 60 seconds or reboot.
  */
- 
+
 static void __exit wdt_exit(void)
 {
 	misc_deregister(&wdt_miscdev);
-#ifdef CONFIG_WDT_501	
+#ifdef CONFIG_WDT_501
 	misc_deregister(&temp_miscdev);
-#endif	
+#endif
 	unregister_reboot_notifier(&wdt_notifier);
 	release_region(io,8);
 	free_irq(irq, NULL);
@@ -521,7 +521,7 @@
  *	resources we require and bitch if anyone beat us to them.
  *	The open() function will actually kick the board off.
  */
- 
+
 static int __init wdt_init(void)
 {
 	int ret;
diff -Nru a/drivers/char/watchdog/wdt285.c b/drivers/char/watchdog/wdt285.c
--- a/drivers/char/watchdog/wdt285.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/wdt285.c	Sat Jan  3 00:01:55 2004
@@ -12,9 +12,9 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
+ *
  */
- 
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -79,7 +79,7 @@
 
 	*CSR_TIMER4_CLR = 0;
 	watchdog_ping();
-	*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_AUTORELOAD 
+	*CSR_TIMER4_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_AUTORELOAD
 		| TIMER_CNTL_DIV256;
 
 #ifdef ONLY_TESTING
@@ -132,7 +132,7 @@
 
 static struct watchdog_info ident = {
 	.options	= WDIOF_SETTIMEOUT,
-	.identity	= "Footbridge Watchdog"
+	.identity	= "Footbridge Watchdog",
 };
 
 static int
@@ -192,7 +192,7 @@
 static struct miscdevice watchdog_miscdev = {
 	.minor		= WATCHDOG_MINOR,
 	.name		= "watchdog",
-	.fops		= &watchdog_fops
+	.fops		= &watchdog_fops,
 };
 
 static int __init footbridge_watchdog_init(void)
@@ -206,7 +206,7 @@
 	if (retval < 0)
 		return retval;
 
-	printk("Footbridge Watchdog Timer: 0.01, timer margin: %d sec\n", 
+	printk("Footbridge Watchdog Timer: 0.01, timer margin: %d sec\n",
 	       soft_margin);
 
 	if (machine_is_cats())
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/wdt977.c	Sat Jan  3 00:01:55 2004
@@ -258,11 +258,11 @@
 
 static struct watchdog_info ident = {
 	.options	= WDIOF_SETTIMEOUT,
-	.identity	= "Winbond 83977"
+	.identity	= "Winbond 83977",
 };
 
 static int wdt977_ioctl(struct inode *inode, struct file *file,
-         unsigned int cmd, unsigned long arg)
+	unsigned int cmd, unsigned long arg)
 {
 	int temp;
 
@@ -342,7 +342,7 @@
 {
 	.minor		= WATCHDOG_MINOR,
 	.name		= "watchdog",
-	.fops		= &wdt977_fops
+	.fops		= &wdt977_fops,
 };
 
 static int __init nwwatchdog_init(void)
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Sat Jan  3 00:01:55 2004
+++ b/drivers/char/watchdog/wdt_pci.c	Sat Jan  3 00:01:55 2004
@@ -8,10 +8,10 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
@@ -95,7 +95,7 @@
 /*
  *	Programming support
  */
- 
+
 static void wdtpci_ctr_mode(int ctr, int mode)
 {
 	ctr<<=6;
@@ -113,29 +113,29 @@
 /*
  *	Kernel methods.
  */
- 
- 
+
+
 /**
  *	wdtpci_status:
- *	
+ *
  *	Extract the status information from a WDT watchdog device. There are
  *	several board variants so we have to know which bits are valid. Some
  *	bits default to one and some to zero in order to be maximally painful.
  *
  *	we then map the bits onto the status ioctl flags.
  */
- 
+
 static int wdtpci_status(void)
 {
 	/*
 	 *	Status register to bit flags
 	 */
-	 
+
 	int flag=0;
 	unsigned char status=inb_p(WDT_SR);
 	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;	
-	
+	status&=~FEATUREMAP2;
+
 	if(!(status&WDC_SR_TGOOD))
 		flag|=WDIOF_OVERHEAT;
 	if(!(status&WDC_SR_PSUOVER))
@@ -161,21 +161,21 @@
  *	map changes in what the board considers an interesting way. That means
  *	a failure condition occurring.
  */
- 
+
 static irqreturn_t wdtpci_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Read the status register see what is up and
-	 *	then printk it. 
+	 *	then printk it.
 	 */
-	 
+
 	unsigned char status=inb_p(WDT_SR);
-	
+
 	status|=FEATUREMAP1;
-	status&=~FEATUREMAP2;	
-	
+	status&=~FEATUREMAP2;
+
 	printk(KERN_CRIT "WDT status %d\n", status);
-	
+
 	if(!(status&WDC_SR_TGOOD))
 		printk(KERN_CRIT "Overheat alarm.(%d)\n",inb_p(WDT_RT));
 	if(!(status&WDC_SR_PSUOVER))
@@ -188,10 +188,10 @@
 #ifdef SOFTWARE_REBOOT
 #ifdef ONLY_TESTING
 		printk(KERN_CRIT "Would Reboot.\n");
-#else		
+#else
 		printk(KERN_CRIT "Initiating system reboot.\n");
 		machine_restart(NULL);
-#endif		
+#endif
 #else
 		printk(KERN_CRIT "Reset in 5ms.\n");
 #endif
@@ -203,9 +203,9 @@
  *	wdtpci_ping:
  *
  *	Reload counter one with the watchdog timeout. We don't bother reloading
- *	the cascade counter. 
+ *	the cascade counter.
  */
- 
+
 static void wdtpci_ping(void)
 {
 	unsigned long flags;
@@ -222,14 +222,14 @@
 /**
  *	wdtpci_write:
  *	@file: file handle to the watchdog
- *	@buf: buffer to write (unused as data does not matter here 
+ *	@buf: buffer to write (unused as data does not matter here
  *	@count: count of bytes
  *	@ppos: pointer to the position to write. No seeks allowed
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
  *	write of data will do, as we we don't define content meaning.
  */
- 
+
 static ssize_t wdtpci_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	/*  Can't seek (pwrite) on this device  */
@@ -266,12 +266,12 @@
  *	Read reports the temperature in degrees Fahrenheit. The API is in
  *	fahrenheit. It was designed by an imperial measurement luddite.
  */
- 
+
 static ssize_t wdtpci_read(struct file *file, char *buf, size_t count, loff_t *ptr)
 {
 	unsigned short c=inb_p(WDT_RT);
 	unsigned char cp;
-	
+
 	/*  Can't seek (pread) on this device  */
 	if (ptr != &file->f_pos)
 		return -ESPIPE;
@@ -299,9 +299,9 @@
  *
  *	The watchdog API defines a common set of functions for all watchdogs
  *	according to their available features. We only actually usefully support
- *	querying capabilities and current status. 
+ *	querying capabilities and current status.
  */
- 
+
 static int wdtpci_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 	unsigned long arg)
 {
@@ -314,7 +314,7 @@
 		.firmware_version = 1,
 		.identity	  = "WDT500/501PCI",
 	};
-	
+
 	ident.options&=WDT_OPTION_MASK;	/* Mask down to the card we have */
 	switch(cmd)
 	{
@@ -351,12 +351,12 @@
  *	@file: file handle to device
  *
  *	One of our two misc devices has been opened. The watchdog device is
- *	single open and on opening we load the counters. Counter zero is a 
+ *	single open and on opening we load the counters. Counter zero is a
  *	100Hz cascade, into counter 1 which downcounts to reboot. When the
  *	counter triggers counter 2 downcounts the length of the reset pulse
- *	which set set to be as long as possible. 
+ *	which set set to be as long as possible.
  */
- 
+
 static int wdtpci_open(struct inode *inode, struct file *file)
 {
 	unsigned long flags;
@@ -371,17 +371,17 @@
 				__module_get(THIS_MODULE);
 			}
 			/*
-			 *	Activate 
+			 *	Activate
 			 */
 			spin_lock_irqsave(&wdtpci_lock, flags);
-			
+
 			inb_p(WDT_DC);		/* Disable */
 
 			/*
 			 * "pet" the watchdog, as Access says.
 			 * This resets the clock outputs.
 			 */
-				
+
 			wdtpci_ctr_mode(2,0);
 			outb_p(0, WDT_DC);
 
@@ -413,13 +413,13 @@
  *	@inode: inode to board
  *	@file: file handle to board
  *
- *	The watchdog has a configurable API. There is a religious dispute 
- *	between people who want their watchdog to be able to shut down and 
+ *	The watchdog has a configurable API. There is a religious dispute
+ *	between people who want their watchdog to be able to shut down and
  *	those who want to be sure if the watchdog manager dies the machine
  *	reboots. In the former case we disable the counters, in the latter
  *	case you have to open it again very soon.
  */
- 
+
 static int wdtpci_release(struct inode *inode, struct file *file)
 {
 
@@ -466,12 +466,12 @@
 	}
 	return NOTIFY_DONE;
 }
- 
+
 /*
  *	Kernel Interfaces
  */
- 
- 
+
+
 static struct file_operations wdtpci_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -498,9 +498,9 @@
 
 /*
  *	The WDT card needs to learn about soft shutdowns in order to
- *	turn the timebomb registers off. 
+ *	turn the timebomb registers off.
  */
- 
+
 static struct notifier_block wdtpci_notifier = {
 	.notifier_call = wdtpci_notify_sys,
 };
@@ -585,7 +585,7 @@
 	unregister_reboot_notifier(&wdtpci_notifier);
 #ifdef CONFIG_WDT_501_PCI
 	misc_deregister(&temp_miscdev);
-#endif	
+#endif
 	misc_deregister(&wdtpci_miscdev);
 	free_irq(irq, &wdtpci_miscdev);
 	release_region(io, 16);
@@ -621,7 +621,7 @@
  *	will not touch PC memory so all is fine. You just have to load a new
  *	module in 60 seconds or reboot.
  */
- 
+
 static void __exit wdtpci_cleanup(void)
 {
 	pci_unregister_driver (&wdtpci_driver);
@@ -635,14 +635,14 @@
  *	resources we require and bitch if anyone beat us to them.
  *	The open() function will actually kick the board off.
  */
- 
+
 static int __init wdtpci_init(void)
 {
 	int rc = pci_register_driver (&wdtpci_driver);
-	
+
 	if (rc < 1)
 		return -ENODEV;
-	
+
 	return 0;
 }
 
diff -Nru a/drivers/char/watchdog/advantechwdt.c b/drivers/char/watchdog/advantechwdt.c
--- a/drivers/char/watchdog/advantechwdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/advantechwdt.c	Sat Jan  3 00:02:16 2004
@@ -183,7 +183,7 @@
 	}
 
 	default:
-	  return -ENOTTY;
+	  return -ENOIOCTLCMD;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/amd7xx_tco.c b/drivers/char/watchdog/amd7xx_tco.c
--- a/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:02:16 2004
@@ -175,7 +175,7 @@
 
 	switch (cmd) {
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof ident))
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/cpu5wdt.c	Sat Jan  3 00:02:16 2004
@@ -183,7 +183,7 @@
 			}
 			break;
 		default:
-    			return -EINVAL;
+    			return -ENOIOCTLCMD;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/eurotechwdt.c b/drivers/char/watchdog/eurotechwdt.c
--- a/drivers/char/watchdog/eurotechwdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/eurotechwdt.c	Sat Jan  3 00:02:16 2004
@@ -277,7 +277,7 @@
 
 	switch(cmd) {
 	default:
-		return -ENOTTY;
+		return -ENOIOCTLCMD;
 
 	case WDIOC_GETSUPPORT:
 		return copy_to_user((struct watchdog_info *)arg, &ident,
diff -Nru a/drivers/char/watchdog/i810-tco.c b/drivers/char/watchdog/i810-tco.c
--- a/drivers/char/watchdog/i810-tco.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/i810-tco.c	Sat Jan  3 00:02:16 2004
@@ -255,7 +255,7 @@
 	};
 	switch (cmd) {
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user
 			    ((struct watchdog_info *) arg, &ident, sizeof (ident)))
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:02:16 2004
@@ -207,7 +207,7 @@
 	  break;
 
 	default:
-	  return -ENOTTY;
+	  return -ENOIOCTLCMD;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/machzwd.c b/drivers/char/watchdog/machzwd.c
--- a/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/machzwd.c	Sat Jan  3 00:02:16 2004
@@ -366,7 +366,7 @@
 			break;
 
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 	}
 
 	return 0;
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/mixcomwd.c	Sat Jan  3 00:02:16 2004
@@ -192,7 +192,7 @@
 			mixcomwd_ping();
 			break;
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/pcwd.c	Sat Jan  3 00:02:16 2004
@@ -255,7 +255,7 @@
 
 	switch(cmd) {
 	default:
-		return -ENOTTY;
+		return -ENOIOCTLCMD;
 
 	case WDIOC_GETSUPPORT:
 		if(copy_to_user((void*)arg, &ident, sizeof(ident)))
diff -Nru a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
--- a/drivers/char/watchdog/sc1200wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/sc1200wdt.c	Sat Jan  3 00:02:16 2004
@@ -180,7 +180,7 @@
 
 	switch (cmd) {
 		default:
-			return -ENOTTY;	/* Keep Pavel Machek amused ;) */
+			return -ENOIOCTLCMD;	/* Keep Pavel Machek amused ;) */
 
 		case WDIOC_GETSUPPORT:
 			if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof ident))
diff -Nru a/drivers/char/watchdog/scx200_wdt.c b/drivers/char/watchdog/scx200_wdt.c
--- a/drivers/char/watchdog/scx200_wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/scx200_wdt.c	Sat Jan  3 00:02:16 2004
@@ -170,7 +170,7 @@
 
 	switch (cmd) {
 	default:
-		return -ENOTTY;
+		return -ENOIOCTLCMD;
 	case WDIOC_GETSUPPORT:
 		if(copy_to_user((struct watchdog_info *)arg, &ident,
 				sizeof(ident)))
diff -Nru a/drivers/char/watchdog/shwdt.c b/drivers/char/watchdog/shwdt.c
--- a/drivers/char/watchdog/shwdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/shwdt.c	Sat Jan  3 00:02:16 2004
@@ -303,7 +303,7 @@
 			return retval;
 		}
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 	}
 
 	return 0;
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/softdog.c	Sat Jan  3 00:02:16 2004
@@ -170,7 +170,7 @@
 	};
 	switch (cmd) {
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 		case WDIOC_GETSUPPORT:
 			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
 				return -EFAULT;
diff -Nru a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/w83627hf_wdt.c	Sat Jan  3 00:02:16 2004
@@ -184,7 +184,7 @@
 	}
 
 	default:
-	  return -ENOTTY;
+	  return -ENOIOCTLCMD;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/wafer5823wdt.c b/drivers/char/watchdog/wafer5823wdt.c
--- a/drivers/char/watchdog/wafer5823wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/wafer5823wdt.c	Sat Jan  3 00:02:16 2004
@@ -182,7 +182,7 @@
 	}
 
 	default:
-		return -ENOTTY;
+		return -ENOIOCTLCMD;
 	}
 	return 0;
 }
diff -Nru a/drivers/char/watchdog/wdt.c b/drivers/char/watchdog/wdt.c
--- a/drivers/char/watchdog/wdt.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/wdt.c	Sat Jan  3 00:02:16 2004
@@ -333,7 +333,7 @@
 	switch(cmd)
 	{
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 
diff -Nru a/drivers/char/watchdog/wdt977.c b/drivers/char/watchdog/wdt977.c
--- a/drivers/char/watchdog/wdt977.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/wdt977.c	Sat Jan  3 00:02:16 2004
@@ -269,7 +269,7 @@
 	switch(cmd)
 	{
 	default:
-		return -ENOTTY;
+		return -ENOIOCTLCMD;
 
 	case WDIOC_GETSUPPORT:
 	    return copy_to_user((struct watchdog_info *)arg, &ident,
diff -Nru a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c	Sat Jan  3 00:02:16 2004
+++ b/drivers/char/watchdog/wdt_pci.c	Sat Jan  3 00:02:16 2004
@@ -319,7 +319,7 @@
 	switch(cmd)
 	{
 		default:
-			return -ENOTTY;
+			return -ENOIOCTLCMD;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 
diff -Nru a/drivers/char/watchdog/ib700wdt.c b/drivers/char/watchdog/ib700wdt.c
--- a/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:02:37 2004
+++ b/drivers/char/watchdog/ib700wdt.c	Sat Jan  3 00:02:37 2004
@@ -1,5 +1,5 @@
 /*
- *	IB700 Single Board Computer WDT driver for Linux 2.4.x
+ *	IB700 Single Board Computer WDT driver
  *
  *	(c) Copyright 2001 Charles Howes <chowes@vsol.net>
  *
diff -Nru a/drivers/char/watchdog/amd7xx_tco.c b/drivers/char/watchdog/amd7xx_tco.c
--- a/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:02:57 2004
+++ b/drivers/char/watchdog/amd7xx_tco.c	Sat Jan  3 00:02:57 2004
@@ -19,6 +19,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
@@ -59,9 +60,18 @@
 static spinlock_t amdtco_lock;	/* only for device access */
 static char expect_close;
 
-MODULE_PARM(timeout, "i");
+module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "range is 0-38 seconds, default is 38");
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+
 static inline u8 seconds_to_ticks(int seconds)
 {
 	/* the internal timer is stored as ticks which decrement
@@ -243,19 +253,19 @@
 		return -ESPIPE;
 
 	if (len) {
-#ifndef CONFIG_WATCHDOG_NOWAYOUT
-		size_t i;
-		char c;
-		expect_close = 0;
-
-		for (i = 0; i != len; i++) {
-			if (get_user(c, data + i))
-				return -EFAULT;
-
-			if (c == 'V')
-				expect_close = 42;
+		if (!nowayout)
+			size_t i;
+			char c;
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				if (get_user(c, data + i))
+					return -EFAULT;
+
+				if (c == 'V')
+					expect_close = 42;
+			}
 		}
-#endif
 		amdtco_ping();
 	}
 
