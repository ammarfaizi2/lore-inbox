Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269145AbTB0BEQ>; Wed, 26 Feb 2003 20:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269146AbTB0BEQ>; Wed, 26 Feb 2003 20:04:16 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:31748 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269145AbTB0BEM>; Wed, 26 Feb 2003 20:04:12 -0500
Subject: [PATCH] 2.5.63 many are called but none are choosen.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Feb 2003 18:13:31 -0700
Message-Id: <1046308413.7527.304.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The past tense of choose is chose, not choosed.
The past participle of choose is chosen, not choosen.

This patch replaces the following:

choosed -> chose
choosen -> chosen

This was diffed against the 2.5 tree as it was this morning.

Steven

 arch/mips/Makefile               |    2 +-
 arch/sparc64/kernel/head.S       |    2 +-
 arch/sparc64/kernel/trampoline.S |    2 +-
 drivers/char/epca.c              |    2 +-
 drivers/char/rio/riotty.c        |    2 +-
 drivers/media/video/zr36067.c    |    2 +-
 drivers/net/bonding.c            |    2 +-
 drivers/scsi/ncr53c8xx.c         |    2 +-
 drivers/usb/media/pwc-ctrl.c     |    2 +-
 include/asm-mips/rrm.h           |    2 +-
 include/asm-mips/siginfo.h       |    2 +-
 include/asm-mips64/rrm.h         |    2 +-
 include/asm-mips64/siginfo.h     |    2 +-
 net/ipv4/fib_semantics.c         |    2 +-
 net/sched/sch_red.c              |    2 +-
 net/unix/af_unix.c               |    2 +-
 sound/core/pcm_lib.c             |    2 +-
 sound/pci/cmipci.c               |    2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff -ur 2.5-current/arch/mips/Makefile linux/arch/mips/Makefile
--- 2.5-current/arch/mips/Makefile	Wed Feb 26 08:45:06 2003
+++ linux/arch/mips/Makefile	Wed Feb 26 08:51:53 2003
@@ -251,7 +251,7 @@
 #
 # Choosing incompatible machines durings configuration will result in
 # error messages during linking.  Select a default linkscript if
-# none has been choosen above.
+# none has been chosen above.
 #
 
 AFLAGS_vmlinux.lds.o := -DLOADADDR=$(LOADADDR)
diff -ur 2.5-current/arch/sparc64/kernel/head.S linux/arch/sparc64/kernel/head.S
--- 2.5-current/arch/sparc64/kernel/head.S	Wed Feb 26 08:45:23 2003
+++ linux/arch/sparc64/kernel/head.S	Wed Feb 26 08:51:53 2003
@@ -84,7 +84,7 @@
 	 nop
 
 cheetah_plus_boot:
-	/* Preserve OBP choosen DCU and DCR register settings.  */
+	/* Preserve OBP chosen DCU and DCR register settings.  */
 	ba,pt	%xcc, cheetah_generic_boot
 	 nop
 
diff -ur 2.5-current/arch/sparc64/kernel/trampoline.S linux/arch/sparc64/kernel/trampoline.S
--- 2.5-current/arch/sparc64/kernel/trampoline.S	Wed Feb 26 08:45:23 2003
+++ linux/arch/sparc64/kernel/trampoline.S	Wed Feb 26 08:51:53 2003
@@ -40,7 +40,7 @@
 	 nop
 
 cheetah_plus_startup:
-	/* Preserve OBP choosen DCU and DCR register settings.  */
+	/* Preserve OBP chosen DCU and DCR register settings.  */
 	ba,pt	%xcc, cheetah_generic_startup
 	 nop
 
diff -ur 2.5-current/drivers/char/epca.c linux/drivers/char/epca.c
--- 2.5-current/drivers/char/epca.c	Wed Feb 26 08:45:33 2003
+++ linux/drivers/char/epca.c	Wed Feb 26 08:51:53 2003
@@ -1660,7 +1660,7 @@
 
 	/* -----------------------------------------------------------------
 		Note : If lilo was used to configure the driver and the 
-		ignore epcaconfig option was choosen (digiepca=2) then 
+		ignore epcaconfig option was chosen (digiepca=2) then 
 		nbdevs and num_cards will equal 0 at this point.  This is
 		okay; PCI cards will still be picked up if detected.
 	--------------------------------------------------------------------- */
diff -ur 2.5-current/drivers/char/rio/riotty.c linux/drivers/char/rio/riotty.c
--- 2.5-current/drivers/char/rio/riotty.c	Wed Feb 26 08:45:23 2003
+++ linux/drivers/char/rio/riotty.c	Wed Feb 26 08:51:53 2003
@@ -233,7 +233,7 @@
 	}
 
 	/*
-	** If the RTA has not booted yet and the user has choosen to block
+	** If the RTA has not booted yet and the user has chosen to block
 	** until the RTA is present then we must spin here waiting for
 	** the RTA to boot.
 	*/
diff -ur 2.5-current/drivers/media/video/zr36067.c linux/drivers/media/video/zr36067.c
--- 2.5-current/drivers/media/video/zr36067.c	Wed Feb 26 08:45:59 2003
+++ linux/drivers/media/video/zr36067.c	Wed Feb 26 08:51:53 2003
@@ -4079,7 +4079,7 @@
 
 			/* Enforce reasonable lower and upper limits */
 			if (br.count < 4)
-				br.count = 4;	/* Could be choosen smaller */
+				br.count = 4;	/* Could be chosen smaller */
 			if (br.count > BUZ_MAX_FRAME)
 				br.count = BUZ_MAX_FRAME;
 			br.size = PAGE_ALIGN(br.size);
diff -ur 2.5-current/drivers/net/bonding.c linux/drivers/net/bonding.c
--- 2.5-current/drivers/net/bonding.c	Wed Feb 26 08:45:55 2003
+++ linux/drivers/net/bonding.c	Wed Feb 26 08:51:53 2003
@@ -1248,7 +1248,7 @@
 
 /* Choose a new valid interface from the pool, set it active
  * and make it the current slave. If no valid interface is
- * found, the oldest slave in BACK state is choosen and
+ * found, the oldest slave in BACK state is chosen and
  * activated. If none is found, it's considered as no
  * interfaces left so the current slave is set to NULL.
  * The result is a pointer to the current slave.
diff -ur 2.5-current/drivers/scsi/ncr53c8xx.c linux/drivers/scsi/ncr53c8xx.c
--- 2.5-current/drivers/scsi/ncr53c8xx.c	Wed Feb 26 08:45:20 2003
+++ linux/drivers/scsi/ncr53c8xx.c	Wed Feb 26 08:51:53 2003
@@ -854,7 +854,7 @@
 **	The first four bytes (scr_st[4]) are used inside the script by 
 **	"COPY" commands.
 **	Because source and destination must have the same alignment
-**	in a DWORD, the fields HAVE to be at the choosen offsets.
+**	in a DWORD, the fields HAVE to be at the chosen offsets.
 **		xerr_st		0	(0x34)	scratcha
 **		sync_st		1	(0x05)	sxfer
 **		wide_st		3	(0x03)	scntl3
diff -ur 2.5-current/drivers/usb/media/pwc-ctrl.c linux/drivers/usb/media/pwc-ctrl.c
--- 2.5-current/drivers/usb/media/pwc-ctrl.c	Wed Feb 26 08:45:57 2003
+++ linux/drivers/usb/media/pwc-ctrl.c	Wed Feb 26 08:51:53 2003
@@ -129,7 +129,7 @@
      4 compression modi: none, low, medium, high
      
    When an uncompressed mode is not available, the next available compressed mode 
-   will be choosen (unless the decompressor is absent). Sometimes there are only
+   will be chosen (unless the decompressor is absent). Sometimes there are only
    1 or 2 compressed modes available; in that case entries are duplicated.
 */
 struct Timon_table_entry 
diff -ur 2.5-current/include/asm-mips/rrm.h linux/include/asm-mips/rrm.h
--- 2.5-current/include/asm-mips/rrm.h	Wed Feb 26 08:45:10 2003
+++ linux/include/asm-mips/rrm.h	Wed Feb 26 08:53:40 2003
@@ -3,7 +3,7 @@
  *
  * written by Miguel de Icaza (miguel@nuclecu.unam.mx)
  *
- * Ok, even if SGI choosed to do mmap trough ioctls, their
+ * Ok, even if SGI chose to do mmap trough ioctls, their
  * kernel support for virtualizing the graphics card is nice.
  *
  * We should be able to make graphic applications on Linux
diff -ur 2.5-current/include/asm-mips/siginfo.h linux/include/asm-mips/siginfo.h
--- 2.5-current/include/asm-mips/siginfo.h	Wed Feb 26 08:45:31 2003
+++ linux/include/asm-mips/siginfo.h	Wed Feb 26 08:51:53 2003
@@ -82,7 +82,7 @@
 
 /*
  * si_code values
- * Again these have been choosen to be IRIX compatible.
+ * Again these have been chosen to be IRIX compatible.
  */
 #undef SI_ASYNCIO
 #undef SI_TIMER
diff -ur 2.5-current/include/asm-mips64/rrm.h linux/include/asm-mips64/rrm.h
--- 2.5-current/include/asm-mips64/rrm.h	Wed Feb 26 08:45:52 2003
+++ linux/include/asm-mips64/rrm.h	Wed Feb 26 08:53:40 2003
@@ -3,7 +3,7 @@
  *
  * written by Miguel de Icaza (miguel@nuclecu.unam.mx)
  *
- * Ok, even if SGI choosed to do mmap trough ioctls, their
+ * Ok, even if SGI chose to do mmap trough ioctls, their
  * kernel support for virtualizing the graphics card is nice.
  *
  * We should be able to make graphic applications on Linux
diff -ur 2.5-current/include/asm-mips64/siginfo.h linux/include/asm-mips64/siginfo.h
--- 2.5-current/include/asm-mips64/siginfo.h	Wed Feb 26 08:45:49 2003
+++ linux/include/asm-mips64/siginfo.h	Wed Feb 26 08:51:53 2003
@@ -83,7 +83,7 @@
 
 /*
  * si_code values
- * Again these have been choosen to be IRIX compatible.
+ * Again these have been chosen to be IRIX compatible.
  */
 #undef SI_ASYNCIO
 #undef SI_TIMER
diff -ur 2.5-current/net/ipv4/fib_semantics.c linux/net/ipv4/fib_semantics.c
--- 2.5-current/net/ipv4/fib_semantics.c	Wed Feb 26 08:45:10 2003
+++ linux/net/ipv4/fib_semantics.c	Wed Feb 26 08:53:40 2003
@@ -317,7 +317,7 @@
    Attempt to reconcile all of these (alas, self-contradictory) conditions
    results in pretty ugly and hairy code with obscure logic.
 
-   I choosed to generalized it instead, so that the size
+   I chose to generalized it instead, so that the size
    of code does not increase practically, but it becomes
    much more general.
    Every prefix is assigned a "scope" value: "host" is local address,
diff -ur 2.5-current/net/sched/sch_red.c linux/net/sched/sch_red.c
--- 2.5-current/net/sched/sch_red.c	Wed Feb 26 08:45:59 2003
+++ linux/net/sched/sch_red.c	Wed Feb 26 08:51:53 2003
@@ -61,7 +61,7 @@
 
 	avg = (1-W)*avg + W*current_queue_len,
 
-	W is the filter time constant (choosen as 2^(-Wlog)), it controls
+	W is the filter time constant (chosen as 2^(-Wlog)), it controls
 	the inertia of the algorithm. To allow larger bursts, W should be
 	decreased.
 
diff -ur 2.5-current/net/unix/af_unix.c linux/net/unix/af_unix.c
--- 2.5-current/net/unix/af_unix.c	Wed Feb 26 08:45:34 2003
+++ linux/net/unix/af_unix.c	Wed Feb 26 08:53:40 2003
@@ -1485,7 +1485,7 @@
 		   - do not return fds - good, but too simple 8)
 		   - return fds, and do not return them on read (old strategy,
 		     apparently wrong)
-		   - clone fds (I choosed it for now, it is the most universal
+		   - clone fds (I chose it for now, it is the most universal
 		     solution)
 		
 	           POSIX 1003.1g does not actually define this clearly
diff -ur 2.5-current/sound/core/pcm_lib.c linux/sound/core/pcm_lib.c
--- 2.5-current/sound/core/pcm_lib.c	Wed Feb 26 08:45:24 2003
+++ linux/sound/core/pcm_lib.c	Wed Feb 26 08:51:53 2003
@@ -1711,7 +1711,7 @@
  * snd_pcm_hw_param_choose
  *
  * Choose one configuration from configuration space defined by PARAMS
- * The configuration choosen is that obtained fixing in this order:
+ * The configuration chosen is that obtained fixing in this order:
  * first access, first format, first subformat, min channels,
  * min rate, min period time, max buffer size, min tick time
  */
diff -ur 2.5-current/sound/pci/cmipci.c linux/sound/pci/cmipci.c
--- 2.5-current/sound/pci/cmipci.c	Wed Feb 26 08:45:08 2003
+++ linux/sound/pci/cmipci.c	Wed Feb 26 08:51:53 2003
@@ -617,7 +617,7 @@
 
 /*
  * Program pll register bits, I assume that the 8 registers 0xf8 upto 0xff
- * are mapped onto the 8 ADC/DAC sampling frequency which can be choosen
+ * are mapped onto the 8 ADC/DAC sampling frequency which can be chosen
  * at the register CM_REG_FUNCTRL1 (0x04).
  * Problem: other ways are also possible (any information about that?)
  */



