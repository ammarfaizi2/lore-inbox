Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbQK3X1g>; Thu, 30 Nov 2000 18:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130744AbQK3X11>; Thu, 30 Nov 2000 18:27:27 -0500
Received: from w034.z064000154.lax-ca.dsl.cnc.net ([64.0.154.34]:6407 "EHLO
	gangsta.e247inc.com") by vger.kernel.org with ESMTP
	id <S129860AbQK3X1R>; Thu, 30 Nov 2000 18:27:17 -0500
Message-ID: <3A26E8E9.4B157465@e247inc.com>
Date: Thu, 30 Nov 2000 15:55:21 -0800
From: Scott Bisker <scott@e247inc.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Arping loopback question.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

Quick question here about an arping loopback adaptor.  I've set lo to
noarp, and I've set /proc/sys/net/ipv4/conf/lo/hidden to 1.  The
interface still arps for lo:0.  I'm using Foundry  server irons, and I
need to set the loopback interface in order for load balancing to work
properly.

After I clear the arp tables on my switches, and then ping the loopback,
I get the coresponding arp entry

sh arp
...
192.168.5.100    00:A0:CC:73:3F:4D
...


Here's the output from ifconfig.

eth1      Link encap:Ethernet  HWaddr 00:A0:CC:73:3F:4D
          inet addr:192.168.5.90  Bcast:192.168.5.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:173056 errors:0 dropped:0 overruns:0 frame:0
          TX packets:132075 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:18

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING NOARP  MTU:3924  Metric:1
          RX packets:33536 errors:0 dropped:0 overruns:0 frame:0
          TX packets:33536 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

lo:0      Link encap:Local Loopback
          inet addr:192.168.5.100  Mask:255.255.255.255
          UP LOOPBACK RUNNING NOARP  MTU:3924  Metric:1

I'm using 2.2.18pre22.  eth1 is NetGear Gig-E adapter compiled into the
kernel.  eth0 is an eepro100 compiled into the kernel.

Any ideas here?

Thanks in advance.

-sb

Scott Bisker
Lead System Engineer
e24/7 Inc.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
