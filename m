Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRIYUgE>; Tue, 25 Sep 2001 16:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273497AbRIYUfy>; Tue, 25 Sep 2001 16:35:54 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:43194 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S273515AbRIYUfo>; Tue, 25 Sep 2001 16:35:44 -0400
Message-ID: <3BB0EAB7.51F85DBE@bigfoot.com>
Date: Tue, 25 Sep 2001 13:36:07 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Newton <newton@unb.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: excessive interrupts on network cards
In-Reply-To: <3BB0E01D@webmail1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I 'think' the number of interrupts being generated for the network traffic I
> monitor, is excessive.  Having talked quikly with Donald Becker, he indicated
> that I should be seeing a little less than the number of RX/TX packets/s on a
> wire, in terms of interrupts/s.  That, however, is not what I am seeing.  I am
> seeing 3 times as many interrupts/s as I am seeing packets/s.

Also check context switches and TX/RX errors.  Reference point as
follows.

rgds,
tim.

*****
10MB file copy, scp v1.68, switched private LAN:

Clocktime:			9 sec
Receiver IRQ/sec:		599
Receiver context switch/sec:	1271
Receiver bytes/IRQ:		1935

NIC driver (both):
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov

Sender: 2.2.20pre6, i586@166MHz
eth1: Lite-On 82c168 PNIC rev 32 at 0x6200, 00:A0:CC:58:F8:CE, IRQ 10.  
eth1:  MII transceiver #1 config 3000 status 782d advertising 01e1.  
eth1: Setting full-duplex based on MII#1 link partner capability of
41e1.  
eth1      Link encap:Ethernet  HWaddr 00:A0:CC:58:F8:CE  
          inet addr:192.168.1.11  Bcast:192.168.1.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2230475 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3785425 errors:3 dropped:0 overruns:3 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:10 Base address:0x6200 

Receiver: 2.2.20pre10, Athlon@850MHz
eth0: Lite-On 82c168 PNIC rev 32 at 0xec00, 00:A0:CC:57:89:93, IRQ 11.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Setting full-duplex based on MII#1 link partner capability of
41e1.
eth0      Link encap:Ethernet  HWaddr 00:A0:CC:57:89:93  
          inet addr:192.168.1.10  Bcast:192.168.1.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2741953 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1606566 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0xec00 

-- 
  |  650.390.9613 - 650.224.7437c
