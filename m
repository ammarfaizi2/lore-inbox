Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317098AbSEXGTV>; Fri, 24 May 2002 02:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSEXGTV>; Fri, 24 May 2002 02:19:21 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:62084 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317098AbSEXGTU>;
	Fri, 24 May 2002 02:19:20 -0400
Message-ID: <3CEDDB66.2030106@candelatech.com>
Date: Thu, 23 May 2002 23:19:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Donald Becker <becker@scyld.com>
Subject: DFE-580tx and redhat 7.3's sundance driver does not work.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like D-Link obsoleted my trusty DFE-570tx, and replaced it
with the DFE-580tx.  I got one of these cards to try out on a
new RH 7.3 (2.4.18-3) kernel.  The sundance driver was chosen
by the installer.

It creates the interfaces, but they show totally bogus counters.
(there is no ethernet activity, or not supposed to be any)

MAC looks bogus too.

Any suggestions are welcome!

Thanks,
Ben



eth5      Link encap:Ethernet  HWaddr 6F:EF:6F:EF:6F:EF
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:123555840 errors:0 dropped:480629 overruns:0 frame:0
           TX packets:131444993 errors:0 dropped:0 overruns:0 carrier:0
           collisions:965280 txqueuelen:100
           RX bytes:1473161754 (1404.9 Mb)  TX bytes:1473622273 (1405.3 Mb)
           Interrupt:11 Base address:0x8000

[root@localhost root]# mii-tool -vv eth5
eth5: 10 Mbit, half duplex, no link
   registers for MII PHY 1:
     0000 0000 0000 0000 0000 0000 0000 0000
     0000 0000 0000 0000 0000 0000 0000 0000
     0000 0000 0000 0000 0000 0000 0000 0000
     0000 0000 0000 0000 0000 0000 0000 0000
   product info: vendor 00:00:00, model 0 rev 0
   basic mode:   10 Mbit, half duplex
   basic status: no link
   capabilities:
   advertising:

sundance.c:v1.01b 17-Jan-2002  Written by Donald Becker
   http://www.scyld.com/network/sundance.html
eth5: D-Link DFE-580TX 4 port Server Adapter at 0xce8a8000, 6f:ef:6f:ef:6f:ef, IRQ 11.
eth5: No MII transceiver found!, ASIC status f000ef6f
eth6: D-Link DFE-580TX 4 port Server Adapter at 0xce8aa000, 6f:ef:6f:ef:6f:ef, IRQ 7.
eth6: No MII transceiver found!, ASIC status 7fef6f
eth7: D-Link DFE-580TX 4 port Server Adapter at 0xce8ac000, 6f:ef:6f:ef:6f:ef, IRQ 5.
eth7: No MII transceiver found!, ASIC status 7fef6f
eth8: D-Link DFE-580TX 4 port Server Adapter at 0xce8ae000, 6f:ef:6f:ef:6f:ef, IRQ 10.
eth8: No MII transceiver found!, ASIC status 7fef6f


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


