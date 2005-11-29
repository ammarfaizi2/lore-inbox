Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVK2TDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVK2TDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVK2TDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:03:11 -0500
Received: from smtpout.mac.com ([17.250.248.73]:4569 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932344AbVK2TDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:03:10 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
To: linux-kernel@vger.kernel.org
Message-Id: <E066EDFE-FA32-4600-A1EC-721055EFA829@mac.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-364956179
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [PATCH][RFC][2.6.15-rc3] snd_powermac: Add ID for Spring 2005 17" Powerbook
From: Kyle Moffett <mrmacman_g4@mac.com>
Date: Tue, 29 Nov 2005 14:02:58 -0500
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3-364956179
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

The audio chip in my Spring 2005 17" PowerBook was incorrectly  
recognized as an AWACS chip.  This adds the chip ID to the  
snd_powermac driver such that it is recognized as a Toonie (I don't  
know if that's correct, but it's the only one that makes it work at  
all). and sorts the ID lists numerically.  NOTE:  This chip is only  
minimally supported at this point; it has system beep support and  
very low volume speaker output, and that's about it.

Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>


--Apple-Mail-3-364956179
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="pmacaudio.patch.txt"
Content-Disposition: attachment;
	filename=pmacaudio.patch.txt

--- linux-2.6.15-rc2/sound/ppc/pmac.c	2005-10-27 20:02:08.000000000 -0400
+++ linux-2.6.15-rc2-aphrodite1/sound/ppc/pmac.c	2005-11-26 02:18:40.000000000 -0500
@@ -987,11 +987,11 @@
 		 * single frequency until proper i2s control is implemented
 		 */
 		switch(layout_id) {
-		case 0x48:
-		case 0x46:
-		case 0x33:
-		case 0x29:
 		case 0x24:
+		case 0x29:
+		case 0x33:
+		case 0x46:
+		case 0x48:
 		case 0x50:
 		case 0x5c:
 			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
@@ -1000,6 +1000,7 @@
 			chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
 			break;
 		case 0x3a:
+		case 0x40:
 			chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
 			chip->model = PMAC_TOONIE;
 			chip->can_byte_swap = 0; /* FIXME: check this */


--Apple-Mail-3-364956179
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-3-364956179--
