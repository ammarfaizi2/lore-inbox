Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbSI2Ciu>; Sat, 28 Sep 2002 22:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262375AbSI2Ciu>; Sat, 28 Sep 2002 22:38:50 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:20392 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262374AbSI2Cit>;
	Sat, 28 Sep 2002 22:38:49 -0400
Message-ID: <3D9668F8.9090007@candelatech.com>
Date: Sat, 28 Sep 2002 19:44:08 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: APIC error on CPU0: 00(02)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel: 2.4.20-pre8

Machine: dual 1.66Ghz AMD machine, Tyan motherboard 64/66 PCI,
   2 Intel PRO/1000 MT nics,
   1 DFE-570tx 4-port tulip based NIC.
   2 built-in 3-com NICs.

I was running 20Mbps over each of the 4 tulip 100Mbps ports, and nothing over
the gigE ports...  Things ran fine, but I occasionally saw messages like
this:

[root@localhost lanforge]# eth7: (19541091) System Error occured (2)
eth7: (19547299) System Error occured (2)
eth6: (19163408) System Error occured (2)
[root@localhost lanforge]# eth6: (19167052) System Error occured (2)

[root@localhost lanforge]# eth6: (19171414) System Error occured (2)
eth7: (19560749) System Error occured (2)
eth6: (19187463) System Error occured (2)


I mounted another machine across NFS using one of the 3-com ports, and
started this command: tar -xvzf /mnt/blah/kernel.foo.tgz

At this point, the machine starts behaving extremely slowly, but after
a few fits and bursts, it finishes and I can get a response at the prompt
again.

I see more messages similar to those above, and I also see these errors:

[root@localhost lanforge]# eth6: (19773823) System Error occured (2)
APIC error on CPU0: 00(02)
APIC error on CPU1: 00(02)


If anyone has any ideas, or can suggest more debugging information I can
gather to make the problem easier to solve, please let me know!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


