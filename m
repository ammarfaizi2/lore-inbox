Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRJRLZK>; Thu, 18 Oct 2001 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274872AbRJRLZB>; Thu, 18 Oct 2001 07:25:01 -0400
Received: from hermes.dur.ac.uk ([129.234.4.9]:44029 "EHLO hermes.dur.ac.uk")
	by vger.kernel.org with ESMTP id <S274774AbRJRLYs>;
	Thu, 18 Oct 2001 07:24:48 -0400
Date: Thu, 18 Oct 2001 12:14:03 +0100 (BST)
From: Nirmal Bissonauth <Nirmal.Bissonauth@durham.ac.uk>
Reply-To: Nirmal Bissonauth <Nirmal.Bissonauth@durham.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Dlink DL2000 Gigabit Driver problems with Tyan Thunder K7 motherboard
Message-ID: <Pine.GSO.3.95-960729.1011018115012.25557A-100000@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ECS-MailScanner: Found to be clean
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am having problems with the DL2k driver which I which use for the
DGE-550T NIC on the Tyan Thunder K7 760MP Dual Athlon Motherboard.
I am using kernel 2.4.12-ac3. The card does not send or receive any
packets. The switch does not report any activity from the card at all. The
motherboard also has two other 3com 3c980 NICs on board. 

I switched to the ac kernel because I was having the following error in
the first place. (APIC problem I think)

NETDEV WATCHDOG: eth2: transmit timed out
eth2: Transmit timed out, TxStatus 0000. 

The ac kernel cured the above error, but the card still does
transmit any packets. However it correctly detects medium changes.
Plugging and unplugging into the switch.

Auto 1000BaseT, Full duplex.
eth2: Link off
eth2: Link up
Auto 100BaseT, Full duplex.

I have attached system details below.
Any help would be welcome.

Regards
Nirmal Bissonauth

#lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c
(rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d
00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7410 (rev
02)
00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7411
(rev 01)
00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7413 (rev 01)
00:07.4 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7414
(rev 07)
00:09.0 Ethernet controller: D-Link System Inc: Unknown device 4000 (rev
06)
00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 78)
00:10.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC
[Python-T] (rev 78) 

#ifconfig
eth0      Link encap:Ethernet  HWaddr 00:E0:81:03:DA:CF
          inet addr:129.234.8.40  Bcast:129.234.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:377529 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9398 errors:0 dropped:0 overruns:0 carrier:0
          collisions:145 txqueuelen:100
          Interrupt:5 Base address:0x1800
 
eth1      Link encap:Ethernet  HWaddr 00:E0:81:03:DA:D0
          inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:11 Base address:0x1880
 
eth2      Link encap:Ethernet  HWaddr 00:05:5D:00:9C:46
          inet addr:192.168.2.2  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:10 Base address:0x9000
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:13357 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13357 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0




