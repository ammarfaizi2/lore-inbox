Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbRHMUgT>; Mon, 13 Aug 2001 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267992AbRHMUgL>; Mon, 13 Aug 2001 16:36:11 -0400
Received: from gent-smtp1.xs4all.be ([195.144.67.21]:41736 "EHLO
	gent-smtp1.xs4all.be") by vger.kernel.org with ESMTP
	id <S267977AbRHMUgE>; Mon, 13 Aug 2001 16:36:04 -0400
Date: Mon, 13 Aug 2001 22:34:33 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] New ISA-PnP gameport device ID
Message-ID: <20010813223433.A541@lucretia.debian.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Marks-The-Spot: xxxxxxxxxx
X-GPG-Fingerprint: 1024D/8E950E00 CAC1 0932 B6B9 8768 40DB  C6AA 1239 F709 8E95 0E00
X-Machine-info: Linux lucretia 2.4.8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had to add this for the gameport on my ALS120 soundcard to be detected.
Please apply.

Regards,

Filip


--- 2.4.8-old/drivers/char/joystick/ns558.c	Mon Aug 13 22:14:49 2001
+++ 2.4.8/drivers/char/joystick/ns558.c	Mon Aug 13 18:31:33 2001
@@ -231,6 +231,7 @@
  * PnP IDs:
  *
  * @P@0001 - ALS 100 (no comp. ID)
+ * @P@2001 - ALS 120 (no comp. ID)
  * CTL00c1 - SB AWE32 PnP
  * CTL00c3 - SB AWE64 PnP
  * CTL00f0 - SB16 PnP / Vibra 16x
@@ -245,6 +246,7 @@
 
 static struct isapnp_device_id pnp_devids[] = {
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('@','P','@'), ISAPNP_DEVICE(0x0001), 0 },
+	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('@','P','@'), ISAPNP_DEVICE(0x2001), 0 },
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x7001), 0 },
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x7002), 0 },
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','S','C'), ISAPNP_DEVICE(0x0b35), 0 },

-- 
"Also we should remember that unfortunately free software is not widely used
 because people prefers to have something to plug'n'play and not something to
 configure'n'work."
	-- Pier Luca.
