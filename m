Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbTCOJLS>; Sat, 15 Mar 2003 04:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTCOJLS>; Sat, 15 Mar 2003 04:11:18 -0500
Received: from [196.41.29.142] ([196.41.29.142]:26364 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S261352AbTCOJLO>; Sat, 15 Mar 2003 04:11:14 -0500
Subject: Re: Newbie with SiS 900 NIC driver, SuSE 8.1 and Fujitsu-Siemens
	Celvin EasyPC.
From: Martin Schlemmer <azarah@gentoo.org>
To: durant@cbn.net.id
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <3E72E4CE.1070005@cbn.net.id>
References: <3E72E4CE.1070005@cbn.net.id>
Content-Type: text/plain
Organization: 
Message-Id: <1047719971.3504.143.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 15 Mar 2003 11:19:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 10:31, Brian Durant wrote:
> Please personally CC the answers/comments posted to the list in response 
> to my posting, as I am not a list member. I have tried getting the SiS 
> 900 driver to run on SuSE 7.3, (and now) 8.1, Mandrake 8, 8.1, 9, Debian 
> 3 rev.1 as well as running the latest Knoppix, none of which has been 
> successful. Being a newbie and having only an interest in this one issue 
> that I have never been able to resolve, I really don't belong on the 
> list either. However, I believe that there is either a bug in the driver 
> or my configuration is not supported. Either way, I would like to get 
> the issue cleared up.
> 
> Anyway, to the issue at hand. There is a Fujitsu-Siemens Celvin EasyPC 
> connected to my home WAN/LAN that I have been trying to get to work with 
> the SiS 900 driver. The box has a SiS 900 NIC built into a Biostar 
> motherboard and uses an Award BIOS. The WAN/LAN consists of 4 computers 
> connected to a LinkSys router and a 3 Com cable modem. All other 
> computers are able to connect to the Internet through auto DHCP, 
> including one that is a dual boot Win2k Pro and SuSE 8.1 box. The Celvin 
> is neither able to connect through auto DHCP or with a static IP 
> address. I have checked the physical connection using a USB to Ethernet 
> adapter and Knoppix, so I know the problem doesn't lie there. The SiS 
> 900 NIC itself, works fine under Win 98 SE. This seems to me to rule out 
> a number of things. Using SuSE 8.1, I have tried:
> 

This box I have at work is an Asus CUSI-M with sis900 NIC.  Works
just dandy.

There are no real caveats I know of, so maybe just include relevant
info, like full dmesg, lspci, kernel version. output of ifconfig, etc.

Here is mine .. maybe you spot something.  Also, might try a bios update
...

----------------- relevant dmesg -------------------------
sis900.c: v1.08.06 9/24/2002
PCI: Found IRQ 10 for device 00:01.1
PCI: Sharing IRQ 10 with 00:05.0
eth0: SiS 900 Internal MII PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 10, 00:e0:18:27:03:cc.
eth0: Media Link On 100mbps full-duplex 
----------------------------------------------------------

----------------------------------------------------------
workshop module-init-tools-0.9.10 # lsmod | grep sis
sis                    47904   1 
sis900                 12236   1 
workshop module-init-tools-0.9.10 # lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 21)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 83)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS630 GUI Accelerator+3D (rev 21)
workshop module-init-tools-0.9.10 # ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:E0:18:27:03:CC  
          inet addr:10.0.4.50  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:159732 errors:0 dropped:0 overruns:0 frame:0
          TX packets:137561 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:74381620 (70.9 Mb)  TX bytes:23243550 (22.1 Mb)
          Interrupt:10 Base address:0xd400 

workshop module-init-tools-0.9.10 # uname -a
Linux workshop 2.4.20-win4lin-r1 #2 Fri Feb 28 10:51:31 SAST 2003 i686
Celeron (Coppermine) GenuineIntel GNU/Linux
workshop module-init-tools-0.9.10 # 
----------------------------------------------------------


Regards,

-- 
Martin Schlemmer


