Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265824AbUF2RbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbUF2RbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265831AbUF2RbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:31:20 -0400
Received: from snota.svorka.net ([194.19.72.11]:44166 "HELO snota.svorka.net")
	by vger.kernel.org with SMTP id S265824AbUF2RbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:31:07 -0400
Message-ID: <40E1A8C9.8060405@svorka.net>
Date: Tue, 29 Jun 2004 19:37:13 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <eldiablo@svorka.net>
Reply-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040624)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: TG3 uses all cpu
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After som time with some network activity my machine becomes dead
slow, 'top' show that all cpu is in use, but no process is using it.
I tried to remove the tg3 module, i'm using that since i have a
Broadcome 5702 integrated nic, and then the cpu use went back to normal.
Kernel logs show nothing unusual.
The only kerneles i have noticed this on is them based on 2.6.7.

dmesg | grep eth gives this output:
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)]
(PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:18:d2:6c:bf
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0]
WireSpeed[1] TSOcap[1]
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
eth0: no IPv6 routers present


lspci -vvv gives this info about my nic:

0000:02:05.0 Ethernet controller: Broadcom Corporation NetXtreme 
BCM5702X Gigabit Ethernet (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a9
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at e4000000 (64-bit, non-prefetchable) 
[size=e76f0000]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48] 
Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ 
Queue=0/3 Enable-
                Address: effffdff7ffffffc  Data: feff


