Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTJBWhr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTJBWhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:37:47 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:1152
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S263527AbTJBWhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:37:39 -0400
Message-Id: <200310021922.h92JMLNI002197@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 - Network doesn't come up.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Oct 2003 13:22:21 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Im trying to run 2.6.0-test6 on top of RH9.
I have progress in some areas but not others.

NETWORKING. is a nogo.

If I compile the driver 3c59x as a module, it gets loaded, but
with the driver in the kernel or as a module, I get the messages
in the messages file (during boot) or when I do a ./network start
from /etc/rc.d/init.d

---

[root@orion init.d]# ./network* restart
Shutting down interface eth0:                              [  OK  ]
Shutting down loopback interface:                          [  OK  ]
Setting network parameters:                                [  OK  ]
Bringing up loopback interface:  arping: socket: Address family not supported 
by protocol
Error, some other host already uses address 127.0.0.1.
                                                           [FAILED]
Bringing up interface eth0:  arping: socket: Address family not supported by 
protocol
Error, some other host already uses address 204.134.2.19.
                                                           [FAILED]

---

Thats the right address for the ethernet card, and NOTHING else is
using it... So what do I need to do?
Ill assume that some config file or script needs to be modified, 
but what/where. 

At the same time I see:

---

[root@orion init.d]# /sbin/ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:01:02:6E:B2:1A  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:57 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:3420 (3.3 Kb)  TX bytes:0 (0.0 b)
          Interrupt:5 Base address:0xb800 

lo        Link encap:Local Loopback  
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

---

Confused.
-- 
                                        Reg.Clemens
                                        reg@dwf.com


