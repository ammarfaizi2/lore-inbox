Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbQKIAR7>; Wed, 8 Nov 2000 19:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKIARt>; Wed, 8 Nov 2000 19:17:49 -0500
Received: from proxy2.ba.best.com ([206.184.139.14]:41736 "EHLO
	proxy2.ba.best.com") by vger.kernel.org with ESMTP
	id <S129324AbQKIARd>; Wed, 8 Nov 2000 19:17:33 -0500
Message-ID: <3A09EC6F.C87A7729@best.com>
Date: Wed, 08 Nov 2000 16:14:39 -0800
From: Robert Lynch <rmlynch@best.com>
Reply-To: rmlynch@best.com
Organization: Carpe per diem
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Spew from test11-pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No oops, but right after I installed test11-pre1, then tried to
access a Windows box as a VNC client, this message started
getting continuously dumped by syslog:
===
...
Nov  8 15:32:01 ives kernel: eth0: card reports no RX buffers.
Nov  8 15:32:04 ives kernel: eth0: card reports no resources.
Nov  8 15:32:04 ives kernel: eth0: card reports no RX buffers.
Nov  8 15:32:04 ives kernel: eth0: card reports no resources.
Nov  8 15:32:05 ives kernel: eth0: card reports no RX
buffers.                  
...
Nov  8 15:36:18 ives kernel: eth0: card reports no resources.
Nov  8 15:36:35 ives kernel: eth0: card reports no RX buffers.
Nov  8 15:36:49 ives kernel: SysRq: Emergency Sync
Nov  8 15:36:49 ives kernel: Syncing device 03:03 ... OK 
..
===
eth0 seems OK, I regularly check ifconfig after installing a new
kernel:
===
$ /sbin/ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:D0:B7:7A:00:B0
          inet addr:172.16.1.3  Bcast:172.16.1.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:9
...
===                  
Doing a Yahoo search it seems this was previously reported
eepro100 bug, which appears to have resurfaced.

FWIW, Bob L.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
