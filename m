Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbVIPAUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVIPAUa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVIPAUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:20:30 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:15502 "EHLO
	south-station-annex.mit.edu") by vger.kernel.org with ESMTP
	id S1030468AbVIPAU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:20:29 -0400
Subject: pci detection on alpha fails to assign irq to on-board usb device
From: Ilia Mirkin <imirkin@MIT.EDU>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 15 Sep 2005 20:20:06 -0400
Message-Id: <1126830006.7002.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.041
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on a Compaq Professional Workstation XP1000, which is a Tsunami
system, compiled with the DP264 system setting in the kernel:

ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd 0000:00:07.3: Found HC with no IRQ.  Check BIOS/PCI
0000:00:07.3 setup!
ohci_hcd 0000:00:07.3: init 0000:00:07.3 fail, -19

lspci -vvvx -s 00:07.3
0000:00:07.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10
[OHCI])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 0000000009018000 (32-bit, non-prefetchable)
00: 80 10 93 c6 03 00 80 02 00 10 03 0c 08 f8 80 00
10: 00 80 01 09 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

There was a fix that went into the miata system type a while back:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.3/0849.html

I am using kernel 2.6.12.5, though the same problem occured with
2.6.11.8.

Unfortunately I do not know enough about these systems to attempt to
copy such a fix into the dp264 system type -- I made an attempt, but it
had no effect.

If you send me a patch to try out, I can do so as the system is not
being used for anything serious at the moment. If you need more info
about the system, just ask.

Thanks,

Ilia

