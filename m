Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVCXPGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVCXPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVCXPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:06:09 -0500
Received: from bay10-f3.bay10.hotmail.com ([64.4.37.3]:43627 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262458AbVCXPFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:05:50 -0500
Message-ID: <BAY10-F346FCB94AAE3D59115210D6400@phx.gbl>
X-Originating-IP: [61.246.101.86]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel crash problem and Madwifi
Date: Thu, 24 Mar 2005 20:35:49 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 24 Mar 2005 15:05:49.0559 (UTC) FILETIME=[F6DE9070:01C53082]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

kernel version:2.4.29
board :net4521
wireless card : Atheros-5212
diriver  madwifi-cvs-current.tar.bz2(v 1.30 2005/02/22)

I built the customized image  from 2.4.29 and  booted from this image

The following sequence restarts the board

insmod wlan
insmod wlan_wep
insmod ath_rate-onoe
insmod ath_hal
insmod ath_pci xchanmode=0
ifup ath0
ifdown ath0
The board and Atheros work fine up to this point. After this once we give
the
command

ifup ath0

the system printed  error message
___________________________________________________________________________
Unable to handle kernel paging request at virtual address e49aac30
printing eip:
c4878019
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c4878019>]    Tainted: P
EFLAGS: 00010246
eax: 0804ab74   ebx: c3d76000   ecx: 00000000   edx: 00000000
esi: c3d76000   edi: c3d76348   ebp: c3d76000   esp: c3c09ed0
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 116, stackpage=c3c09000)
Stack: 0804ab74 c3d7615c 00000000 c3c54000 0804ab74 c3d76000 00000000 
00001043
      00000000 c01a5484 c3d76000 c3d76000 00001002 c01a66c1 c3d76000 
c3c09f54
      c3c09f59 c3c2b144 bffffa10 c01dd219 c3d76000 00001043 00000000 
00000000
Call Trace:    [<c01a5484>] [<c01a66c1>] [<c01dd219>] [<c019eeca>] 
[<c014163e>]
[<c0106dc3>]

Code: 8b 3c 85 60 fe 87 c4 57 55 68 20 f3 87 c4 e8 34 d5 89 fb c7
_______________________________________________________________________________
bash-2.05a#
my dmesg output
___________________________________________________________________________________
bash-2.05a# dmesg
BIOS-provided physical RAM map:
BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
BIOS-e801: 0000000000100000 - 0000000004000000 (usable)
64MB LOWMEM available.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.

hda: hda1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hda: hda1
hda: hda1
Freeing unused kernel memory: 260k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: busy inodes on changed media.
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
originally by Donald Becker <becker@scyld.com>
http://www.scyld.com/network/natsemi.html
2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
eth%d: EEPROM did not reload in 20000 usec.
eth0: NatSemi DP8381[56] at 0xc4809000, 00:00:24:c2:0e:f8, IRQ 5.
eth%d: EEPROM did not reload in 20000 usec.
eth1: NatSemi DP8381[56] at 0xc480b000, 00:00:24:c2:0e:f9, IRQ 9.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (512 buckets, 4096 max) - 288 bytes per conntrack
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
wlan: 0.8.4.5 (EXPERIMENTAL)
ath_hal: 0.9.14.9 (AR5210, AR5211, AR5212, RF5111, RF5112, RF2413)
ath_rate_onoe: 1.0
ath_pci: 0.9.4.12 (EXPERIMENTAL)
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 
36Mbps 48Mbps 54Mbps
ath0: turbo rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: mac 5.6 phy 4.1 5ghz radio 1.7 2ghz radio 2.3
ath0: 802.11 address: 00:02:6f:20:f9:ae
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 1 for WME_AC_BK traffic
ath0: Use hw queue 2 for WME_AC_VI traffic
ath0: Use hw queue 3 for WME_AC_VO traffic
ath0: Atheros 5212: mem=0xa0000000, irq=10
Unable to handle kernel paging request at virtual address e49aac30
printing eip:
c4878019
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c4878019>]    Tainted: P
EFLAGS: 00010246
eax: 0804ab74   ebx: c3d76000   ecx: 00000000   edx: 00000000
esi: c3d76000   edi: c3d76348   ebp: c3d76000   esp: c3c09ed0
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 116, stackpage=c3c09000)
Stack: 0804ab74 c3d7615c 00000000 c3c54000 0804ab74 c3d76000 00000000 
00001043
      00000000 c01a5484 c3d76000 c3d76000 00001002 c01a66c1 c3d76000 
c3c09f54
      c3c09f59 c3c2b144 bffffa10 c01dd219 c3d76000 00001043 00000000 
00000000
Call Trace:    [<c01a5484>] [<c01a66c1>] [<c01dd219>] [<c019eeca>] 
[<c014163e>]
[<c0106dc3>]

Code: 8b 3c 85 60 fe 87 c4 57 55 68 20 f3 87 c4 e8 34 d5 89 fb c7
__________________________________________________________________________________
Has any one faced this problem before?

What could be the possible cause?


Thanks in advance
Govind

_________________________________________________________________
News, views and gossip. http://www.msn.co.in/Cinema/ Get it all at MSN 
Cinema!

