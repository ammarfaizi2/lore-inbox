Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRCCCxb>; Fri, 2 Mar 2001 21:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130239AbRCCCxW>; Fri, 2 Mar 2001 21:53:22 -0500
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:61321
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S130238AbRCCCxE>; Fri, 2 Mar 2001 21:53:04 -0500
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200103030252.f232qeF15551@frx774.dhs.org>
Subject: [PATCH] Add Epson Perfection 1640SU scanner to scanner.c
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 18:52:40 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just purchased an Epson Perfection 1640SU (SCSI/USB) scanner (1600 dpi optical),
and found in some tips (forgot where now) on getting it recognized by the USB code:
(I made the change in a vanilla 2.4.2 kernel.)

diff -urNb linux-2.4.2/drivers/usb/scanner.c linux-2.4.2.modified/drivers/usb/scanner.c
--- linux-2.4.2/drivers/usb/scanner.c   Thu Jan  4 13:15:32 2001
+++ linux-2.4.2.modified/drivers/usb/scanner.c  Sat Feb 24 22:49:21 2001
@@ -303,6 +303,7 @@
    { USB_DEVICE(0x04b8, 0x0104) }, /* Perfection 1200U and 1200Photo*/
    { USB_DEVICE(0x04b8, 0x0106) }, /* Stylus Scan 2500 */ 
    { USB_DEVICE(0x04b8, 0x0107) }, /* Expression 1600 */ 
+   { USB_DEVICE(0x04b8, 0x010a) }, /* Perfection 1640SU and 1640SUPhoto */
    /* Umax */ 
    { USB_DEVICE(0x1606, 0x0010) }, /* Astra 1220U */
    { USB_DEVICE(0x1606, 0x0030) }, /* Astra 2000U */


FYI, it works well with the latest SANE packages; some of my friends of the Windows
persuasion find it easier to use (XSane) than other scanner packages they're used to.
And more stable.  :)

-jesse


Jesse Wyant - jrwyant@frx774.dhs.org
------------------------------------------------------------
If there was any justice in the world, "trust" would be a four-letter word.

