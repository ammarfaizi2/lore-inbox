Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUHWPeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUHWPeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHWPbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:31:34 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:41642 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265060AbUHWP2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:28:32 -0400
Subject: radeonfb problems (console blanking & acpi suspend)
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1093274970.9973.12.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 17:29:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following problems with my Radeon FireGL Mobility T2 (IBM
Thinkpad R50p):
1) there is no console blanking nor backlight off powersaving with
fbconsole (no X running nor started since boot)
2) after an acpi suspend the backlight goes back on but there is no data
displayed on the screen (no X running nor started since boot)

If more information is needed for diagnosis then please email me.

used kernel versions: 2.6.6  2.6.7  2.6.8.1  2.6.8.1-mm3

lspci -v
0000:01:00.0 VGA compatible controller: ATI Technologies Inc M10 NT
[FireGL Mobility T2] (rev 80) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 054f
        Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency
255, IRQ 11
        Memory at e0000000 (32-bit, prefetchable)
        I/O ports at 3000 [size=256]
        Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

dmesg:

....
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=320.00 Mhz,
System=202.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1600x1200
radeonfb: detected LVDS panel size from BIOS: 1600x1200
radeondb: BIOS provided dividers will be used
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon NT  SDR SGRAM 128 MB
....

