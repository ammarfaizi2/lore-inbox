Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264662AbUFGMSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbUFGMSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUFGMQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:16:26 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14721 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264609AbUFGL4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:32 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093542892@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609354985@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 31/39] input: Trailing whitespace fixes in drivers/input
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.11, 2004-05-10 01:36:08-05:00, dtor_core@ameritech.net
  Input: trailing whitespace fixes in drivers/input


 evbug.c    |   14 +++++++-------
 evdev.c    |    4 ++--
 joydev.c   |   16 ++++++++--------
 mousedev.c |   20 ++++++++++----------
 power.c    |   26 +++++++++++++-------------
 5 files changed, 40 insertions(+), 40 deletions(-)

===================================================================

diff -Nru a/drivers/input/evbug.c b/drivers/input/evbug.c
--- a/drivers/input/evbug.c	2004-06-07 13:11:00 +02:00
+++ b/drivers/input/evbug.c	2004-06-07 13:11:00 +02:00
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
@@ -35,7 +35,7 @@
 #include <linux/device.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION("Input driver event debug module"); 
+MODULE_DESCRIPTION("Input driver event debug module");
 MODULE_LICENSE("GPL");
 
 static char evbug_name[] = "evbug";
@@ -67,7 +67,7 @@
 static void evbug_disconnect(struct input_handle *handle)
 {
 	printk(KERN_DEBUG "evbug.c: Disconnected device: %s\n", handle->dev->phys);
-	
+
 	input_close_device(handle);
 
 	kfree(handle);
@@ -79,7 +79,7 @@
 };
 
 MODULE_DEVICE_TABLE(input, evbug_ids);
-	
+
 static struct input_handler evbug_handler = {
 	.event =	evbug_event,
 	.connect =	evbug_connect,
diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	2004-06-07 13:11:00 +02:00
+++ b/drivers/input/evdev.c	2004-06-07 13:11:00 +02:00
@@ -220,7 +220,7 @@
 
 		case EVIOCGID:
 			return copy_to_user((void *) arg, &dev->id, sizeof(struct input_id)) ? -EFAULT : 0;
-		
+
 		case EVIOCGKEYCODE:
 			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
 			if (t < 0 || t > dev->keycodemax || !dev->keycodesize) return -EINVAL;
@@ -428,7 +428,7 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
-	class_simple_device_add(input_class, 
+	class_simple_device_add(input_class,
 				MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 				dev->dev, "event%d", minor);
 
diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2004-06-07 13:11:00 +02:00
+++ b/drivers/input/joydev.c	2004-06-07 13:11:00 +02:00
@@ -1,12 +1,12 @@
 /*
  * Joystick device driver for the input driver suite.
  *
- * Copyright (c) 1999-2002 Vojtech Pavlik 
- * Copyright (c) 1999 Colin Van Dyke 
+ * Copyright (c) 1999-2002 Vojtech Pavlik
+ * Copyright (c) 1999 Colin Van Dyke
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
 
@@ -34,7 +34,7 @@
 MODULE_LICENSE("GPL");
 
 #define JOYDEV_MINOR_BASE	0
-#define JOYDEV_MINORS		16	
+#define JOYDEV_MINORS		16
 #define JOYDEV_BUFFER_SIZE	64
 
 #define MSECS(t)	(1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
@@ -115,7 +115,7 @@
 
 		default:
 			return;
-	}  
+	}
 
 	event.time = MSECS(jiffies);
 
@@ -449,10 +449,10 @@
 	}
 
 	joydev_table[minor] = joydev;
-	
+
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
-	class_simple_device_add(input_class, 
+	class_simple_device_add(input_class,
 				MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 				dev->dev, "js%d", minor);
 
@@ -466,7 +466,7 @@
 	joydev->exist = 0;
 
 	if (joydev->open)
-		input_close_device(handle);	
+		input_close_device(handle);
 	else
 		joydev_free(joydev);
 }
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-06-07 13:11:00 +02:00
+++ b/drivers/input/mousedev.c	2004-06-07 13:11:00 +02:00
@@ -177,7 +177,7 @@
 						case BTN_SIDE:   if (list->mode == 2) { index = 3; break; }
 						case BTN_2:
 						case BTN_STYLUS2:
-						case BTN_MIDDLE: index = 2; break;	
+						case BTN_MIDDLE: index = 2; break;
 						default: return;
 					}
 					switch (value) {
@@ -267,7 +267,7 @@
 				mousedev_free(list->mousedev);
 		}
 	}
-	
+
 	kfree(list);
 	return 0;
 }
@@ -301,11 +301,11 @@
 		if (list->mousedev->minor == MOUSEDEV_MIX) {
 			list_for_each_entry(handle, &mousedev_handler.h_list, h_node) {
 				mousedev = handle->private;
-				if (!mousedev->open && mousedev->exist)	
+				if (!mousedev->open && mousedev->exist)
 					input_open_device(handle);
 			}
-		} else 
-			if (!mousedev_mix.open && list->mousedev->exist)	
+		} else
+			if (!mousedev_mix.open && list->mousedev->exist)
 				input_open_device(&list->mousedev->handle);
 	}
 
@@ -327,7 +327,7 @@
 		list->ps2[off + 3] = (list->ps2[off + 3] & 0x0f) | ((list->buttons & 0x18) << 1);
 		list->bufsiz++;
 	}
-	
+
 	if (list->mode == 1) {
 		list->ps2[off + 3] = (list->dz > 127 ? 127 : (list->dz < -127 ? -127 : list->dz));
 		list->dz -= list->ps2[off + 3];
@@ -403,7 +403,7 @@
 	kill_fasync(&list->fasync, SIGIO, POLL_IN);
 
 	wake_up_interruptible(&list->mousedev->wait);
-		
+
 	return count;
 }
 
@@ -431,7 +431,7 @@
 	if (copy_to_user(buffer, list->ps2 + list->bufsiz - list->buffer - count, count))
 		return -EFAULT;
 
-	return count;	
+	return count;
 }
 
 /* No kernel lock - fine */
@@ -487,7 +487,7 @@
 
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
-	class_simple_device_add(input_class, 
+	class_simple_device_add(input_class,
 				MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 				dev->dev, "mouse%d", minor);
 
@@ -538,7 +538,7 @@
 };
 
 MODULE_DEVICE_TABLE(input, mousedev_ids);
-	
+
 static struct input_handler mousedev_handler = {
 	.event =	mousedev_event,
 	.connect =	mousedev_connect,
diff -Nru a/drivers/input/power.c b/drivers/input/power.c
--- a/drivers/input/power.c	2004-06-07 13:11:00 +02:00
+++ b/drivers/input/power.c	2004-06-07 13:11:00 +02:00
@@ -1,7 +1,7 @@
 /*
  * $Id: power.c,v 1.10 2001/09/25 09:17:15 vojtech Exp $
  *
- *  Copyright (c) 2001 "Crazy" James Simmons  
+ *  Copyright (c) 2001 "Crazy" James Simmons
  *
  *  Input driver Power Management.
  *
@@ -51,7 +51,7 @@
 
 static DECLARE_WORK(suspend_button_task, suspend_button_task_handler, NULL);
 
-static void power_event(struct input_handle *handle, unsigned int type, 
+static void power_event(struct input_handle *handle, unsigned int type,
 		        unsigned int code, int down)
 {
 	struct input_dev *dev = handle->dev;
@@ -73,7 +73,7 @@
 			case KEY_POWER:
 				/* Hum power down the machine. */
 				break;
-			default:	
+			default:
 				return;
 		}
 	} else {
@@ -83,9 +83,9 @@
 				/* This is risky. See pm.h for details. */
 				if (dev->state != PM_RESUME)
 					dev->state = PM_RESUME;
-				else 
-					dev->state = PM_SUSPEND;	
-				pm_send(dev->pm_dev, dev->state, dev); 	
+				else
+					dev->state = PM_SUSPEND;
+				pm_send(dev->pm_dev, dev->state, dev);
 				break;
 			case KEY_POWER:
 				/* Turn the input device off completely ? */
@@ -97,14 +97,14 @@
 	return;
 }
 
-static struct input_handle *power_connect(struct input_handler *handler, 
-					  struct input_dev *dev, 
+static struct input_handle *power_connect(struct input_handler *handler,
+					  struct input_dev *dev,
 					  struct input_device_id *id)
 {
 	struct input_handle *handle;
 
 	if (!test_bit(EV_KEY, dev->evbit) || !test_bit(EV_PWR, dev->evbit))
-		return NULL;	
+		return NULL;
 
 	if (!test_bit(KEY_SUSPEND, dev->keybit) || (!test_bit(KEY_POWER, dev->keybit)))
 		return NULL;
@@ -133,21 +133,21 @@
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
 		.evbit = { BIT(EV_KEY) },
 		.keybit = { [LONG(KEY_SUSPEND)] = BIT(KEY_SUSPEND) }
-	},	
+	},
 	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT,
 		.evbit = { BIT(EV_KEY) },
 		.keybit = { [LONG(KEY_POWER)] = BIT(KEY_POWER) }
-	},	
+	},
 	{
 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
 		.evbit = { BIT(EV_PWR) },
-	},	
+	},
 	{ }, 	/* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE(input, power_ids);
-	
+
 static struct input_handler power_handler = {
 	.event =	power_event,
 	.connect =	power_connect,

