Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbRGMPZH>; Fri, 13 Jul 2001 11:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbRGMPY5>; Fri, 13 Jul 2001 11:24:57 -0400
Received: from pop.gmx.net ([194.221.183.20]:7221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267492AbRGMPYk>;
	Fri, 13 Jul 2001 11:24:40 -0400
Message-ID: <3B4F1314.B8B528AE@gmx.at>
Date: Fri, 13 Jul 2001 17:26:12 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: joystick & fortemedia 801 soundcard
Content-Type: multipart/mixed;
 boundary="------------0E51BB41D5B715471A72E6ED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0E51BB41D5B715471A72E6ED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

For those who want to use a joystick on the gameport of a soundcard with
fm801 chipset! Here is a one liner to make it work (just adds the PCI id
of the gameport):
--------------0E51BB41D5B715471A72E6ED
Content-Type: text/plain; charset=us-ascii;
 name="fm801-joy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fm801-joy.diff"

diff -Nur linux-2.4.4+hptraid0.1a/drivers/char/joystick/ns558.c linux/drivers/char/joystick/ns558.c
--- linux-2.4.4+hptraid0.1a/drivers/char/joystick/ns558.c	Fri Jul 13 17:10:49 2001
+++ linux/drivers/char/joystick/ns558.c	Wed Jul 11 23:15:39 2001
@@ -158,6 +158,7 @@
 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* SB Live! gameport */
 	{ 0x125d, 0x1969, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 }, /* ESS Solo 1 */
 	{ 0x5333, 0xca00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 }, /* S3 SonicVibes */
+	{ 0x1319, 0x0802, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* FM 801 */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, ns558_pci_tbl);

--------------0E51BB41D5B715471A72E6ED--

