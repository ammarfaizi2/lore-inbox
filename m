Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423265AbWBBHVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423265AbWBBHVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423267AbWBBHVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:21:14 -0500
Received: from main.gmane.org ([80.91.229.2]:59849 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423265AbWBBHVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:21:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: <pci_lookup_name: buffer too small>
Date: Thu, 02 Feb 2006 16:19:04 +0900
Message-ID: <drsbp9$76q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060119)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

Not sure if this is kernel problem or pcuitils-2.2.0 problem, please have a
look.


 ~ # uname -a
Linux char 2.6.15.1-K01_P4_server #3 SMP Wed Jan 25 22:57:16 JST 2006 i686
Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

 ~ # lspci |grep 01:04.0 && echo && lspci -G -xxxx -vv -s 01:04.0
01:04.0 Mass storage controller: <pci_lookup_name: buffer too small> (rev 13)

Trying method 1......using /sys/bus/pci...OK
Decided to use Linux-sysfs
01:04.0 Mass storage controller: <pci_lookup_name: buffer too small> (rev 13)
        Subsystem: ASUSTeK Computer Inc. Unknown device 813a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d000 [size=4]
        Region 2: I/O ports at c800 [size=8]
        Region 3: I/O ports at c400 [size=4]
        Region 4: I/O ports at c000 [size=16]
        Expansion ROM at 80000000 [disabled] [size=128K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 83 12 12 82 07 00 30 02 13 00 80 01 00 00 00 00
10: 01 d4 00 00 01 d0 00 00 01 c8 00 00 01 c4 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 43 10 3a 81
30: 00 00 fc cf 80 00 00 00 00 00 00 00 0b 01 08 08
40: f0 a0 36 01 08 00 08 00 02 02 00 00 04 02 04 02
50: 00 20 00 00 a3 00 31 31 a3 00 31 31 00 1a 01 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The controller in question is on board Asus P5GDC-V Deluxe and I just
enabled it in BIOS, because I run shoert of IDE channels:

 ~ # dmesg |grep -i IT8212
[    1.636300] IT8212: IDE controller at PCI slot 0000:01:04.0
[    1.636320] IT8212: chipset revision 19
[    1.636326] IT8212: 100% native mode on irq 18


Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

