Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbTLII0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 03:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbTLII0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 03:26:00 -0500
Received: from [212.182.218.5] ([212.182.218.5]:14865 "HELO nuoli.com")
	by vger.kernel.org with SMTP id S266137AbTLIIZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 03:25:55 -0500
Message-ID: <20031209082544.60005.qmail@nuoli.com>
From: "Jani Vaarala" <flame@pygmyprojects.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11, PCMCIA,, Cirrus CL  6729 bridge not working
Date: Tue, 09 Dec 2003 10:25:44 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get my PCMCIA bridge to work with 2.6.0-test11, but 
without any luck sofar.
My bridge works perfectly with 2.4.X series kernels and pcmcia-cs-3.2.5 
kernel modules (i82365,
with module options: irq_mode=1 fast_pci=1). 

It is a PCI-to-PCMCIA bridge based on Cirrus Logic CL 6729 (rev 07). 

Is there a way to get it working under 2.6 series kernels ? (as pcmcia-cs is 
not going to be supported
for 2.6 series kernels). 

 

Some dumps from the session: 

root@flamepygmy flame # modprobe yenta_socket
root@flamepygmy flame # cardmgr
cardmgr[3834]: no sockets found! 

root@flamepygmy flame # modprobe i82092
root@flamepygmy flame # cardmgr
cardmgr[3839]: no sockets found! 

root@flamepygmy flame # modprobe tcic
FATAL: Error inserting tcic 
(/lib/modules/2.6.0-test11/kernel/drivers/pcmcia/tcic.ko): No such device 

 

root@flamepygmy flame # pcic_probe
PCI bridge probe: Cirrus Logic CL 6729 found, 2 sockets. 

root@flamepygmy flame # pcic_probe -m
i82365 

root@flamepygmy flame # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 
AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:0e.0 PCMCIA bridge: Cirrus Logic CL 6729 (rev 07)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4150
01:00.1 Display controller: ATI Technologies Inc: Unknown device 4170 


root@flamepygmy flame # lspci -vvx 

<clipped> 

00:0e.0 PCMCIA bridge: Cirrus Logic CL 6729 (rev 07)
       Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Interrupt: pin A routed to IRQ 17
       Region 0: I/O ports at a400 [disabled] [size=4]
00: 13 10 00 11 80 00 00 04 07 00 05 06 00 00 00 00
10: 01 a4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00 


 --jani; 
