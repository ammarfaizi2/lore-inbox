Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUFGN3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUFGN3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUFGML0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:11:26 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14465 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264623AbUFGL42 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:28 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609354985@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093541162@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 30/39] input: Trailing whitespace fixes in drivers/input/gameport
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.10, 2004-05-10 01:34:55-05:00, dtor_core@ameritech.net
  Input: trailing whitespace fixes in drivers/input/gameport


 cs461x.c     |   30 +++++++++++++++---------------
 emu10k1-gp.c |   12 ++++++------
 fm801-gp.c   |    2 +-
 gameport.c   |    2 +-
 lightning.c  |   16 ++++++++--------
 ns558.c      |   14 +++++++-------
 vortex.c     |    6 +++---
 7 files changed, 41 insertions(+), 41 deletions(-)

===================================================================

diff -Nru a/drivers/input/gameport/cs461x.c b/drivers/input/gameport/cs461x.c
--- a/drivers/input/gameport/cs461x.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/cs461x.c	2004-06-07 13:11:06 +02:00
@@ -1,8 +1,8 @@
 /*
-	The all defines and part of code (such as cs461x_*) are 
-	contributed from ALSA 0.5.8 sources. 
+	The all defines and part of code (such as cs461x_*) are
+	contributed from ALSA 0.5.8 sources.
 	See http://www.alsa-project.org/ for sources
-	
+
 	Tested on Linux 686 2.4.0-test9, ALSA 0.5.8a and CS4610
 */
 
@@ -89,8 +89,8 @@
 #define JSIO_BXOE                               0x00000040
 #define JSIO_BYOE                               0x00000080
 
-/* 
-   The card initialization code is obfuscated; the module cs461x 
+/*
+   The card initialization code is obfuscated; the module cs461x
    need to be loaded after ALSA modules initialized and something
    played on the CS 4610 chip (see sources for details of CS4610
    initialization code from ALSA)
@@ -112,7 +112,7 @@
 #define BA1_DWORD_SIZE          (13 * 1024 + 512)
 #define BA1_MEMORY_COUNT        3
 
-/* 
+/*
    Only one CS461x card is still suppoted; the code requires
    redesign to avoid this limitatuion.
 */
@@ -163,7 +163,7 @@
 	if(port){
 	    gameport_unregister_port(port);
 	    kfree(port);
-	}    
+	}
 	if (ba0) iounmap(ba0);
 #ifdef CS461X_FULL_MAP
 	if (ba1.name.data0) iounmap(ba1.name.data0);
@@ -187,13 +187,13 @@
 static int cs461x_gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
 	unsigned js1, js2, jst;
-	
+
 	js1 = cs461x_peekBA0(BA0_JSC1);
 	js2 = cs461x_peekBA0(BA0_JSC2);
 	jst = cs461x_peekBA0(BA0_JSPT);
-	
-	*buttons = (~jst >> 4) & 0x0F; 
-	
+
+	*buttons = (~jst >> 4) & 0x0F;
+
 	axes[0] = ((js1 & JSC1_Y1V_MASK) >> JSC1_Y1V_SHIFT) & 0xFFFF;
 	axes[1] = ((js1 & JSC1_X1V_MASK) >> JSC1_X1V_SHIFT) & 0xFFFF;
 	axes[2] = ((js2 & JSC2_Y2V_MASK) >> JSC2_Y2V_SHIFT) & 0xFFFF;
@@ -228,7 +228,7 @@
 {
 	int rc;
 	struct gameport* port;
-	
+
 	rc = pci_enable_device(pdev);
 	if (rc) {
 		printk(KERN_ERR "cs461x: Cannot enable PCI gameport (bus %d, devfn %d) error=%d\n",
@@ -240,7 +240,7 @@
 #ifdef CS461X_FULL_MAP
 	ba1_addr = pci_resource_start(pdev, 1);
 #endif
-	if (ba0_addr == 0 || ba0_addr == ~0 
+	if (ba0_addr == 0 || ba0_addr == ~0
 #ifdef CS461X_FULL_MAP
             || ba1_addr == 0 || ba1_addr == ~0
 #endif
@@ -281,7 +281,7 @@
 	memset(port, 0, sizeof(struct gameport));
 
 	pci_set_drvdata(pdev, port);
-	
+
 	port->open = cs461x_gameport_open;
 	port->trigger = cs461x_gameport_trigger;
 	port->read = cs461x_gameport_read;
@@ -310,7 +310,7 @@
 {
 	cs461x_free(pdev);
 }
-	
+
 static struct pci_driver cs461x_pci_driver = {
         .name =         "CS461x Gameport",
         .id_table =     cs461x_pci_tbl,
diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/emu10k1-gp.c	2004-06-07 13:11:06 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
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
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -48,7 +48,7 @@
 	int size;
 	char phys[32];
 };
-	
+
 static struct pci_device_id emu_tbl[] = {
 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID }, /* SB Live gameport */
 	{ 0x1102, 0x7003, PCI_ANY_ID, PCI_ANY_ID }, /* Audigy gameport */
@@ -61,7 +61,7 @@
 {
 	int ioport, iolen;
 	struct emu *emu;
-        
+
 	if (pci_enable_device(pdev))
 		return -EBUSY;
 
diff -Nru a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/fm801-gp.c	2004-06-07 13:11:06 +02:00
@@ -111,7 +111,7 @@
 
 	pci_set_drvdata(pci, gp);
 
-	outb(0x60, gp->gameport.io + 0x0d); /* enable joystick 1 and 2 */ 
+	outb(0x60, gp->gameport.io + 0x0d); /* enable joystick 1 and 2 */
 
 	gameport_register_port(&gp->gameport);
 
diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/gameport.c	2004-06-07 13:11:06 +02:00
@@ -168,7 +168,7 @@
 		return -1;
 
 	gameport->dev = dev;
-	
+
 	return 0;
 }
 
diff -Nru a/drivers/input/gameport/lightning.c b/drivers/input/gameport/lightning.c
--- a/drivers/input/gameport/lightning.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/lightning.c	2004-06-07 13:11:06 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
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
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -106,7 +106,7 @@
 
 	result = 0;
 
-fail:	outb(L4_SELECT_ANALOG, L4_PORT);	
+fail:	outb(L4_SELECT_ANALOG, L4_PORT);
 	return result;
 }
 
@@ -126,7 +126,7 @@
 static int l4_getcal(int port, int *cal)
 {
 	int i, result = -1;
-	
+
 	outb(L4_SELECT_ANALOG, L4_PORT);
 	outb(L4_SELECT_DIGITAL + (port >> 2), L4_PORT);
 
@@ -208,7 +208,7 @@
 
 	return 0;
 }
-	
+
 static int __init l4_init(void)
 {
 	int cal[4] = {255,255,255,255};
@@ -266,7 +266,7 @@
 
 			if (rev > 0x28)		/* on 2.9+ the setcal command works correctly */
 				l4_setcal(l4->port, cal);
-			
+
 			gameport_register_port(gameport);
 		}
 
diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/ns558.c	2004-06-07 13:11:06 +02:00
@@ -12,18 +12,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
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
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -58,7 +58,7 @@
 	char phys[32];
 	char name[32];
 };
-	
+
 static LIST_HEAD(ns558_list);
 
 /*
@@ -115,7 +115,7 @@
 			i = 0;
 			goto out;
 		}
-/* 
+/*
  * And now find the number of mirrors of the port.
  */
 
@@ -291,7 +291,7 @@
 				release_region(port->gameport.io & ~(port->size - 1), port->size);
 				kfree(port);
 				break;
-		
+
 			default:
 				break;
 		}
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	2004-06-07 13:11:06 +02:00
+++ b/drivers/input/gameport/vortex.c	2004-06-07 13:11:06 +02:00
@@ -82,7 +82,7 @@
 		axes[i] = readw(vortex->io + VORTEX_AXD + i * sizeof(u32));
 		if (axes[i] == 0x1fff) axes[i] = -1;
 	}
-        
+
         return 0;
 }
 
@@ -121,7 +121,7 @@
 
 	vortex->gameport.driver = vortex;
 	vortex->gameport.fuzz = 64;
-	
+
 	vortex->gameport.read = vortex_read;
 	vortex->gameport.trigger = vortex_trigger;
 	vortex->gameport.cooked_read = vortex_cooked_read;
@@ -144,7 +144,7 @@
 	vortex->io = vortex->base + id->driver_data;
 
 	gameport_register_port(&vortex->gameport);
-	
+
 	printk(KERN_INFO "gameport at pci%s speed %d kHz\n",
 		pci_name(dev), vortex->gameport.speed);
 

