Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUINIxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUINIxp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUINIxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:53:45 -0400
Received: from pD9FF1BA5.dip.t-dialin.net ([217.255.27.165]:3588 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269210AbUINIxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:53:42 -0400
Message-ID: <4146B194.7010001@uni-muenster.de>
Date: Tue, 14 Sep 2004 10:53:40 +0200
From: Borislav Petkov <petkov@uni-muenster.de>
Reply-To: petkov@uni-muenster.de
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] 2.6.9-rc1-mm5 remove usb_unlink_urb in class/audio.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the first one with fixed tabs (actually, may MUA kmail is biting them)

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- linux-2.6.9-rc1-mm/drivers/usb/class/audio.c.orig   2004-09-14 10:49:01.000000000 +0200
+++ linux-2.6.9-rc1-mm/drivers/usb/class/audio.c        2004-09-14 10:50:08.000000000 +0200
@@ -635,13 +635,13 @@ static void usbin_stop(struct usb_audiod
                 spin_unlock_irqrestore(&as->lock, flags);
                 if (notkilled && signal_pending(current)) {
                         if (i & FLG_URB0RUNNING)
-                               usb_unlink_urb(u->durb[0].urb);
+                               usb_kill_urb(u->durb[0].urb);
                         if (i & FLG_URB1RUNNING)
-                               usb_unlink_urb(u->durb[1].urb);
+                               usb_kill_urb(u->durb[1].urb);
                         if (i & FLG_SYNC0RUNNING)
-                               usb_unlink_urb(u->surb[0].urb);
+                               usb_kill_urb(u->surb[0].urb);
                         if (i & FLG_SYNC1RUNNING)
-                               usb_unlink_urb(u->surb[1].urb);
+                               usb_kill_urb(u->surb[1].urb);
                         notkilled = 0;
                 }
         }
@@ -1114,13 +1114,13 @@ static void usbout_stop(struct usb_audio
                 spin_unlock_irqrestore(&as->lock, flags);
                 if (notkilled && signal_pending(current)) {
                         if (i & FLG_URB0RUNNING)
-                               usb_unlink_urb(u->durb[0].urb);
+                               usb_kill_urb(u->durb[0].urb);
                         if (i & FLG_URB1RUNNING)
-                               usb_unlink_urb(u->durb[1].urb);
+                               usb_kill_urb(u->durb[1].urb);
                         if (i & FLG_SYNC0RUNNING)
-                               usb_unlink_urb(u->surb[0].urb);
+                               usb_kill_urb(u->surb[0].urb);
                         if (i & FLG_SYNC1RUNNING)
-                               usb_unlink_urb(u->surb[1].urb);
+                               usb_kill_urb(u->surb[1].urb);
                         notkilled = 0;
                 }
         }
