Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTBIGfJ>; Sun, 9 Feb 2003 01:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTBIGfI>; Sun, 9 Feb 2003 01:35:08 -0500
Received: from cmsrelay04.mx.net ([165.212.11.113]:58303 "HELO
	cmsrelay04.mx.net") by vger.kernel.org with SMTP id <S266987AbTBIGfH>;
	Sun, 9 Feb 2003 01:35:07 -0500
Subject: Problem w/2.5.59 & orinoco_pci (works w/2.4.18)
From: Cory Bell <cory.bell@usa.net>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Feb 2003 22:43:21 -0800
Message-Id: <1044773002.3709.52.camel@localhost>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on an old Dell Pentium/100. This may or may not be related, but
it requires pci=conf1 (for 2.4) or pci=conf2 (for 2.5) to get proper
lspci output. I get similar results with Jouni Malinen's hostap_pci
driver (works in 2.4, not in 2.5), which makes me think something
changed in 2.5 that broke both drivers. This is a Linksys WMP11 PCI
wireless adapter.

I don't have anything fancy (himem, preempt, etc) compiled into the
kernel, just the basics for a wireless AP/firewall.

Thanks for any help you can provide! I'm happy to supply any additional
information or test solutions upon request. I'm not subscribed, so
please cc me.

-Cory Bell

Broken (vanilla 2.5.59):
Feb  8 12:42:45 kernel: Reset done.........................................................................................................................................................................................................................................................;
Feb  8 12:42:45 kernel: Clear Reset..................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
Feb  8 12:42:45 kernel: pci_cor : reg = 0x0 - 3115F85 - 3115D91
Feb  8 12:42:45 kernel: hermes @ MEM 0xc881d000: Timeout waiting for card to reset (reg=0x0000)!
Feb  8 12:42:45 kernel: eth2: failed to initialize firmware (err = -110)
Feb  8 12:42:45 kernel: eth2: Failed to register net device

Working (RedHat 2.4.18-24.8.0):
Feb  8 20:01:57 kernel: Reset done...................................................................................................................................................................................................................................................;
Feb  8 20:01:57 kernel: Clear Reset....................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
Feb  8 20:01:57 kernel: pci_cor : reg = 0x0 - 1629 - 15F7
Feb  8 20:01:58 kernel: eth2: Channel out of range (0)!
Feb  8 20:01:58 kernel: eth2: Error -110 writing Tx descriptor to BAP
Feb  8 20:01:58 last message repeated 10 times

lspci (2.4 & 2.5 are identical):
00:07.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset (rev 01)
        Subsystem: Unknown device 1737:3874
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at 3efff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 60 12 73 38 13 01 90 02 01 00 80 02 08 20 00 00
10: 08 f0 ff 3e 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 37 17 74 38
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0f 01 00 00
40: 80 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 7e
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

