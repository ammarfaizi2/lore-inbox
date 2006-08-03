Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWHCPkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWHCPkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHCPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:40:31 -0400
Received: from iron.pdx.net ([207.149.241.18]:29677 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S964807AbWHCPka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:40:30 -0400
Subject: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
From: Sean Bruno <sean.bruno@dsl-only.net>
To: linux-kernel@vger.kernel.org
Cc: linux@syskonnect.de
Content-Type: text/plain
Date: Thu, 03 Aug 2006 08:40:01 -0700
Message-Id: <1154619601.6485.15.camel@home-desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing a very slow(32Kbytes per second) transfer rate on an
ASUS P5P800 mobo.  This occurs on a special case where I am sending
individual 32Kbyte messages from a second server.  

I suspect the hardware, but am not sure how to come up with a 'good'
regression test for this issue.  

Configurations I have tried:

1. If I swap out the ethernet adapter(tried a intel 10/100 and intel
10/100/1000) the transfer rate jumps up into the MBytes / second.

2. If I do 'other' network activity on the box, like scp'ing' files
around, the transfer rate for my 32Kbyte packets goes up into the
Mbytes / second.  So I am a little baffled with the behavior.  

3. If I just 'scp' files around of various sizes the transfer rate goes
up into the Mbytes / second.



some of the relevant dmesg information:

eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
...
eth0: network connection up using port A
    speed:           1000
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    role:            slave
    irq moderation:  disabled
    scatter-gather:  disabled
    tx-checksum:     disabled
    rx-checksum:     disabled


lspci -vvv output for the ethernet adapter:
02:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
Gigabit Ethernet Controller (rev 13)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit
Ethernet Controller (Asus)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (5750ns min, 7750ns max), Cache Line Size 04
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at fbffc000 (32-bit, non-prefetchable)
[size=16K]
        Region 1: I/O ports at e800 [size=256]
        Expansion ROM at f0000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data

The Marvel ethernet adapter is connected to a Linksys SD2005 10/100/1000
switch.  

Any ideas why it would be doing this or a 'good' test for me to try?

Sean

