Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbSKUM4F>; Thu, 21 Nov 2002 07:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266623AbSKUM4F>; Thu, 21 Nov 2002 07:56:05 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:35844 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266627AbSKUMzs>; Thu, 21 Nov 2002 07:55:48 -0500
Date: Thu, 21 Nov 2002 11:02:41 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/net: fix up header cleanups: remove unneeded sched.h include
Message-ID: <20021121130241.GB31594@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	With the header cleanups there is not anymore a need to
include sched.h in those files.

	Now there are seven outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.928, 2002-11-21 10:30:19-02:00, acme@conectiva.com.br
  o net: fix up header cleanups: remove unneeded sched.h include


 3c501.c            |    1 -
 3c503.c            |    2 --
 3c505.c            |    2 --
 3c507.c            |   17 ++++++-----------
 3c509.c            |    4 +---
 3c515.c            |    9 +++------
 3c523.c            |   10 ++++------
 3c527.c            |   15 +++++++--------
 3c59x.c            |    2 +-
 68360enet.c        |    2 +-
 7990.c             |   27 ++++++++++++---------------
 82596.c            |    2 --
 a2065.c            |   12 +++++-------
 ac3200.c           |    2 --
 aironet4500_card.c |   20 +++++++++-----------
 aironet4500_core.c |    8 ++++----
 aironet4500_proc.c |   17 +++++++----------
 am79c961a.c        |    1 -
 apne.c             |    6 ++----
 ariadne.c          |    4 +---
 ariadne2.c         |    2 --
 at1700.c           |   15 ++++++---------
 atarilance.c       |    9 +++------
 atp.c              |   11 +++++------
 au1000_eth.c       |    4 ++--
 b44.c              |    1 -
 bagetlance.c       |   10 +++-------
 bonding.c          |   14 ++++++--------
 28 files changed, 88 insertions(+), 141 deletions(-)


diff -Nru a/drivers/net/3c501.c b/drivers/net/3c501.c
--- a/drivers/net/3c501.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c501.c	Thu Nov 21 10:55:40 2002
@@ -110,7 +110,6 @@
 #include <linux/module.h>
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/fcntl.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
diff -Nru a/drivers/net/3c503.c b/drivers/net/3c503.c
--- a/drivers/net/3c503.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c503.c	Thu Nov 21 10:55:40 2002
@@ -42,9 +42,7 @@
     DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE "  Donald Becker (becker@scyld.com)\n";
 
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/delay.h>
diff -Nru a/drivers/net/3c505.c b/drivers/net/3c505.c
--- a/drivers/net/3c505.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c505.c	Thu Nov 21 10:55:40 2002
@@ -97,9 +97,7 @@
  */
 
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
diff -Nru a/drivers/net/3c507.c b/drivers/net/3c507.c
--- a/drivers/net/3c507.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c507.c	Thu Nov 21 10:55:40 2002
@@ -32,9 +32,6 @@
 static const char version[] =
 	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Donald Becker (becker@scyld.com)\n";
 
-
-#include <linux/module.h>
-
 /*
   Sources:
 	This driver wouldn't have been written with the availability of the
@@ -46,8 +43,8 @@
 	info that the casual reader might think that it documents the i82586 :-<.
 */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
@@ -56,20 +53,18 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
-
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/errno.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 
+#include <asm/bitops.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
 
 /* use 0 for production, 1 for verification, 2..7 for debug */
 #ifndef NET_DEBUG
diff -Nru a/drivers/net/3c509.c b/drivers/net/3c509.c
--- a/drivers/net/3c509.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c509.c	Thu Nov 21 10:55:40 2002
@@ -68,10 +68,8 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-
 #include <linux/mca.h>
 #include <linux/isapnp.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
@@ -81,6 +79,7 @@
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/pm.h>
 #include <linux/skbuff.h>
 #include <linux/delay.h>	/* for udelay() */
 #include <linux/spinlock.h>
@@ -90,7 +89,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <linux/pm.h>
 
 static char versionA[] __initdata = DRV_NAME ".c:" DRV_VERSION " " DRV_RELDATE " becker@scyld.com\n";
 static char versionB[] __initdata = "http://www.scyld.com/network/3c509.html\n";
diff -Nru a/drivers/net/3c515.c b/drivers/net/3c515.c
--- a/drivers/net/3c515.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c515.c	Thu Nov 21 10:55:40 2002
@@ -62,14 +62,15 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/isapnp.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/netdevice.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/in.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/etherdevice.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/ethtool.h>
@@ -78,10 +79,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
 
 #define NEW_MULTICAST
 #include <linux/delay.h>
diff -Nru a/drivers/net/3c523.c b/drivers/net/3c523.c
--- a/drivers/net/3c523.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c523.c	Thu Nov 21 10:55:40 2002
@@ -90,12 +90,15 @@
 #define DRV_NAME		"3c523"
 #define DRV_VERSION		"17-Nov-2001"
 
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -106,11 +109,6 @@
 #include <asm/processor.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/init.h>
 
 #include "3c523.h"
 
diff -Nru a/drivers/net/3c527.c b/drivers/net/3c527.c
--- a/drivers/net/3c527.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c527.c	Thu Nov 21 10:55:40 2002
@@ -83,16 +83,22 @@
 
 #include <linux/module.h>
 
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
 #include <linux/mca.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/wait.h>
 #include <linux/ethtool.h>
 
 #include <asm/uaccess.h>
@@ -100,13 +106,6 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/if_ether.h>
 
 #include "3c527.h"
 
diff -Nru a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/3c59x.c	Thu Nov 21 10:55:40 2002
@@ -244,7 +244,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
@@ -260,6 +259,7 @@
 #include <linux/skbuff.h>
 #include <linux/ethtool.h>
 #include <linux/highmem.h>
+
 #include <asm/irq.h>			/* For NR_IRQS only. */
 #include <asm/bitops.h>
 #include <asm/io.h>
diff -Nru a/drivers/net/68360enet.c b/drivers/net/68360enet.c
--- a/drivers/net/68360enet.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/68360enet.c	Thu Nov 21 10:55:40 2002
@@ -25,7 +25,6 @@
  */
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/ptrace.h>
 #include <linux/errno.h>
@@ -38,6 +37,7 @@
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h> 
+
 #include <asm/irq.h>
 #include <asm/m68360.h>
 /* #include <asm/8xx_immap.h> */
diff -Nru a/drivers/net/7990.c b/drivers/net/7990.c
--- a/drivers/net/7990.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/7990.c	Thu Nov 21 10:55:40 2002
@@ -12,35 +12,32 @@
  * most of a2025 and sunlance with the aim of merging them, so the 
  * common code was pretty obvious.
  */
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/dio.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
+#include <linux/route.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/delay.h>
-#include <linux/init.h>
-#include <linux/crc32.h>
+#include <linux/skbuff.h>
+/* Used for the temporal inet entries and routing */
+#include <linux/socket.h>
+
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/pgtable.h>
-#include <linux/errno.h>
-
-/* Used for the temporal inet entries and routing */
-#include <linux/socket.h>
-#include <linux/route.h>
-
-#include <linux/dio.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
 
 #include "7990.h"
 
diff -Nru a/drivers/net/82596.c b/drivers/net/82596.c
--- a/drivers/net/82596.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/82596.c	Thu Nov 21 10:55:40 2002
@@ -42,9 +42,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
diff -Nru a/drivers/net/a2065.c b/drivers/net/a2065.c
--- a/drivers/net/a2065.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/a2065.c	Thu Nov 21 10:55:40 2002
@@ -37,29 +37,27 @@
  *	  both 10BASE-2 (thin coax) and AUI (DB-15) connectors
  */
 
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/crc32.h>
+#include <linux/zorro.h>
 
 #include <asm/bitops.h>
 #include <asm/irq.h>
-#include <linux/errno.h>
-
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
-#include <linux/zorro.h>
 
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
 #include "a2065.h"
 
 
diff -Nru a/drivers/net/ac3200.c b/drivers/net/ac3200.c
--- a/drivers/net/ac3200.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/ac3200.c	Thu Nov 21 10:55:40 2002
@@ -25,9 +25,7 @@
 	"ac3200.c:v1.01 7/1/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
 
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/netdevice.h>
diff -Nru a/drivers/net/aironet4500_card.c b/drivers/net/aironet4500_card.c
--- a/drivers/net/aironet4500_card.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/aironet4500_card.c	Thu Nov 21 10:55:40 2002
@@ -16,28 +16,26 @@
 "aironet4500_cards.c v0.2  Feb 27, 2000  Elmer Joandi, elmer@ylenurme.ee.\n";
 #endif
 
-#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/config.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/in.h>
+#include <linux/version.h>
+
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/if_arp.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/init.h>
 
 #include "aironet4500.h"
 
diff -Nru a/drivers/net/aironet4500_core.c b/drivers/net/aironet4500_core.c
--- a/drivers/net/aironet4500_core.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/aironet4500_core.c	Thu Nov 21 10:55:40 2002
@@ -18,6 +18,7 @@
 	10.03.00 looks like softnet take us back to normal on SMP
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/config.h>
@@ -28,17 +29,16 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 #include <linux/ioport.h>
+#include <linux/ip.h>
+#include <linux/time.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
 #include <asm/byteorder.h>
 #include <asm/irq.h>
-#include <linux/time.h>
-#include <linux/sched.h>
-#include <linux/delay.h>
+
 #include "aironet4500.h"
-#include <linux/ip.h>
 
 
 int bap_sleep = 10 ;
diff -Nru a/drivers/net/aironet4500_proc.c b/drivers/net/aironet4500_proc.c
--- a/drivers/net/aironet4500_proc.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/aironet4500_proc.c	Thu Nov 21 10:55:40 2002
@@ -9,28 +9,25 @@
  *
  *
  */
+#include <linux/config.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/module.h>
+#include <linux/if_arp.h>
 #include <linux/init.h>
-#include <linux/config.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
-
 #include <linux/version.h>
-
-#include <linux/sched.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/in.h>
+
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/if_arp.h>
-#include <linux/ioport.h>
 
 #ifdef CONFIG_PROC_FS
 
diff -Nru a/drivers/net/am79c961a.c b/drivers/net/am79c961a.c
--- a/drivers/net/am79c961a.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/am79c961a.c	Thu Nov 21 10:55:40 2002
@@ -14,7 +14,6 @@
  * note that this can not be built as a module (it doesn't make sense).
  */
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
diff -Nru a/drivers/net/apne.c b/drivers/net/apne.c
--- a/drivers/net/apne.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/apne.c	Thu Nov 21 10:55:40 2002
@@ -30,17 +30,15 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <asm/system.h>
-#include <asm/io.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 
+#include <asm/system.h>
+#include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
diff -Nru a/drivers/net/ariadne.c b/drivers/net/ariadne.c
--- a/drivers/net/ariadne.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/ariadne.c	Thu Nov 21 10:55:40 2002
@@ -38,7 +38,6 @@
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -48,12 +47,11 @@
 #include <linux/interrupt.h>
 #include <linux/skbuff.h>
 #include <linux/init.h>
+#include <linux/zorro.h>
 
 #include <asm/bitops.h>
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
-#include <linux/zorro.h>
-
 #include <asm/irq.h>
 
 #include "ariadne.h"
diff -Nru a/drivers/net/ariadne2.c b/drivers/net/ariadne2.c
--- a/drivers/net/ariadne2.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/ariadne2.c	Thu Nov 21 10:55:40 2002
@@ -21,7 +21,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -30,7 +29,6 @@
 #include <linux/zorro.h>
 
 #include <asm/system.h>
-
 #include <asm/irq.h>
 #include <asm/amigaints.h>
 #include <asm/amigahw.h>
diff -Nru a/drivers/net/at1700.c b/drivers/net/at1700.c
--- a/drivers/net/at1700.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/at1700.c	Thu Nov 21 10:55:40 2002
@@ -36,30 +36,27 @@
 */
 
 #include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/mca.h>
 #include <linux/module.h>
-
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/in.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/crc32.h>
+
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
-#include <linux/errno.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-
-#include <linux/mca.h>
 
 static char version[] __initdata =
 	"at1700.c:v1.15 4/7/98  Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
diff -Nru a/drivers/net/atarilance.c b/drivers/net/atarilance.c
--- a/drivers/net/atarilance.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/atarilance.c	Thu Nov 21 10:55:40 2002
@@ -45,13 +45,14 @@
 static char version[] = "atarilance.c: v1.3 04/04/96 "
 					   "Roman.Hodek@informatik.uni-erlangen.de\n";
 
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/module.h>
-
 #include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -62,10 +63,6 @@
 #include <asm/atariints.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
-
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
 
 /* Debug level:
  *  0 = silent, print only serious errors
diff -Nru a/drivers/net/atp.c b/drivers/net/atp.c
--- a/drivers/net/atp.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/atp.c	Thu Nov 21 10:55:40 2002
@@ -126,7 +126,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
@@ -134,19 +133,19 @@
 #include <linux/in.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/crc32.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
+
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/dma.h>
 
 #include "atp.h"
 
diff -Nru a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
--- a/drivers/net/au1000_eth.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/au1000_eth.c	Thu Nov 21 10:55:40 2002
@@ -33,7 +33,6 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
@@ -48,12 +47,13 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/crc32.h>
+
 #include <asm/mipsregs.h>
 #include <asm/irq.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
-
 #include <asm/au1000.h>
+
 #include "au1000_eth.h"
 
 #ifdef AU1000_ETH_DEBUG
diff -Nru a/drivers/net/b44.c b/drivers/net/b44.c
--- a/drivers/net/b44.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/b44.c	Thu Nov 21 10:55:40 2002
@@ -12,7 +12,6 @@
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 #include <linux/pci.h>
-#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 
diff -Nru a/drivers/net/bagetlance.c b/drivers/net/bagetlance.c
--- a/drivers/net/bagetlance.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/bagetlance.c	Thu Nov 21 10:55:40 2002
@@ -15,24 +15,20 @@
 static char *version = "bagetlance.c: v1.1 11/10/98\n";
 
 #include <linux/module.h>
-
 #include <linux/stddef.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/bitops.h>
-#include <asm/io.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
+#include <asm/irq.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
 #include <asm/baget/baget.h>
 
 #define BAGET_LANCE_IRQ  BAGET_IRQ_MASK(0xdf)
diff -Nru a/drivers/net/bonding.c b/drivers/net/bonding.c
--- a/drivers/net/bonding.c	Thu Nov 21 10:55:40 2002
+++ b/drivers/net/bonding.c	Thu Nov 21 10:55:40 2002
@@ -196,7 +196,6 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
@@ -207,25 +206,24 @@
 #include <linux/init.h>
 #include <linux/timer.h>
 #include <linux/socket.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
-#include <asm/uaccess.h>
 #include <linux/errno.h>
-
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <linux/rtnetlink.h>
-
 #include <linux/if_bonding.h>
 #include <linux/smp.h>
 #include <linux/if_ether.h>
 #include <linux/if_arp.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/uaccess.h>
 
 
 /* monitor all links that often (in milliseconds). <=0 disables monitoring */

===================================================================


This BitKeeper patch contains the following changesets:
1.928
## Wrapped with gzip_uu ##


begin 664 bkpatch20509
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
5GM;;Q7M!D*N5D+/_`QD)ZM)/4P``
`
end
