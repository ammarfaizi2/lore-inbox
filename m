Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUESO0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUESO0m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 10:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUESO0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 10:26:35 -0400
Received: from [213.13.117.218] ([213.13.117.218]:5852 "EHLO
	mail.paradigma.co.pt") by vger.kernel.org with ESMTP
	id S264205AbUESO03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 10:26:29 -0400
Date: Wed, 19 May 2004 15:24:47 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [2.6][PATCH] cleanup double semicolons
Message-ID: <20040519142447.GB17449@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


Continuing from the 2.4 patch(es) I just sent, here is the much smaller 
diff to kill off the remaining double semicolons in 2.6. It is against 
2.6.6-bk5.

Please review.



		Nuno



diff -pruN linux-2.6.6-bk5-vanilla/arch/arm/mach-pxa/leds-lubbock.c linux-2.6.6-bk5/arch/arm/mach-pxa/leds-lubbock.c
--- linux-2.6.6-bk5-vanilla/arch/arm/mach-pxa/leds-lubbock.c	2004-05-16 18:19:36.000000000 +0100
+++ linux-2.6.6-bk5/arch/arm/mach-pxa/leds-lubbock.c	2004-05-19 00:39:17.462248720 +0100
@@ -88,7 +88,7 @@ void lubbock_leds_event(led_event_t evt)
 		break;
 
 	case led_green_on:
-		hw_led_state |= D21;;
+		hw_led_state |= D21;
 		break;
 
 	case led_green_off:
@@ -96,7 +96,7 @@ void lubbock_leds_event(led_event_t evt)
 		break;
 
 	case led_amber_on:
-		hw_led_state |= D22;;
+		hw_led_state |= D22;
 		break;
 
 	case led_amber_off:
@@ -104,7 +104,7 @@ void lubbock_leds_event(led_event_t evt)
 		break;
 
 	case led_red_on:
-		hw_led_state |= D23;;
+		hw_led_state |= D23;
 		break;
 
 	case led_red_off:
diff -pruN linux-2.6.6-bk5-vanilla/drivers/char/ipmi/ipmi_bt_sm.c linux-2.6.6-bk5/drivers/char/ipmi/ipmi_bt_sm.c
--- linux-2.6.6-bk5-vanilla/drivers/char/ipmi/ipmi_bt_sm.c	2004-05-16 18:19:37.000000000 +0100
+++ linux-2.6.6-bk5/drivers/char/ipmi/ipmi_bt_sm.c	2004-05-19 00:39:46.562824760 +0100
@@ -445,7 +445,7 @@ static enum si_sm_result bt_event(struct
 
 	case BT_STATE_RESET1:
     		reset_flags(bt);
-    		bt->timeout = BT_RESET_DELAY;;
+    		bt->timeout = BT_RESET_DELAY;
 		bt->state = BT_STATE_RESET2;
 		break;
 
diff -pruN linux-2.6.6-bk5-vanilla/drivers/net/wireless/hermes.h linux-2.6.6-bk5/drivers/net/wireless/hermes.h
--- linux-2.6.6-bk5-vanilla/drivers/net/wireless/hermes.h	2004-05-16 18:19:24.000000000 +0100
+++ linux-2.6.6-bk5/drivers/net/wireless/hermes.h	2004-05-19 00:39:37.139257360 +0100
@@ -384,7 +384,7 @@ static inline void hermes_read_words(str
 
 static inline void hermes_write_words(struct hermes *hw, int off, const void *buf, unsigned count)
 {
-	off = off << hw->reg_spacing;;
+	off = off << hw->reg_spacing;
 
 	if (hw->io_space) {
 		outsw(hw->iobase + off, buf, count);
@@ -406,7 +406,7 @@ static inline void hermes_clear_words(st
 {
 	unsigned i;
 
-	off = off << hw->reg_spacing;;
+	off = off << hw->reg_spacing;
 
 	if (hw->io_space) {
 		for (i = 0; i < count; i++)
diff -pruN linux-2.6.6-bk5-vanilla/drivers/scsi/pci2000.c linux-2.6.6-bk5/drivers/scsi/pci2000.c
--- linux-2.6.6-bk5-vanilla/drivers/scsi/pci2000.c	2004-05-16 18:19:24.000000000 +0100
+++ linux-2.6.6-bk5/drivers/scsi/pci2000.c	2004-05-19 00:40:03.326276328 +0100
@@ -353,7 +353,7 @@ irqProceed:;
 		if ( WaitReady (padapter) )
 			{
 			OpDone (SCpnt, DID_TIME_OUT << 16);
-			goto irq_return;;
+			goto irq_return;
 			}
 
 		outb_p (tag0, padapter->mb0);										// get real error code
@@ -361,7 +361,7 @@ irqProceed:;
 		if ( WaitReady (padapter) )											// wait for controller to suck up the op
 			{
 			OpDone (SCpnt, DID_TIME_OUT << 16);
-			goto irq_return;;
+			goto irq_return;
 			}
 
 		error = inl (padapter->mb0);										// get error data
@@ -374,16 +374,16 @@ irqProceed:;
 			if ( bus )														// are we doint SCSI commands?
 				{
 				OpDone (SCpnt, (DID_OK << 16) | 2);
-				goto irq_return;;
+				goto irq_return;
 				}
 			if ( *SCpnt->cmnd == SCSIOP_TEST_UNIT_READY )
 				OpDone (SCpnt, (DRIVER_SENSE << 24) | (DID_OK << 16) | 2);	// test caller we have sense data too
 			else
 				OpDone (SCpnt, DID_ERROR << 16);
-			goto irq_return;;
+			goto irq_return;
 			}
 		OpDone (SCpnt, DID_ERROR << 16);
-		goto irq_return;;
+		goto irq_return;
 		}
 
 	outb_p (0xFF, padapter->tag);											// clear the op interrupt
