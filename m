Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263540AbRFKJIh>; Mon, 11 Jun 2001 05:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbRFKJI1>; Mon, 11 Jun 2001 05:08:27 -0400
Received: from qta.qui.uc.pt ([193.137.208.70]:250 "EHLO junco.tcc")
	by vger.kernel.org with ESMTP id <S263540AbRFKJIV>;
	Mon, 11 Jun 2001 05:08:21 -0400
Message-ID: <3B248A97.8000406@ci.uc.pt>
Date: Mon, 11 Jun 2001 10:08:39 +0100
From: "Paulo E. Abreu" <qtabreu@ci.uc.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCMCIA troubles with an Acer TravelMate 513TE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have this laptop and I am having trouble with pcmcia in every 2.4.x 
kernel.
Someone suggested that this could be a BIOS bug ...
Below there is the information, that I think is relevant to this problem. If
more is needed just tell me...
Now I cannot use any PCMCIA device with this laptop, this is critical as I
cannot have any network connection...
I hope someone can help me,
Thanks,
Paulo E. Abreu

Using a Xircom RBE 10/100 nic
=== from /var/log/messages
Jun  7 19:46:42 localhost kernel: Linux PCMCIA Card Services 3.1.22
Jun  7 19:46:42 localhost kernel:   options:  [pci] [cardbus] [pm]
Jun  7 19:46:42 localhost /etc/hotplug/net.agent: register event not handled
Jun  7 19:46:42 localhost kernel: PCI: Guessed IRQ 9 for device 00:13.0
Jun  7 19:46:42 localhost kernel: PCI: The same IRQ used for device 00:13.1
Jun  7 19:46:42 localhost kernel: PCI: Guessed IRQ 9 for device 00:13.1
Jun  7 19:46:42 localhost kernel: PCI: The same IRQ used for device 00:13.0
Jun  7 19:46:42 localhost kernel: Yenta IRQ list 08b8, PCI irq9
Jun  7 19:46:42 localhost kernel: Socket status: 30000007
Jun  7 19:46:42 localhost kernel: Yenta IRQ list 08b8, PCI irq9
Jun  7 19:46:42 localhost kernel: Socket status: 30000821
Jun  7 19:46:42 localhost kernel: cs: cb_alloc(bus 6): vendor 0x115d, 
device 0x0003
Jun  7 19:46:42 localhost kernel: PCI: Failed to allocate resource 0 for 
PCI device 115d:0003
Jun  7 19:46:42 localhost kernel:   got res[11000000:110007ff] for 
resource 1 of PCI device 115d:000
3
Jun  7 19:46:42 localhost kernel:   got res[11000800:11000fff] for 
resource 2 of PCI device 115d:000
3
Jun  7 19:46:42 localhost kernel:   got res[10c00000:10c03fff] for 
resource 6 of PCI device 115d:000
3
Jun  7 19:46:42 localhost kernel: PCI: Enabling device 06:00.0 (0000 -> 
0003)
Jun  7 19:46:42 localhost kernel: PCI: Setting latency timer of device 
06:00.0 to 64
Jun  7 19:46:42 localhost kernel: eth0: Xircom cardbus revision 3 at irq 9
Jun  7 19:46:42 localhost kernel: xircom_cb: Receiver failed to deactivate
Jun  7 19:46:42 localhost netfs: Mounting other filesystems:  succeeded
Jun  7 19:46:42 localhost kernel: xircom_cb: Transmitter failed to 
deactivate
Jun  7 19:46:42 localhost cardmgr[650]: executing: 'modprobe xircom_cb'
Jun  7 19:46:42 localhost kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun  7 19:46:42 localhost kernel: cs: IO port probe 0x0100-0x04ff: 
excluding 0x408-0x40f 0x480-0x48f
 0x4d0-0x4d7
Jun  7 19:46:42 localhost kernel: cs: IO port probe 0x1000-0x17ff: clean.
Jun  7 19:46:42 localhost kernel: cs: IO port probe 0x0a00-0x0aff: clean.

=== from /proc/ioports
1000-107f : xircom_cb

=== from /proc/iomem
10000000-10000fff : O2 Micro, Inc. 6832
10001000-10001fff : O2 Micro, Inc. 6832 (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
  10c00000-10c03fff : PCI device 115d:0003
11000000-113fffff : PCI CardBus #06
  11000000-110007ff : PCI device 115d:0003
  11000800-11000fff : PCI device 115d:0003

=== from lspci -vvv
00:13.0 CardBus bridge: O2 Micro, Inc. 6832 (rev 34)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001

00:13.1 CardBus bridge: O2 Micro, Inc. 6832 (rev 34)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- 
PostWrite+
        16-bit legacy interface ports at 000

-- 
Departamento de Quimica                e-mail:qtabreu@ci.uc.pt
Faculdade de Ciencias e Tecnologia                              -o)
da Universidade de Coimbra            TEL:351 239 852080        / \
3004-535 Coimbra                      FAX:351 239 827703       _\_v
Portugal 


