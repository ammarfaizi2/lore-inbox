Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbUBTW35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUBTW34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:29:56 -0500
Received: from wacom-nt2.wacom.com ([204.119.25.126]:9229 "EHLO
	wacom_nt2.WACOM.COM") by vger.kernel.org with ESMTP id S261319AbUBTW3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:29:30 -0500
Message-ID: <28E6D16EC4CCD71196610060CF213AEB065BDB@wacom-nt2.wacom.com>
From: Ping Cheng <pingc@wacom.com>
To: "'Vojtech Pavlik '" <vojtech@suse.cz>,
       "'Pete Zaitcev '" <zaitcev@redhat.com>
Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: Wacom USB driver patch
Date: Fri, 20 Feb 2004 14:29:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3F800.A3C7B5EE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3F800.A3C7B5EE
Content-Type: text/plain

 <<wacom_2.4.patch>> 
The attached patch is against the latest versions of wacom.c and hid-core.c
at  http://linux.bkbits.net:8080/linux-2.4.

Ping

-----Original Message-----
From: Vojtech Pavlik
To: Pete Zaitcev
Cc: Ping Cheng; linux-kernel@vger.kernel.org
Sent: 2/13/04 12:13 AM
Subject: Re: Wacom USB driver patch

On Thu, Feb 12, 2004 at 07:28:09PM -0800, Pete Zaitcev wrote:
> On Thu, 12 Feb 2004 16:55:47 -0800
> Ping Cheng <pingc@wacom.com> wrote:
> 
> > The wacom.c at http://linux.bkbits.net:8080/linux-2.4 is way out of
date and
> > people are still working on/using 2.4 releases. Should I make a
patch for
> > 2.4?
> 
> We plan to support 2.4 based releases for several years yet. If
Vojtech
> approves what you did for 2.6, I am all for a backport to Marcelo
tree.
> Marcelo is not very forthcoming with approvals these days, but perhaps
> it may be folded into some update. But as usual I would like to avoid
> carrying a patch in Red Hat tree, if at all possible.

Agreed. Same for us at SUSE.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

------_=_NextPart_000_01C3F800.A3C7B5EE
Content-Type: application/octet-stream;
	name="wacom_2.4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="wacom_2.4.patch"

--- linux-2.4/drivers/usb/hid-core.c@1.27	2004-02-18 16:30:18.000000000 =
-0800=0A=
+++ linux-2.4/drivers/usb/hid-core.c	2004-02-18 16:47:49.000000000 =
-0800=0A=
@@ -1135,7 +1135,9 @@ void hid_init_reports(struct hid_device =0A=
 #define USB_DEVICE_ID_WACOM_GRAPHIRE	0x0010=0A=
 #define USB_DEVICE_ID_WACOM_INTUOS	0x0020=0A=
 #define USB_DEVICE_ID_WACOM_PL		0x0030=0A=
-#define USB_DEVICE_ID_WACOM_INTUOS2	0x0041=0A=
+#define USB_DEVICE_ID_WACOM_INTUOS2	0x0040=0A=
+#define USB_DEVICE_ID_WACOM_VOLITO	0x0060=0A=
+#define USB_DEVICE_ID_WACOM_PTU		0x0003=0A=
 =0A=
 #define USB_VENDOR_ID_KBGEAR		0x084e=0A=
 #define USB_DEVICE_ID_KBGEAR_JAMSTUDIO	0x1001=0A=
@@ -1203,11 +1205,16 @@ struct hid_blacklist {=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 3, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 4, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 5, HID_QUIRK_IGNORE =
},=0A=
-	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 1, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 4, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 5, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 7, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE =
},=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 3, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 4, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET =
},=0A=
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET =
},=0A=
--- linux-2.4/drivers/usb/wacom.c@1.9	2004-02-17 15:46:42.000000000 =
-0800=0A=
+++ linux-2.4/drivers/usb/wacom.c	2004-02-18 15:07:30.000000000 =
-0800=0A=
@@ -1,13 +1,15 @@=0A=
 /*=0A=
  * $Id: wacom.c,v 1.23 2001/05/29 12:57:18 vojtech Exp $=0A=
  *=0A=
- *  Copyright (c) 2000-2001 Vojtech Pavlik	<vojtech@suse.cz>=0A=
+ *  Copyright (c) 2000-2004 Vojtech Pavlik	<vojtech@suse.cz>=0A=
  *  Copyright (c) 2000 Andreas Bach Aaen	<abach@stofanet.dk>=0A=
  *  Copyright (c) 2000 Clifford Wolf		<clifford@clifford.at>=0A=
  *  Copyright (c) 2000 Sam Mosel		<sam.mosel@computer.org>=0A=
  *  Copyright (c) 2000 James E. Blair		<corvus@gnu.org>=0A=
  *  Copyright (c) 2000 Daniel Egger		<egger@suse.de>=0A=
  *  Copyright (c) 2001 Frederic Lepied		<flepied@mandrakesoft.com>=0A=
+ *  Copyright (c) 2002-2004 Ping Cheng		<pingc@wacom.com>=0A=
+ *  Copyright (c) 2002-2003 John Joganic	<john@joganic.com>=0A=
  *=0A=
  *  USB Wacom Graphire and Wacom Intuos tablet support=0A=
  *=0A=
@@ -74,6 +76,8 @@=0A=
 #include <linux/module.h>=0A=
 #include <linux/init.h>=0A=
 #include <linux/usb.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/list.h>=0A=
 =0A=
 /*=0A=
  * Version Information=0A=
@@ -88,6 +92,12 @@ MODULE_LICENSE("GPL");=0A=
 =0A=
 #define USB_VENDOR_ID_WACOM	0x056a=0A=
 =0A=
+static int kwacomd_pid =3D 0;			/* PID of kwacomd */=0A=
+static DECLARE_COMPLETION(kwacomd_exited);=0A=
+static DECLARE_WAIT_QUEUE_HEAD(kwacomd_wait);=0A=
+static LIST_HEAD(wacom_event_list);   /* List of tablets needing =
servicing */=0A=
+static spinlock_t wacom_event_lock =3D SPIN_LOCK_UNLOCKED;=0A=
+=0A=
 struct wacom_features {=0A=
 	char *name;=0A=
 	int pktlen;=0A=
@@ -112,36 +122,124 @@ struct wacom {=0A=
 	int tool[2];=0A=
 	int open;=0A=
 	__u32 serial[2];=0A=
+	struct list_head event_list;=0A=
+	struct semaphore kwacomd_sem;=0A=
+	unsigned int ifnum;=0A=
 };=0A=
 =0A=
+static void wacom_request_reset(struct wacom* wacom)=0A=
+{=0A=
+	unsigned long flags;=0A=
+	spin_lock_irqsave(&wacom_event_lock, flags);=0A=
+	if (list_empty(&wacom->event_list))=0A=
+	{=0A=
+		list_add(&wacom->event_list, &wacom_event_list);=0A=
+		wake_up(&kwacomd_wait);=0A=
+	}=0A=
+	spin_unlock_irqrestore(&wacom_event_lock, flags);=0A=
+}=0A=
+=0A=
 static void wacom_pl_irq(struct urb *urb)=0A=
 {=0A=
 	struct wacom *wacom =3D urb->context;=0A=
 	unsigned char *data =3D wacom->data;=0A=
 	struct input_dev *dev =3D &wacom->dev;=0A=
-	int prox;=0A=
+	int prox, pressure;=0A=
 =0A=
 	if (urb->status) return;=0A=
 =0A=
 	if (data[0] !=3D 2) {=0A=
-		printk(KERN_ERR "wacom_pl_irq: received unknown report #%d\n", =
data[0]);=0A=
+		printk(KERN_INFO "wacom_pl_irq: received unknown report #%d\n", =
data[0]);=0A=
+		wacom_request_reset(wacom);=0A=
 		return;=0A=
 	}=0A=
 	=0A=
-	prox =3D data[1] & 0x20;=0A=
-	=0A=
-	input_report_key(dev, BTN_TOOL_PEN, prox);=0A=
-	=0A=
+	prox =3D data[1] & 0x40;=0A=
+=0A=
 	if (prox) {=0A=
-		int pressure =3D (data[4] & 0x04) >> 2 | ((__u32)(data[7] & 0x7f) << =
1);=0A=
+		pressure =3D (signed char) ((data[7] <<1 ) | ((data[4] >> 2) & =
1));=0A=
+		if ( wacom->features->pressure_max > 350 ) {=0A=
+			pressure =3D (pressure << 1) | ((data[4] >> 6) & 1);=0A=
+                } =0A=
+		pressure +=3D (( wacom->features->pressure_max + 1 )/ 2);=0A=
+=0A=
+		/*=0A=
+		 * if going from out of proximity into proximity select between the =
eraser=0A=
+		 * and the pen based on the state of the stylus2 button, choose =
eraser if=0A=
+		 * pressed else choose pen. if not a proximity change from out to =
in, send=0A=
+		 * an out of proximity for previous tool then a in for new tool.=0A=
+		 */=0A=
+		if (!wacom->tool[0]) {=0A=
+			/* Going into proximity select tool */=0A=
+			wacom->tool[1] =3D (data[4] & 0x20)? BTN_TOOL_RUBBER : =
BTN_TOOL_PEN;=0A=
+		}=0A=
+		else {=0A=
+			/* was entered with stylus2 pressed */=0A=
+			if (wacom->tool[1] =3D=3D BTN_TOOL_RUBBER && !(data[4] & 0x20) ) =
{=0A=
+				/* report out proximity for previous tool */=0A=
+				input_report_key(dev, wacom->tool[1], 0);=0A=
+				input_event(dev, EV_MSC, MSC_SERIAL, 0);=0A=
+				wacom->tool[1] =3D BTN_TOOL_PEN;=0A=
+				return;=0A=
+			}=0A=
+		}=0A=
+		if (wacom->tool[1] !=3D BTN_TOOL_RUBBER) {=0A=
+			/* Unknown tool selected default to pen tool */=0A=
+			wacom->tool[1] =3D BTN_TOOL_PEN;=0A=
+		}=0A=
+		input_report_key(dev, wacom->tool[1], prox); /* report in proximity =
for tool */=0A=
 =0A=
-		input_report_abs(dev, ABS_X, data[3] | ((__u32)data[2] << 8) | =
((__u32)(data[1] & 0x03) << 16));=0A=
-		input_report_abs(dev, ABS_Y, data[6] | ((__u32)data[5] << 8) | =
((__u32)(data[4] & 0x03) << 8));=0A=
-		input_report_abs(dev, ABS_PRESSURE, (data[7] & 0x80) ? (255 - =
pressure) : (pressure + 255));=0A=
+		input_report_abs(dev, ABS_X, data[3] | ((__u32)data[2] << 7) | =
((__u32)(data[1] & 0x03) << 14));=0A=
+		input_report_abs(dev, ABS_Y, data[6] | ((__u32)data[5] << 7) | =
((__u32)(data[4] & 0x03) << 14));=0A=
+		input_report_abs(dev, ABS_PRESSURE, pressure);=0A=
 		input_report_key(dev, BTN_TOUCH, data[4] & 0x08);=0A=
 		input_report_key(dev, BTN_STYLUS, data[4] & 0x10);=0A=
-		input_report_key(dev, BTN_STYLUS2, data[4] & 0x20);=0A=
+		/* Only allow the stylus2 button to be reported for the pen tool. =
*/=0A=
+		input_report_key(dev, BTN_STYLUS2, (wacom->tool[1] =3D=3D =
BTN_TOOL_PEN) && (data[4] & 0x20));=0A=
 	}=0A=
+	else {=0A=
+		/* report proximity-out of a (valid) tool */=0A=
+		if (wacom->tool[1] !=3D BTN_TOOL_RUBBER) {=0A=
+			/* Unknown tool selected default to pen tool */=0A=
+			wacom->tool[1] =3D BTN_TOOL_PEN;=0A=
+		}=0A=
+		input_report_key(dev, wacom->tool[1], prox);=0A=
+	}=0A=
+	wacom->tool[0] =3D prox; /* Save proximity state */=0A=
+	=0A=
+	input_event(dev, EV_MSC, MSC_SERIAL, 0);=0A=
+}=0A=
+=0A=
+static void wacom_ptu_irq(struct urb *urb)=0A=
+{=0A=
+	struct wacom *wacom =3D urb->context;=0A=
+	unsigned char *data =3D wacom->data;=0A=
+	struct input_dev *dev =3D &wacom->dev;=0A=
+=0A=
+	if (urb->status) return;=0A=
+=0A=
+	if (data[0] !=3D 2)=0A=
+	{=0A=
+		printk(KERN_INFO "wacom_ptu_irq: received unknown report #%d\n", =
data[0]);=0A=
+		wacom_request_reset(wacom);=0A=
+		return;=0A=
+	}=0A=
+	=0A=
+	if (data[1] & 0x04) =0A=
+	{=0A=
+		input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x20);=0A=
+		input_report_key(dev, BTN_TOUCH, data[1] & 0x08);=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		input_report_key(dev, BTN_TOOL_PEN, data[1] & 0x20);=0A=
+		input_report_key(dev, BTN_TOUCH, data[1] & 0x01);=0A=
+	}=0A=
+	input_report_abs(dev, ABS_X, data[3] << 8 | data[2]);=0A=
+	input_report_abs(dev, ABS_Y, data[5] << 8 | data[4]);=0A=
+	input_report_abs(dev, ABS_PRESSURE, (data[6]|data[7] << 8));=0A=
+	input_report_key(dev, BTN_STYLUS, data[1] & 0x02);=0A=
+	input_report_key(dev, BTN_STYLUS2, data[1] & 0x10);=0A=
 	=0A=
 	input_event(dev, EV_MSC, MSC_SERIAL, 0);=0A=
 }=0A=
@@ -152,7 +250,7 @@ static void wacom_penpartner_irq(struct =0A=
 	unsigned char *data =3D wacom->data;=0A=
 	struct input_dev *dev =3D &wacom->dev;=0A=
 	int x, y; =0A=
-	char pressure; =0A=
+	signed char pressure; =0A=
 	int leftmb;=0A=
 =0A=
 	if (urb->status) return;=0A=
@@ -160,15 +258,15 @@ static void wacom_penpartner_irq(struct =0A=
 	x =3D data[2] << 8 | data[1];=0A=
 	y =3D data[4] << 8 | data[3];=0A=
 	pressure =3D data[6];=0A=
-	leftmb =3D ((pressure > -80) && !(data[5] &20));=0A=
+	leftmb =3D ((pressure > -80) && !(data[5] & 0x20));=0A=
 =0A=
 	input_report_key(dev, BTN_TOOL_PEN, 1);=0A=
 =0A=
 	input_report_abs(dev, ABS_X, x);=0A=
 	input_report_abs(dev, ABS_Y, y);=0A=
 	input_report_abs(dev, ABS_PRESSURE, pressure+127);=0A=
-	input_report_key(dev, BTN_LEFT, leftmb);=0A=
-	input_report_key(dev, BTN_RIGHT, (data[5] & 0x40));=0A=
+	input_report_key(dev, BTN_TOUCH, leftmb);=0A=
+	input_report_key(dev, BTN_STYLUS, (data[5] & 0x40));=0A=
 	=0A=
 	input_event(dev, EV_MSC, MSC_SERIAL, leftmb);=0A=
 }=0A=
@@ -182,8 +280,13 @@ static void wacom_graphire_irq(struct ur=0A=
 =0A=
 	if (urb->status) return;=0A=
 =0A=
+	/* check if we can handle the data */=0A=
+	if (data[0] =3D=3D 99) /* for Volito */=0A=
+		return;=0A=
+=0A=
 	if (data[0] !=3D 2) {=0A=
-		printk(KERN_ERR "wacom_graphire_irq: received unknown report #%d\n", =
data[0]);=0A=
+		printk(KERN_INFO "wacom_graphire_irq: received unknown report =
#%d\n", data[0]);=0A=
+		wacom_request_reset(wacom);=0A=
 		return;=0A=
 	}=0A=
 	=0A=
@@ -200,14 +303,15 @@ static void wacom_graphire_irq(struct ur=0A=
 			input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x80);=0A=
 			break;=0A=
 =0A=
-		case 2: /* Mouse */=0A=
+		case 2: /* Mouse with wheel */=0A=
+			input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);=0A=
+			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);=0A=
+=0A=
+		case 3: /* Mouse without wheel */=0A=
 			input_report_key(dev, BTN_TOOL_MOUSE, data[7] > 24);=0A=
 			input_report_key(dev, BTN_LEFT, data[1] & 0x01);=0A=
 			input_report_key(dev, BTN_RIGHT, data[1] & 0x02);=0A=
-			input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);=0A=
 			input_report_abs(dev, ABS_DISTANCE, data[7]);=0A=
-			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);=0A=
-=0A=
 			input_report_abs(dev, ABS_X, x);=0A=
 			input_report_abs(dev, ABS_Y, y);=0A=
 =0A=
@@ -238,8 +342,10 @@ static void wacom_intuos_irq(struct urb =0A=
 =0A=
 	if (urb->status) return;=0A=
 =0A=
+	/* check for valid report */=0A=
 	if (data[0] !=3D 2) {=0A=
-		printk(KERN_ERR "wacom_intuos_irq: received unknown report #%d\n", =
data[0]);=0A=
+		printk(KERN_INFO "wacom_intuos_irq: received unknown report #%d\n", =
data[0]);=0A=
+		wacom_request_reset(wacom);=0A=
 		return;=0A=
 	}=0A=
 	=0A=
@@ -248,17 +354,18 @@ static void wacom_intuos_irq(struct urb =0A=
 =0A=
 	if ((data[1] & 0xfc) =3D=3D 0xc0) {						/* Enter report */=0A=
 =0A=
-		wacom->serial[idx] =3D ((__u32)(data[3] & 0x0f) << 4) +		/* serial =
number of the tool */=0A=
-			((__u32)data[4] << 16) + ((__u32)data[5] << 12) +=0A=
-			((__u32)data[6] << 4) + (data[7] >> 4);=0A=
+		wacom->serial[idx] =3D ((__u32)(data[3] & 0x0f) << 28) +		/* serial =
number of the tool */=0A=
+			((__u32)data[4] << 20) + ((__u32)data[5] << 12) +=0A=
+			((__u32)data[6] << 4) + ((__u32)data[7] >> 4);=0A=
 =0A=
 		switch (((__u32)data[2] << 4) | (data[3] >> 4)) {=0A=
-			case 0x832:=0A=
+			case 0x812:=0A=
 			case 0x012: wacom->tool[idx] =3D BTN_TOOL_PENCIL;		break;	/* Inking =
pen */=0A=
 			case 0x822:=0A=
 		        case 0x852:=0A=
+			case 0x842:=0A=
 			case 0x022: wacom->tool[idx] =3D BTN_TOOL_PEN;		break;	/* Pen */=0A=
-			case 0x812:=0A=
+			case 0x832:=0A=
 			case 0x032: wacom->tool[idx] =3D BTN_TOOL_BRUSH;		break;	/* Stroke =
pen */=0A=
 		        case 0x09c:=0A=
 		        case 0x007:=0A=
@@ -267,12 +374,14 @@ static void wacom_intuos_irq(struct urb =0A=
 			case 0x82a:=0A=
 		        case 0x85a:=0A=
 		        case 0x91a:=0A=
+			case 0xd1a:=0A=
 			case 0x0fa: wacom->tool[idx] =3D BTN_TOOL_RUBBER;		break;	/* Eraser =
*/=0A=
+			case 0x912:=0A=
+			case 0xd12:=0A=
 			case 0x112: wacom->tool[idx] =3D BTN_TOOL_AIRBRUSH;	break;	/* =
Airbrush */=0A=
 			default:    wacom->tool[idx] =3D BTN_TOOL_PEN;		break;	/* Unknown =
tool */=0A=
 		}=0A=
 =0A=
-		input_report_key(dev, wacom->tool[idx], 1);=0A=
 		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);=0A=
 		return;=0A=
 	}=0A=
@@ -285,7 +394,7 @@ static void wacom_intuos_irq(struct urb =0A=
 =0A=
 	input_report_abs(dev, ABS_X, ((__u32)data[2] << 8) | data[3]);=0A=
 	input_report_abs(dev, ABS_Y, ((__u32)data[4] << 8) | data[5]);=0A=
-	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);=0A=
+	input_report_abs(dev, ABS_DISTANCE, data[9]);=0A=
 	=0A=
 	if ((data[1] & 0xb8) =3D=3D 0xa0) {						/* general pen packet */=0A=
 		input_report_abs(dev, ABS_PRESSURE, t =3D ((__u32)data[6] << 2) | =
((data[7] >> 6) & 3));=0A=
@@ -307,31 +416,37 @@ static void wacom_intuos_irq(struct urb =0A=
 		if (data[1] & 0x02) {						/* Rotation packet */=0A=
 =0A=
 			input_report_abs(dev, ABS_RZ, (data[7] & 0x20) ?=0A=
-					 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3):=0A=
-					 (-(((__u32)data[6] << 2) | ((data[7] >> 6) & 3))) - 1);=0A=
+					 ((__u32)data[6] << 3) | ((data[7] >> 5) & 7):=0A=
+					 (-(((__u32)data[6] << 3) | ((data[7] >> 5) & 7))) - 1);=0A=
 =0A=
-		} else {=0A=
+		} else if ((data[1] & 0x10) =3D=3D 0) {				/* 4D mouse packets */=0A=
 =0A=
 			input_report_key(dev, BTN_LEFT,   data[8] & 0x01);=0A=
 			input_report_key(dev, BTN_MIDDLE, data[8] & 0x02);=0A=
 			input_report_key(dev, BTN_RIGHT,  data[8] & 0x04);=0A=
+			input_report_key(dev, BTN_SIDE,   data[8] & 0x20);=0A=
+			input_report_key(dev, BTN_EXTRA,  data[8] & 0x10);=0A=
+			input_report_abs(dev, ABS_THROTTLE,  (data[8] & 0x08) ?=0A=
+					 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3) :=0A=
+					 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3));=0A=
+=0A=
+		} else if (wacom->tool[idx] =3D=3D BTN_TOOL_MOUSE) {		/* 2D mouse =
packets */=0A=
+			input_report_key(dev, BTN_LEFT,   data[8] & 0x04);=0A=
+			input_report_key(dev, BTN_MIDDLE, data[8] & 0x08);=0A=
+			input_report_key(dev, BTN_RIGHT,  data[8] & 0x10);=0A=
+			input_report_rel(dev, REL_WHEEL, - (((__u32)(data[8] & 0x01)) -=0A=
+					((__u32)((data[8] & 0x02) >> 1))));=0A=
+		} else {							/* Lens cursor packets */=0A=
 =0A=
-	 		if ((data[1] & 0x10) =3D=3D 0) {				/* 4D mouse packets */=0A=
-=0A=
-				input_report_key(dev, BTN_SIDE,   data[8] & 0x20);=0A=
-				input_report_key(dev, BTN_EXTRA,  data[8] & 0x10);=0A=
-				input_report_abs(dev, ABS_THROTTLE,  (data[8] & 0x08) ?=0A=
-						 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3) :=0A=
-						 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3));=0A=
-=0A=
-			} else {						/* Lens cursor packets */=0A=
-=0A=
-				input_report_key(dev, BTN_SIDE,   data[8] & 0x10);=0A=
-				input_report_key(dev, BTN_EXTRA,  data[8] & 0x08);=0A=
-			}=0A=
+			input_report_key(dev, BTN_LEFT,   data[8] & 0x01);=0A=
+			input_report_key(dev, BTN_MIDDLE, data[8] & 0x02);=0A=
+			input_report_key(dev, BTN_RIGHT,  data[8] & 0x04);=0A=
+			input_report_key(dev, BTN_SIDE,   data[8] & 0x10);=0A=
+			input_report_key(dev, BTN_EXTRA,  data[8] & 0x08);=0A=
 		}=0A=
 	}=0A=
 	=0A=
+	input_report_key(dev, wacom->tool[idx], 1);=0A=
 	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);=0A=
 }=0A=
 =0A=
@@ -344,42 +459,43 @@ struct wacom_features wacom_features[] =3D=0A=
 		0, 0, 0, 0 },=0A=
 	{ "Wacom Graphire",      8, 10206,  7422,  511, 32, =
wacom_graphire_irq,=0A=
 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },=0A=
-	{ "Wacom Graphire2 4x5",     8, 10206,  7422,  511, 32, =
wacom_graphire_irq,=0A=
+	{ "Wacom Graphire2 4x5", 8, 10206,  7422,  511, 32, =
wacom_graphire_irq,=0A=
+		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },=0A=
+	{ "Wacom Graphire2 5x7", 8, 13918,  10206,  511, 32, =
wacom_graphire_irq,=0A=
+		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },=0A=
+	{ "Wacom Intuos 4x5",   10, 12700, 10600, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos 6x8",   10, 20320, 16240, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos 9x12",  10, 30480, 24060, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos 12x12", 10, 30480, 31680, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos 12x18", 10, 45720, 31680, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom PL400",         8,  5408,  4056,  255, 32, wacom_pl_irq, 0,  =
0, 0, 0 },=0A=
+	{ "Wacom PL500",         8,  6144,  4608,  255, 32, wacom_pl_irq, 0,  =
0, 0, 0 },=0A=
+	{ "Wacom PL600",         8,  6126,  4604,  255, 32, wacom_pl_irq, 0,  =
0, 0, 0 },=0A=
+	{ "Wacom PL600SX",       8,  6260,  5016,  255, 32, wacom_pl_irq, 0,  =
0, 0, 0 },=0A=
+	{ "Wacom PL550",         8,  6144,  4608,  511, 32, wacom_pl_irq, 0,  =
0, 0, 0 },=0A=
+	{ "Wacom PL800",         8,  7220,  5780,  511, 32, wacom_pl_irq, 0,  =
0, 0, 0 },=0A=
+	{ "Wacom Intuos2 4x5",  10, 12700, 10600, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos2 6x8",  10, 20320, 16240, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos2 9x12", 10, 30480, 24060, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos2 12x12",10, 30480, 31680, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Intuos2 12x18",10, 45720, 31680, 1023, 15, wacom_intuos_irq, =
BIT(EV_REL), =0A=
+		WACOM_INTUOS_ABS, BIT(REL_WHEEL), WACOM_INTUOS_BUTTONS, =
WACOM_INTUOS_TOOLS },=0A=
+	{ "Wacom Volito",        8,  5104,  3712,  511, 32, =
wacom_graphire_irq,=0A=
+		BIT(EV_REL), 0, 0, 0 },=0A=
+	{ "Wacom Graphire3 4x5", 8, 10208,  7424,  511, 32, =
wacom_graphire_irq,=0A=
 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },=0A=
-	{ "Wacom Graphire2 5x7",     8, 10206,  7422,  511, 32, =
wacom_graphire_irq,=0A=
+	{ "Wacom Graphire3 6x8", 8, 16704, 12064,  511, 32, =
wacom_graphire_irq,=0A=
 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },=0A=
-	{ "Wacom Intuos 4x5",   10, 12700, 10360, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos 6x8",   10, 20320, 15040, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos 9x12",  10, 30480, 23060, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos 12x12", 10, 30480, 30480, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos 12x18", 10, 47720, 30480, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom PL400",        8,  12328, 9256,   511, 32, wacom_pl_irq,=0A=
-		0,  0, 0, 0 },=0A=
-	{ "Wacom PL500",        8,  12328, 9256,   511, 32, wacom_pl_irq,=0A=
-		0,  0, 0, 0 },=0A=
-	{ "Wacom PL600",        8,  12328, 9256,   511, 32, wacom_pl_irq,=0A=
-		0,  0, 0, 0 },=0A=
-	{ "Wacom PL600SX",        8,  12328, 9256,   511, 32, =
wacom_pl_irq,=0A=
-		0,  0, 0, 0 },=0A=
-	{ "Wacom PL550",        8,  12328, 9256,   511, 32, wacom_pl_irq,=0A=
-		0,  0, 0, 0 },=0A=
-	{ "Wacom PL800",        8,  12328, 9256,   511, 32, wacom_pl_irq,=0A=
-		0,  0, 0, 0 },=0A=
-	{ "Wacom Intuos2 4x5",   10, 12700, 10360, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos2 6x8",   10, 20320, 15040, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos2 9x12",  10, 30480, 23060, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos2 12x12", 10, 30480, 30480, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
-	{ "Wacom Intuos2 12x18", 10, 47720, 30480, 1023, 15, =
wacom_intuos_irq,=0A=
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS =
},=0A=
+	{ "Wacom Cintiq Partner",8, 20480, 15360,  511, 32, wacom_ptu_irq, 0, =
 0, 0, 0 },=0A=
 	{ NULL , 0 }=0A=
 };=0A=
 =0A=
@@ -404,6 +520,13 @@ struct usb_device_id wacom_ids[] =3D {=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43), driver_info: 17 },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44), driver_info: 18 },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45), driver_info: 19 },=0A=
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x60), driver_info: 20 },=0A=
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x13), driver_info: 21 },=0A=
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x14), driver_info: 22 },=0A=
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x03), driver_info: 23 },=0A=
+=0A=
+	/* some Intuos2 6x8's erroneously report as 0x47 */=0A=
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x47), driver_info: 16 },=0A=
 	{ }=0A=
 };=0A=
 =0A=
@@ -431,11 +554,24 @@ static void wacom_close(struct input_dev=0A=
 		usb_unlink_urb(&wacom->irq);=0A=
 }=0A=
 =0A=
+static void wacom_reset(struct wacom* wacom)=0A=
+{=0A=
+	char rep_data[2] =3D {0x02, 0x02};=0A=
+=0A=
+	#ifdef __JEJ_DEBUG=0A=
+	printk(KERN_INFO __FILE__ ": Setting tablet report for tablet =
data\n");=0A=
+	#endif=0A=
+=0A=
+	/* ask the tablet to report tablet data */=0A=
+	usb_set_report(wacom->usbdev, wacom->ifnum, 3, 2, rep_data, 2);=0A=
+	usb_set_report(wacom->usbdev, wacom->ifnum, 3, 5, rep_data, 0);=0A=
+	usb_set_report(wacom->usbdev, wacom->ifnum, 3, 6, rep_data, 0);=0A=
+}=0A=
+=0A=
 static void *wacom_probe(struct usb_device *dev, unsigned int ifnum, =
const struct usb_device_id *id)=0A=
 {=0A=
 	struct usb_endpoint_descriptor *endpoint;=0A=
 	struct wacom *wacom;=0A=
-	char rep_data[2] =3D {0x02, 0x02};=0A=
 	=0A=
 	if (!(wacom =3D kmalloc(sizeof(struct wacom), GFP_KERNEL))) return =
NULL;=0A=
 	memset(wacom, 0, sizeof(struct wacom));=0A=
@@ -476,6 +612,10 @@ static void *wacom_probe(struct usb_devi=0A=
 	wacom->dev.idproduct =3D dev->descriptor.idProduct;=0A=
 	wacom->dev.idversion =3D dev->descriptor.bcdDevice;=0A=
 	wacom->usbdev =3D dev;=0A=
+	wacom->ifnum =3D ifnum;=0A=
+=0A=
+	INIT_LIST_HEAD(&wacom->event_list);=0A=
+	init_MUTEX(&wacom->kwacomd_sem);=0A=
 =0A=
 	endpoint =3D dev->config[0].interface[ifnum].altsetting[0].endpoint + =
0;=0A=
 =0A=
@@ -485,12 +625,9 @@ static void *wacom_probe(struct usb_devi=0A=
 		     wacom->data, wacom->features->pktlen, wacom->features->irq, =
wacom, endpoint->bInterval);=0A=
 =0A=
 	input_register_device(&wacom->dev);=0A=
-=0A=
-	/* ask the tablet to report tablet data */=0A=
-	usb_set_report(dev, ifnum, 3, 2, rep_data, 2);=0A=
-	usb_set_report(dev, ifnum, 3, 5, rep_data, 0);=0A=
-	usb_set_report(dev, ifnum, 3, 6, rep_data, 0);=0A=
 	=0A=
+	wacom_reset(wacom);=0A=
+=0A=
 	printk(KERN_INFO "input%d: %s on usb%d:%d.%d\n",=0A=
 	       wacom->dev.number, wacom->features->name, dev->bus->busnum, =
dev->devnum, ifnum);=0A=
 =0A=
@@ -499,10 +636,73 @@ static void *wacom_probe(struct usb_devi=0A=
 =0A=
 static void wacom_disconnect(struct usb_device *dev, void *ptr)=0A=
 {=0A=
+	unsigned int flags;=0A=
 	struct wacom *wacom =3D ptr;=0A=
-	usb_unlink_urb(&wacom->irq);=0A=
-	input_unregister_device(&wacom->dev);=0A=
-	kfree(wacom);=0A=
+	if (wacom)=0A=
+	{=0A=
+    		spin_lock_irqsave(&wacom_event_lock, flags);=0A=
+		list_del(&wacom->event_list);=0A=
+		INIT_LIST_HEAD(&wacom->event_list);=0A=
+		spin_unlock_irqrestore(&wacom_event_lock, flags);=0A=
+=0A=
+		/* Wait for kwacomd to leave this tablet alone. */=0A=
+		down(&wacom->kwacomd_sem);=0A=
+		up(&wacom->kwacomd_sem);=0A=
+=0A=
+		usb_unlink_urb(&wacom->irq);=0A=
+		input_unregister_device(&wacom->dev);=0A=
+		kfree(wacom);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void wacom_events(void)=0A=
+{=0A=
+	struct wacom* wacom;=0A=
+	unsigned int flags;=0A=
+	struct list_head *tmp;=0A=
+=0A=
+	printk(KERN_INFO "wacom_events\n");=0A=
+=0A=
+	while (1)=0A=
+	{=0A=
+		spin_lock_irqsave(&wacom_event_lock, flags);=0A=
+=0A=
+		if (list_empty(&wacom_event_list))=0A=
+			break;=0A=
+=0A=
+		/* Grab the next entry from the beginning of the list */=0A=
+		tmp =3D wacom_event_list.next;=0A=
+		wacom =3D list_entry(tmp, struct wacom, event_list);=0A=
+=0A=
+		list_del(tmp); /* dequeue tablet */=0A=
+		INIT_LIST_HEAD(tmp);=0A=
+=0A=
+		if (down_trylock(&wacom->kwacomd_sem) !=3D 0) BUG(); /* never blocks =
*/=0A=
+		spin_unlock_irqrestore(&wacom_event_lock, flags);=0A=
+=0A=
+		wacom_reset(wacom);=0A=
+=0A=
+		up(&wacom->kwacomd_sem); /* mark tablet free */=0A=
+	}=0A=
+	spin_unlock_irqrestore(&wacom_event_lock, flags);=0A=
+}=0A=
+=0A=
+static int wacom_thread(void* pv)=0A=
+{=0A=
+	daemonize();=0A=
+	reparent_to_init();=0A=
+=0A=
+	/* Setup a nice name */=0A=
+	strcpy(current->comm, "kwacomd");=0A=
+=0A=
+	/* Send me a signal to get me die (for debugging) */=0A=
+	while (!signal_pending(current))=0A=
+	{=0A=
+		wacom_events();=0A=
+		wait_event_interruptible(kwacomd_wait, =
!list_empty(&wacom_event_list));=0A=
+	}=0A=
+=0A=
+	complete_and_exit(&kwacomd_exited, 0);=0A=
 }=0A=
 =0A=
 static struct usb_driver wacom_driver =3D {=0A=
@@ -512,16 +712,33 @@ static struct usb_driver wacom_driver =3D =0A=
 	id_table:	wacom_ids,=0A=
 };=0A=
 =0A=
-static int __init wacom_init(void)=0A=
+static int __init wacom_init(void) =0A=
 {=0A=
+	int pid;=0A=
 	usb_register(&wacom_driver);=0A=
 	info(DRIVER_VERSION " " DRIVER_AUTHOR);=0A=
 	info(DRIVER_DESC);=0A=
-	return 0;=0A=
+	pid =3D kernel_thread(wacom_thread, NULL,=0A=
+			CLONE_FS | CLONE_FILES | CLONE_SIGHAND);=0A=
+	if (pid >=3D 0) {=0A=
+		kwacomd_pid =3D pid;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	/* Fall through if kernel_thread failed */=0A=
+	usb_deregister(&wacom_driver);=0A=
+	err("failed to start wacom_thread");=0A=
+=0A=
+	return -1;=0A=
 }=0A=
 =0A=
 static void __exit wacom_exit(void)=0A=
 {=0A=
+	int ret;=0A=
+=0A=
+	/* Kill the thread */=0A=
+	ret =3D kill_proc(kwacomd_pid, SIGTERM, 1);=0A=
+	wait_for_completion(&kwacomd_exited);=0A=
 	usb_deregister(&wacom_driver);=0A=
 }=0A=
 =0A=


------_=_NextPart_000_01C3F800.A3C7B5EE--
