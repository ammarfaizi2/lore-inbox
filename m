Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVEHT7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVEHT7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVEHT61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:58:27 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:4759 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262940AbVEHTKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:21 -0400
Message-Id: <20050508184350.018789000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:05 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 36/37] bt8xx: whitespace cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whitespace cleanup

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/bt878.c |   36 ++++++++++++++++++------------------
 drivers/media/dvb/bt8xx/bt878.h |    6 +++---
 2 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/bt878.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/bt878.h	2005-05-08 18:09:00.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/bt878.h	2005-05-08 18:14:17.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
     bt878.h - Bt878 audio module (register offsets)
 
     Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
@@ -120,14 +120,14 @@ struct bt878 {
 	u32 risc_pos;
 
 	struct tasklet_struct tasklet;
-	int shutdown;	
+	int shutdown;
 };
 
 extern struct bt878 bt878[BT878_MAX];
 
 void bt878_start(struct bt878 *bt, u32 controlreg, u32 op_sync_orin,
 		u32 irq_err_ignore);
-void bt878_stop(struct bt878 *bt);	     
+void bt878_stop(struct bt878 *bt);
 
 #if defined(__powerpc__)	/* big-endian */
 extern __inline__ void io_st_le32(volatile unsigned __iomem *addr, unsigned val)
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/bt878.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/bt878.c	2005-05-08 18:13:30.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/bt878.c	2005-05-08 18:14:17.000000000 +0200
@@ -12,19 +12,19 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version 2
  * of the License, or (at your option) any later version.
- * 
+ *
 
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
 
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
- * 
+ *
  */
 
 #include <linux/module.h>
@@ -58,7 +58,7 @@ module_param_named(verbose, bt878_verbos
 MODULE_PARM_DESC(verbose,
 		 "verbose startup messages, default is 1 (yes)");
 module_param_named(debug, bt878_debug, int, 0644);
-MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
+MODULE_PARM_DESC(debug, "Turn on/off debugging, default is 0 (off).");
 
 int bt878_num;
 struct bt878 bt878[BT878_MAX];
@@ -128,21 +128,21 @@ static int bt878_mem_alloc(struct bt878 
 }
 
 /* RISC instructions */
-#define RISC_WRITE        	(0x01 << 28)
-#define RISC_JUMP         	(0x07 << 28)
-#define RISC_SYNC         	(0x08 << 28)
+#define RISC_WRITE		(0x01 << 28)
+#define RISC_JUMP		(0x07 << 28)
+#define RISC_SYNC		(0x08 << 28)
 
 /* RISC bits */
-#define RISC_WR_SOL       	(1 << 27)
-#define RISC_WR_EOL       	(1 << 26)
-#define RISC_IRQ          	(1 << 24)
+#define RISC_WR_SOL		(1 << 27)
+#define RISC_WR_EOL		(1 << 26)
+#define RISC_IRQ		(1 << 24)
 #define RISC_STATUS(status)	((((~status) & 0x0F) << 20) | ((status & 0x0F) << 16))
-#define RISC_SYNC_RESYNC  	(1 << 15)
-#define RISC_SYNC_FM1     	0x06
-#define RISC_SYNC_VRO     	0x0C
+#define RISC_SYNC_RESYNC	(1 << 15)
+#define RISC_SYNC_FM1		0x06
+#define RISC_SYNC_VRO		0x0C
 
 #define RISC_FLUSH()		bt->risc_pos = 0
-#define RISC_INSTR(instr) 	bt->risc_cpu[bt->risc_pos++] = cpu_to_le32(instr)
+#define RISC_INSTR(instr)	bt->risc_cpu[bt->risc_pos++] = cpu_to_le32(instr)
 
 static int bt878_make_risc(struct bt878 *bt)
 {
@@ -173,7 +173,7 @@ static void bt878_risc_program(struct bt
 	RISC_INSTR(RISC_SYNC | RISC_SYNC_FM1 | op_sync_orin);
 	RISC_INSTR(0);
 
-	dprintk("bt878: risc len lines %u, bytes per line %u\n", 
+	dprintk("bt878: risc len lines %u, bytes per line %u\n",
 			bt->line_count, bt->line_bytes);
 	for (line = 0; line < bt->line_count; line++) {
 		// At the beginning of every block we issue an IRQ with previous (finished) block number set
@@ -228,14 +228,14 @@ void bt878_start(struct bt878 *bt, u32 c
 	 * Hacked for DST to:
 	 * SCERR | OCERR | FDSR | FTRGT | FBUS | RISCI
 	 */
-	int_mask = BT878_ASCERR | BT878_AOCERR | BT878_APABORT | 
-		BT878_ARIPERR | BT878_APPERR | BT878_AFDSR | BT878_AFTRGT | 
+	int_mask = BT878_ASCERR | BT878_AOCERR | BT878_APABORT |
+		BT878_ARIPERR | BT878_APPERR | BT878_AFDSR | BT878_AFTRGT |
 		BT878_AFBUS | BT878_ARISCI;
 
 
 	/* ignore pesky bits */
 	int_mask &= ~irq_err_ignore;
-	
+
 	btwrite(int_mask, BT878_AINT_MASK);
 	btwrite(controlreg, BT878_AGPIO_DMA_CTL);
 }

--

