Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRKVMpb>; Thu, 22 Nov 2001 07:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278587AbRKVMpW>; Thu, 22 Nov 2001 07:45:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:40680 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S278584AbRKVMpN>; Thu, 22 Nov 2001 07:45:13 -0500
Date: Thu, 22 Nov 2001 13:45:07 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jurriaan on Alpha <thunder7@xs4all.nl>, <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.15-pre9: s|linux/malloc.h|linux/slab.h|
In-Reply-To: <20011122124613.A5067@alpha.of.nowhere>
Message-ID: <Pine.NEB.4.42.0111221340350.21470-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Jurriaan on Alpha wrote:

> make[3]: Entering directory `/usr/src/linux-2.4.15pre9/drivers/scsi/sym53c8xx_2'
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.15pre9/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-al
> iasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6  -I.  -c -o sym_fw.o sym_fw.c
> In file included from sym_glue.h:80,
>                  from sym_fw.c:56:
> /usr/src/linux-2.4.15pre9/include/linux/malloc.h:4: warning: #warning linux/malloc.h is deprecated, use linux/slab.h instead.
>...


This warning is harmless. The patch below fixes the warning in this file
and in two other files:


--- drivers/scsi/sym53c8xx_2/sym_glue.h.old	Thu Nov 22 13:01:19 2001
+++ drivers/scsi/sym53c8xx_2/sym_glue.h	Thu Nov 22 13:02:41 2001
@@ -77,7 +77,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/string.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/time.h>
--- drivers/s390/s390io.c.old	Thu Nov 22 13:07:11 2001
+++ drivers/s390/s390io.c	Thu Nov 22 13:07:33 2001
@@ -33,7 +33,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
--- arch/arm/mach-epxa10db/dma.c.old	Thu Nov 22 13:39:23 2001
+++ arch/arm/mach-epxa10db/dma.c	Thu Nov 22 13:39:33 2001
@@ -19,7 +19,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mman.h>
 #include <linux/init.h>


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

