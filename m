Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVHVVJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVHVVJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVHVVJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:09:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35307 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751206AbVHVVJQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:09:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Y0zVNkVnXRgMxioGAWsqqc+MCyK7nkWz9y4nIprkIzVAGShWEhgpHg7+LXLJeUN6fJVTVzqTpOWW0MIg4jWIeUKg7uKd+BFQgw5PE5IdW/cmI3D23RTBLoW7WZKiQwOHqd4o2VM5jGLYViJEQJreSGUnJFMF655GptKdnT/m8sk=
Message-ID: <5a2cf1f605082208292b0f3874@mail.gmail.com>
Date: Mon, 22 Aug 2005 17:29:22 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: thousands of "tulip_stop_rxtx() failed" errors
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using kernel 2.6.11 on Mandriva LE 2005, I am seeing a lot of tulip
errors in my logs:
   0000:02:09.0: tulip_stop_rxtx() failed

It doesn't seem to impact the performance, although it fills up my logs. 

The card is connected to the ADSL modem. Any idea as to what could be
causing this?
Bad cable?

The box is remote so I cannot do much with hardware right now.

Cheers,

Jerome


> ifconfig eth0
eth0      Lien encap:Ethernet  HWaddr 00:80:AD:20:1D:66  
          adr inet6: fe80::280:adff:fe20:1d66/64 Scope:Lien
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:242073 errors:4010 dropped:0 overruns:0 frame:0
          TX packets:231702 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 lg file transmission:1000 
          RX bytes:71151194 (67.8 Mb)  TX bytes:48721547 (46.4 Mb)
          Interruption:3 Adresse de base:0xd800 

> uname -a
Linux localhost 2.6.11-12mdk-i586-up-1GB #1 Mon Jun 27 21:49:58 MDT
2005 i686 Pentium III (Coppermine) unknown GNU/Linux

> cat /proc/interrupts 
           CPU0       
  0:    9415381          XT-PIC  timer
  1:       6557          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:     602974          XT-PIC  eth0
  8:          1          XT-PIC  rtc
  9:    3727677          XT-PIC  Ensoniq AudioPCI
 10:         66          XT-PIC  uhci_hcd
 11:     790910          XT-PIC  r128@pci:0000:01:00.0
 12:     482453          XT-PIC  i8042
 14:     133760          XT-PIC  ide0
 15:      11898          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

> lspci      
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge
and Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 82815 815 Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 02)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128
PF/PRO AGP 4x TMDS
02:09.0 Ethernet controller: Davicom Semiconductor, Inc. 21x4x
DEC-Tulip compatible 10/100 Ethernet (rev 31)
02:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46)
02:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)



02:09.0 Ethernet controller: Davicom Semiconductor, Inc. 21x4x
DEC-Tulip compatible 10/100 Ethernet (rev 31)
 Subsystem: Unknown device 4554:434e
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64 (5000ns min, 10000ns max)
 Interrupt: pin A routed to IRQ 3
 Region 0: I/O ports at d800 [size=256]
 Region 1: Memory at ff9ffc00 (32-bit, non-prefetchable) [size=256]
 Expansion ROM at ff980000 [disabled] [size=256K]
 Capabilities: [50] Power Management version 2
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

> mii-tool -v
eth0: negotiated 100baseTx-FD, link ok
  product info: vendor 00:60:6e, model 4 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
