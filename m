Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBNLAq>; Wed, 14 Feb 2001 06:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbRBNLAh>; Wed, 14 Feb 2001 06:00:37 -0500
Received: from f133.law9.hotmail.com ([64.4.9.133]:39436 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129197AbRBNLAX>;
	Wed, 14 Feb 2001 06:00:23 -0500
X-Originating-IP: [212.58.173.129]
From: "Jonathan Brugge" <jonathan_brugge@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem: NIC doesn't work anymore, SIOCIFADDR-errors
Date: Wed, 14 Feb 2001 12:00:16 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1331qdiixjnzi95Hfq000043f7@hotmail.com>
X-OriginalArrivalTime: 14 Feb 2001 11:00:16.0863 (UTC) FILETIME=[50484EF0:01C09675]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a problem with my network. I can't get the card running, though it 
worked perfectly before. Below what happens and the errors I get:
-----------------------------------
odysseus:/# ifconfig

// No active devices found.

odysseus:/# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:20:18:80:B0:95
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:9 Base address:0xde00
lo        Link encap:Local Loopback
          LOOPBACK  MTU:16192  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

// It finds eth0 and the loopback, they aren't active.

odysseus:/# ifdown eth0
ifdown: interface eth0 not configured

// Just what should happen...

odysseus:/# ifup eth0
SIOCSIFADDR: Bad file descriptor
eth0: unknown interface: Bad file descriptor
SIOCSIFNETMASK: Bad file descriptor
eth0: unknown interface: Bad file descriptor
odysseus:/# ifup lo
SIOCSIFADDR: Bad file descriptor
lo: unknown interface: Bad file descriptor
lo: unknown interface: Bad file descriptor
odysseus:/#

// This is where I loose the track. These seem to be kernel-messages, but I 
can't find them in the kernel-source (looked in the kernel-subdirectory and 
the net-subdirectory).
There are some other SIOC*-texts, but no SIOCSIFADDR or SIOCIFNETMASK in 
those dirs.
The problem appeared after booting, everything worked perfect before.
Nothing has changed that could affect network or ethernet-card, afaik.
It's not hardware-related: the card still works in Win98SE and after placing 
another card (same type), the problem still persists.
I did a kernel-recompile, but that hasn't solved it. Still the same error.
I'm running 2.4.0-prerelease.
The card is a PCI-card. It has a Winbond W89C940F-chip on it and the kernel 
uses NE2k-drivers, I think.
I did a fsck on my HD, which didn't solve it either.
The light on the card blinks all the time, like there's something wrong. I 
haven't looked whether it does so in Windows too.
Ifup / Ifdown version: 0.6.4-3
No messages in /var/log[syslog|messages|kern.log|ksymoops/*] about this.

Anyone who can tell me what's going on here?

Jonathan Brugge
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

