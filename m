Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbUAPOl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUAPOl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:41:58 -0500
Received: from gizmo13ps.bigpond.com ([144.140.71.23]:21224 "HELO
	gizmo13ps.bigpond.com") by vger.kernel.org with SMTP
	id S264981AbUAPOlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:41:53 -0500
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] 2.6.1-mm4 ohci1394 oops
Date: Sat, 17 Jan 2004 01:42:50 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401170142.50216.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do "modprobe ohci1394" (captured using Serial Console):

ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[e3006000-e30067ff]  
Max Packet=[4096]
NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0
Pid: 136, comm: modprobe Not tainted
RIP: 0010:[<ffffffffa003a21e>] 
<ffffffffa003a21e>{:ieee1394:hpsb_register_addrspace+254}
RSP: 0018:000001003ea75a98  EFLAGS: 00000087
RAX: 000001003ee06070 RBX: 0000fffff0000400 RCX: 000001003e643540
RDX: 000001003ee06070 RSI: 000001003e643550 RDI: 000001003ffef200
RBP: 0000fffff0000000 R08: 0000fffff0000400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa004aa60
R13: 000001003ee04000 R14: 0000000000000000 R15: ffffffffa004a9a0
FS:  00000000005144a0(0000) GS:ffffffff80363bc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a95577000 CR3: 0000000000101000 CR4: 00000000000006a0
Process modprobe (pid: 136, stackpage=1003fd0ea70)
Stack: 0000000000000202 000001003ee04000 000001003ee04000 0000000000000000
       000001003ea75b78 000001003ea75bc8 000001003ee04000 ffffffffa003aaf2
       000001003ee06080 000001003ee061e8
Call Trace:<ffffffffa003aaf2>{:ieee1394:add_host+50} 
<ffffffffa0039fbe>{:ieee1394:highlevel_add_host+62}
       <ffffffffa0039509>{:ieee1394:hpsb_add_host+9} 
<ffffffffa0056aab>{:ohci1394:ohci1394_pci_probe+2731}
       <ffffffffa0037270>{:ieee1394:hpsb_bus_reset+0} 
<ffffffff801ba434>{pci_device_probe+116}
       <ffffffff801f5fd7>{bus_match+71} <ffffffff801f61c6>{driver_attach+70}
       <ffffffff801f628e>{bus_add_driver+126} 
<ffffffff801f6742>{driver_register+50}
       <ffffffff801ba4de>{pci_register_driver+62} 
<ffffffffa0056add>{:ohci1394:ohci1394_init+13}
       <ffffffff80145f39>{sys_init_module+5449} 
<ffffffff8017aa4b>{d_splice_alias+187}
       <ffffffff8019f757>{ext3_lookup+167} <ffffffff801718f2>{do_lookup+322}
       <ffffffff8010eaf4>{system_call+124}

Code: 48 39 68 38 48 89 c2 76 ee ff 34 24 9d 45 85 f6 75 08 48 89
console shuts up ...

It was fine until 2.6.1-mm3 (and in mainline too).

Hardware:
Athlon 64 3200+
Gigabyte K8VNXP
VIA K8T800
00:14.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8025 (rev 01) 
(prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology: Unknown device 1000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e3006000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

Feel free to ask for more information. Please cc me in replies.

Thanks
Hari
harisri@bigpond.com

