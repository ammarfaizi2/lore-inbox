Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUFGMSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUFGMSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbUFGMR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:17:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7809 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264432AbUFGL4e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:34 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <108660935415@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093542982@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 22/39] input: Trailing whitespace fixes in drivers/input/serio
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.2, 2004-05-10 01:23:48-05:00, dtor_core@ameritech.net
  Input: trailing whitespace fixes in drivers/input/serio


 98kbd-io.c |    4 ++--
 ct82c710.c |    8 ++++----
 gscps2.c   |   22 +++++++++++-----------
 i8042.c    |   26 +++++++++++++-------------
 parkbd.c   |   12 ++++++------
 q40kbd.c   |    2 +-
 rpckbd.c   |    2 +-
 7 files changed, 38 insertions(+), 38 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/98kbd-io.c b/drivers/input/serio/98kbd-io.c
--- a/drivers/input/serio/98kbd-io.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/98kbd-io.c	2004-06-07 13:11:51 +02:00
@@ -42,8 +42,8 @@
  * Register numbers.
  */
 
-#define KBD98_COMMAND_REG	0x43	
-#define KBD98_STATUS_REG	0x43	
+#define KBD98_COMMAND_REG	0x43
+#define KBD98_STATUS_REG	0x43
 #define KBD98_DATA_REG		0x41
 
 spinlock_t kbd98io_lock = SPIN_LOCK_UNLOCKED;
diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/ct82c710.c	2004-06-07 13:11:51 +02:00
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
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/gscps2.c	2004-06-07 13:11:51 +02:00
@@ -16,7 +16,7 @@
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
- * 
+ *
  * TODO:
  * - Dino testing (did HP ever shipped a machine on which this port
  *                 was usable/enabled ?)
@@ -44,7 +44,7 @@
 
 #define PFX "gscps2.c: "
 
-/* 
+/*
  * Driver constants
  */
 
@@ -222,7 +222,7 @@
 /**
  * gscps2_interrupt() - Interruption service routine
  *
- * This function reads received PS/2 bytes and processes them on 
+ * This function reads received PS/2 bytes and processes them on
  * all interfaces.
  * The problematic part here is, that the keyboard and mouse PS/2 port
  * share the same interrupt and it's not possible to send data if any
@@ -240,9 +240,9 @@
 	  unsigned long flags;
 	  spin_lock_irqsave(&ps2port->lock, flags);
 
-	  while ( (ps2port->buffer[ps2port->append].str = 
+	  while ( (ps2port->buffer[ps2port->append].str =
 		   gscps2_readb_status(ps2port->addr)) & GSC_STAT_RBNE ) {
-		ps2port->buffer[ps2port->append].data = 
+		ps2port->buffer[ps2port->append].data =
 				gscps2_readb_input(ps2port->addr);
 		ps2port->append = ((ps2port->append+1) & BUFFER_SIZE);
 	  }
@@ -349,7 +349,7 @@
 
 	if (!dev->irq)
 		return -ENODEV;
-	
+
 	/* Offset for DINO PS/2. Works with LASI even */
 	if (dev->id.sversion == 0x96)
 		hpa += GSC_DINO_OFFSET;
@@ -368,7 +368,7 @@
 	gscps2_reset(ps2port);
 	ps2port->id = readb(ps2port->addr+GSC_ID) & 0x0f;
 	snprintf(ps2port->name, sizeof(ps2port->name)-1, "%s %s",
-		gscps2_serio_port.name, 
+		gscps2_serio_port.name,
 		(ps2port->id == GSC_ID_KEYBOARD) ? "keyboard" : "mouse" );
 
 	memcpy(&ps2port->port, &gscps2_serio_port, sizeof(gscps2_serio_port));
@@ -401,9 +401,9 @@
 		ps2port->port.phys);
 
 	serio_register_port(&ps2port->port);
-	
+
 	return 0;
-	
+
 fail:
 	free_irq(dev->irq, ps2port);
 
@@ -430,7 +430,7 @@
 	list_del(&ps2port->node);
 	iounmap(ps2port->addr);
 #if 0
-	release_mem_region(dev->hpa, GSC_STATUS + 4); 
+	release_mem_region(dev->hpa, GSC_STATUS + 4);
 #endif
 	dev_set_drvdata(&dev->dev, NULL);
 	kfree(ps2port);
@@ -441,7 +441,7 @@
 static struct parisc_device_id gscps2_device_tbl[] = {
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00084 }, /* LASI PS/2 */
 #ifdef DINO_TESTED
-	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00096 }, /* DINO PS/2 */ 
+	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00096 }, /* DINO PS/2 */
 #endif
 	{ 0, }	/* 0 terminated list */
 };
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/i8042.c	2004-06-07 13:11:51 +02:00
@@ -150,7 +150,7 @@
  */
 
 static int i8042_command(unsigned char *param, int command)
-{ 
+{
 	unsigned long flags;
 	int retval = 0, i = 0;
 
@@ -161,7 +161,7 @@
 		dbg("%02x -> i8042 (command)", command & 0xff);
 		i8042_write_command(command & 0xff);
 	}
-	
+
 	if (!retval)
 		for (i = 0; i < ((command >> 12) & 0xf); i++) {
 			if ((retval = i8042_wait_write())) break;
@@ -172,7 +172,7 @@
 	if (!retval)
 		for (i = 0; i < ((command >> 8) & 0xf); i++) {
 			if ((retval = i8042_wait_read())) break;
-			if (i8042_read_status() & I8042_STR_AUXDATA) 
+			if (i8042_read_status() & I8042_STR_AUXDATA)
 				param[i] = ~i8042_read_data();
 			else
 				param[i] = i8042_read_data();
@@ -415,17 +415,17 @@
 		} else dfl = 0;
 
 		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
-			data, (str >> 6), irq, 
+			data, (str >> 6), irq,
 			dfl & SERIO_PARITY ? ", bad parity" : "",
 			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 		serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
-		
+
 		goto irq_ret;
 	}
 
 	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq, 
+		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
 		dfl & SERIO_PARITY ? ", bad parity" : "",
 		dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
@@ -539,7 +539,7 @@
 
 	if (i8042_enable_mux_mode(values, &mux_version))
 		return -1;
-	
+
 	/* Workaround for broken chips which seem to support MUX, but in reality don't. */
 	/* They all report version 10.12 */
 	if (mux_version == 0xAC)
@@ -607,7 +607,7 @@
 /*
  * Bit assignment test - filters out PS/2 i8042's in AT mode
  */
-	
+
 	if (i8042_command(&param, I8042_CMD_AUX_DISABLE))
 		return -1;
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS)) {
@@ -618,7 +618,7 @@
 	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (param & I8042_CTR_AUXDIS))
-		return -1;	
+		return -1;
 
 /*
  * Disable the interface.
@@ -648,7 +648,7 @@
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
 		printk(KERN_WARNING "i8042.c: Can't write CTR while registering.\n");
 		values->exists = 0;
-		return -1; 
+		return -1;
 	}
 
 	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
@@ -877,7 +877,7 @@
 static int i8042_notify_sys(struct notifier_block *this, unsigned long code,
         		    void *unused)
 {
-        if (code==SYS_DOWN || code==SYS_HALT) 
+        if (code == SYS_DOWN || code == SYS_HALT)
         	i8042_controller_cleanup();
         return NOTIFY_DONE;
 }
@@ -1009,13 +1009,13 @@
 	del_timer_sync(&i8042_timer);
 
 	i8042_controller_cleanup();
-	
+
 	if (i8042_kbd_values.exists)
 		serio_unregister_port(&i8042_kbd_port);
 
 	if (i8042_aux_values.exists)
 		serio_unregister_port(&i8042_aux_port);
-	
+
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists)
 			serio_unregister_port(i8042_mux_port + i);
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/parkbd.c	2004-06-07 13:11:51 +02:00
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
@@ -104,7 +104,7 @@
 			parkbd_writing = 0;
 			parkbd_writelines(3);
 			return;
-		}	
+		}
 
 		parkbd_writelines(((parkbd_buffer >> parkbd_counter++) & 1) | 2);
 
@@ -120,7 +120,7 @@
 		if ((parkbd_counter == parkbd_mode + 10) || time_after(jiffies, parkbd_last + HZ/100)) {
 			parkbd_counter = 0;
 			parkbd_buffer = 0;
-		}	
+		}
 
 		parkbd_buffer |= (parkbd_readlines() >> 1) << parkbd_counter++;
 
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/q40kbd.c	2004-06-07 13:11:51 +02:00
@@ -4,7 +4,7 @@
  *  Copyright (c) 2000-2001 Vojtech Pavlik
  *
  *  Based on the work of:
- *	Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>	
+ *	Richard Zidlicky <Richard.Zidlicky@stud.informatik.uni-erlangen.de>
  */
 
 /*
diff -Nru a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	2004-06-07 13:11:51 +02:00
+++ b/drivers/input/serio/rpckbd.c	2004-06-07 13:11:51 +02:00
@@ -98,7 +98,7 @@
 static void rpckbd_close(struct serio *port)
 {
 	free_irq(IRQ_KEYBOARDRX, port);
-	free_irq(IRQ_KEYBOARDTX, port);	
+	free_irq(IRQ_KEYBOARDTX, port);
 }
 
 static struct serio rpckbd_port =

