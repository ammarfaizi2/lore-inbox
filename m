Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbTCQSfQ>; Mon, 17 Mar 2003 13:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbTCQSfQ>; Mon, 17 Mar 2003 13:35:16 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:13732 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S261897AbTCQSfN>; Mon, 17 Mar 2003 13:35:13 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: radeonfb and DFP problems (kernel 2.5.63)
Date: Mon, 17 Mar 2003 13:46:13 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJCEEHFGAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed an ATI Radeon 9000 Pro video card in my primary Linux
system, along with a DFP (hp pavilion f70). Things are not working as I
expected...

When I have the DFP connected to the Radeon's DVI port, I can not use the
frambuffer in Xfree86 4.1 (it complains there is no /dev/fb0), and the log
states:

Mar 17 13:02:03 Tycho kernel: radeonfb_pci_register BEGIN
Mar 17 13:02:03 Tycho kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=27500
from BIOS
Mar 17 13:02:03 Tycho kernel: radeonfb: probed DDR SGRAM 65536k videoram
Mar 17 13:02:03 Tycho kernel: radeonfb: panel ID string: ªhé¬^E
Mar 17 13:02:03 Tycho kernel: radeonfb: detected DFP panel size from BIOS:
1x0
Mar 17 13:02:03 Tycho kernel: radeonfb: Failed to detect DFP panel size

When I have the DFP attached to the Radeon's VGA port, I can run the DFP
(albeit in analog more), and the log states:

Mar 17 13:13:05 Tycho kernel: radeonfb_pci_register BEGIN
Mar 17 13:13:05 Tycho kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=27500
from BIOS
Mar 17 13:13:05 Tycho kernel: radeonfb: probed DDR SGRAM 65536k videoram
Mar 17 13:13:05 Tycho kernel: radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
Mar 17 13:13:05 Tycho kernel: radeonfb: DVI port CRT monitor connected
Mar 17 13:13:05 Tycho kernel: radeonfb: CRT port no monitor connected
Mar 17 13:13:05 Tycho kernel: radeonfb_pci_register END

Before I start digging around in the drivers/video/radeonfb.c file, I'm
wondering if this problem is known, and if a workaround is available.

..Scott

Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

