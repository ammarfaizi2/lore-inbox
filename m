Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVH3UlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVH3UlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVH3UlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:41:07 -0400
Received: from web34306.mail.mud.yahoo.com ([66.163.178.138]:19577 "HELO
	web34306.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932440AbVH3UlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1t0Ua1S2mkYCs5aBz0oe/aiM0spOeFp3P/4jhf/oSOWmxpQtJ7iH/7iQaQqeayaM/hIQEeSpaVWGE1AlFdmTQNAuyzbH2mq8jzJq9O9SUK3YvUCUdSnx3raxVUy8HjYZtoYnHFw5ar5VXKGhS/+4Tw/L+4RddBv95h98JRDBRMo=  ;
Message-ID: <20050830204102.88806.qmail@web34306.mail.mud.yahoo.com>
Date: Tue, 30 Aug 2005 13:41:02 -0700 (PDT)
From: John Barkas <risc4all@yahoo.com>
Subject: [PATCH] acsi.c & usbusx2yaudio.c & usx2yhwdeppcm.c ,2.6.12.5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1896126212-1125434462=:88220"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1896126212-1125434462=:88220
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

I send this e-mail to you with the patches ready as
the patch fixes are obvious.


Hello I am Ioannis Barkas.You can contact me at
risc4all@yahoo.com.

There is a typo error in the comments area of
linux-2.6.12.5\drivers\block at the file

acsi.c

There are two typo errors in
linux-2.6.12.5\sound\usb\usx2y at the file

usbusx2yaudio.c

There is a typo error in
linux-2.6.12.5\sound\usb\usx2y at the file

usx2yhwdeppcm.c



I found this bug after I had it repeated in some files
on my HDD...That time it was clear and obvious to me
that the kernel would suffer from this error..Luckily
it affected only those three files.


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
--0-1896126212-1125434462=:88220
Content-Type: text/plain; name="OK 2 README"
Content-Description: 736512930-OK 2 README
Content-Disposition: inline; filename="OK 2 README"

Hello I am Ioannis Barkas.You can contact me at risc4all@yahoo.com.


There is a typo error in the comments area of linux-2.6.12.5\drivers\block at the file

acsi.c

There are two typo errors in linux-2.6.12.5\sound\usb\usx2y at the file

usbusx2yaudio.c

There is a typo error in linux-2.6.12.5\sound\usb\usx2y at the file

usx2yhwdeppcm.c

I found this bug after I had it repeated in some files on my HDD...That time it was clear and obvious to me that the kernel would suffer from this error..Luckily it affected only those three files.
--0-1896126212-1125434462=:88220
Content-Type: text/plain; name="2 patch0"
Content-Description: 3993010405-2 patch0
Content-Disposition: inline; filename="2 patch0"

--- /0/linux-2.6.12.5/drivers/block/acsi.c	2005-08-30 22:00:00.000000000 +0300
+++ /1/linux-2.6.12.5/drivers/block/acsi.c	2005-08-30 23:00:00.000000000 +0300
@@ -604,7 +604,7 @@
 /*
  * ACSI status phase: get the status byte from the bus
  *
- * I've seen several times that a 0xff status is read, propably due to
+ * I've seen several times that a 0xff status is read, probably due to
  * a timing error. In this case, the procedure is repeated after the
  * next _IRQ edge.
  */

--0-1896126212-1125434462=:88220
Content-Type: text/plain; name="2 patch1"
Content-Description: 2600696712-2 patch1
Content-Disposition: inline; filename="2 patch1"

--- /0/linux-2.6.12.5/sound/usb/usx2y/usbusx2yaudio.c	2005-08-30 22:00:00.000000000 +0300
+++ /1/linux-2.6.12.5/sound/usb/usx2y/usbusx2yaudio.c	2005-08-30 23:00:00.739618560 +0300
@@ -78,7 +78,7 @@
 	for (i = 0; i < nr_of_packs(); i++) {
 		cp = (unsigned char*)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
 		if (urb->iso_frame_desc[i].status) { /* active? hmm, skip this */
-			snd_printk("activ frame status %i. Most propably some hardware problem.\n", urb->iso_frame_desc[i].status);
+			snd_printk("activ frame status %i. Most probably some hardware problem.\n", urb->iso_frame_desc[i].status);
 			return urb->iso_frame_desc[i].status;
 		}
 		len = urb->iso_frame_desc[i].actual_length / usX2Y->stride;
@@ -291,7 +291,7 @@
 static void usX2Y_error_sequence(usX2Ydev_t *usX2Y, snd_usX2Y_substream_t *subs, struct urb *urb)
 {
 	snd_printk("Sequence Error!(hcd_frame=%i ep=%i%s;wait=%i,frame=%i).\n"
-		   "Most propably some urb of usb-frame %i is still missing.\n"
+		   "Most probably some urb of usb-frame %i is still missing.\n"
 		   "Cause could be too long delays in usb-hcd interrupt handling.\n",
 		   usb_get_current_frame_number(usX2Y->chip.dev),
 		   subs->endpoint, usb_pipein(urb->pipe) ? "in" : "out", usX2Y->wait_iso_frame, urb->start_frame, usX2Y->wait_iso_frame);

--0-1896126212-1125434462=:88220
Content-Type: text/plain; name="2 patch2"
Content-Description: 2086000875-2 patch2
Content-Disposition: inline; filename="2 patch2"

--- /0/linux-2.6.12.5/sound/usb/usx2y/usx2yhwdeppcm.c	2005-08-30 22:00:00.000000000 +0300
+++ /1/linux-2.6.12.5/sound/usb/usx2y/usx2yhwdeppcm.c	2005-08-30 23:00:00.930579704 +0300
@@ -72,7 +72,7 @@
 	}
 	for (i = 0; i < nr_of_packs(); i++) {
 		if (urb->iso_frame_desc[i].status) { /* active? hmm, skip this */
-			snd_printk("activ frame status %i. Most propably some hardware problem.\n", urb->iso_frame_desc[i].status);
+			snd_printk("activ frame status %i. Most probably some hardware problem.\n", urb->iso_frame_desc[i].status);
 			return urb->iso_frame_desc[i].status;
 		}
 		lens += urb->iso_frame_desc[i].actual_length / usX2Y->stride;

--0-1896126212-1125434462=:88220--
