Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135612AbREFA7m>; Sat, 5 May 2001 20:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbREFA7b>; Sat, 5 May 2001 20:59:31 -0400
Received: from [62.81.160.203] ([62.81.160.203]:43471 "EHLO smtp3.eresmas.com")
	by vger.kernel.org with ESMTP id <S135612AbREFA7R>;
	Sat, 5 May 2001 20:59:17 -0400
Date: Sun, 6 May 2001 02:49:55 -0400
From: Ignacio Monge <ignaciomonge@navegalia.com>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 8139too bug in 2.4.4 (2.4.3?) & VIA 686a
Message-Id: <20010506024955.74222c9b.ignaciomonge@navegalia.com>
X-Mailer: Sylpheed version 0.4.65 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi, here I again with another problem :)
	Since I have installed kenel 2.4.3 & 2.4.4 (nothing went wrong with
default kernel in MDK 8, 2.4.3mdk), my ethernet card is not recognized
correctly.

	This is my ifconfig output:
eth0      Link encap:Ethernet  HWaddr 00:E0:29:9A:CB:62  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:437 errors:0 dropped:0 overruns:0 frame:0
          TX packets:302 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:70770 (69.1 Kb)  TX bytes:222559 (217.3 Kb)
          Interrupt:11 Base address:0xc000 

	The HWaddr is correctly (I'm using 2.4.3mdk actually). But, with
2.4.3-2.4.4 this value is incorrect, and after a couple of minutes, kernel
displays a message like this "Clock timer bug, may be a hardware bug VIA
686a." After reboot linux, this BIOS setup has deleted (CMOS checksum
error...), and the default values reloaded.

	I can't use another kernel than 2.4.3mdk.

	<Another interesting outputs:

	lspci -vv:
	[...
	00:0c.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
(rev 10)
	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at de800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
	...]


	dmesg:
	[...
8139too Fast Ethernet driver 0.9.15c loaded
PCI: Found IRQ 11 for device 00:0c.0
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xda88c000,
00:e0:29:9a:cb:62, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
...]

	I hope this may help.
	
	
	
	
