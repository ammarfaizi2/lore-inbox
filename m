Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbRHaXMA>; Fri, 31 Aug 2001 19:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRHaXLv>; Fri, 31 Aug 2001 19:11:51 -0400
Received: from web14206.mail.yahoo.com ([216.136.173.70]:22798 "HELO
	web14206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269421AbRHaXLi>; Fri, 31 Aug 2001 19:11:38 -0400
Message-ID: <20010831231156.90554.qmail@web14206.mail.yahoo.com>
Date: Fri, 31 Aug 2001 16:11:56 -0700 (PDT)
From: java programmer <javadesigner@yahoo.com>
Subject: SMP, APIC and networking issues...
To: linux-kernel@vger.kernel.org
In-Reply-To: <002801c13270$86592680$0201a8c0@home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

There have been some recent posts regarding some
SMP/register corruption bugs.

Searching the archives, there have also been some
reports with both 3com and intel ethernet cards
hanging after an N amount of time, where N = a couple
of days to 2 weeks. That is, the nic's will behave
nicely for some time and then totally hang - are not 
even pingable. This happens on SMP machines and is
believed to be caused by some APIC/interrupt issues.

I have seen the exact same behavior on 2.4.7 with
a intel pro/100 ethernet 64 bit PCI nic on a SMP
intel chipset. Stress testing and transferrring 
Gbytes of data thru the nic works fine after the 
machine is rebooted but after say 3 days, the 
card just hangs. (this happens with both intel 
supplied and kernel supplied drivers, e100, eepro100)

After the hang, logging in via the console and
saying ifconfig (for eth1, I have also blacked
out the IP address) shows the following:

eth1      Link encap:Ethernet  HWaddr
00:50:8B:E3:AA:B5
inet addr:x.x.x.x  
Bcast:66.37.140.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500 
Metric:1
          RX packets:6232292 errors:0 dropped:0
overruns:0 frame:0
          TX packets:7098591 errors:0 dropped:0
overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:2693585563 (2568.8 Mb)  TX
bytes:2786888257 (2657.7 Mb)
          Interrupt:15 Base address:0x4000

The supposed trick is to boot with a  "noapic" 
option, since this is believed to be a APIC issue, 
not a driver issue (as mentioned, this problem 
has been seen for both 3com and intel cards).

Is "noapic" still the recommended approach for SMP
kernels or is it advisable to use 2.4.9 to solve 
this specific issue ?

Best regards,

javadesigner



__________________________________________________
Do You Yahoo!?
Get email alerts & NEW webcam video instant messaging with Yahoo! Messenger
http://im.yahoo.com
