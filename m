Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRC0OQx>; Tue, 27 Mar 2001 09:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRC0OQn>; Tue, 27 Mar 2001 09:16:43 -0500
Received: from [216.29.210.210] ([216.29.210.210]:15876 "HELO
	mail.acetechnologies.net") by vger.kernel.org with SMTP
	id <S131308AbRC0OQb>; Tue, 27 Mar 2001 09:16:31 -0500
Message-ID: <3AC0A0A2.7080706@acetechnologies.net>
Date: Tue, 27 Mar 2001 09:16:02 -0500
From: Jeff McWilliams <Jeff.McWilliams@acetechnologies.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jeff.McWilliams@acetechnologies.net
Subject: 2.4.3-pre8: unresolved symbols loading net modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently built a 2.4.3-pre8 Kernel, because 2.4.2 couldn't properly 
configure the AMI MegaRaid 428 card on the box.  (The MegaRaid card 
works fine under 2.2.13 and 2.4.3-pre8 on the same system).

When attempting to 'modprobe -v pcnet32' on 2.4.3-pre8 I get the 
following results:

homer:/home/jjmcwill# modprobe -v pcnet32
/sbin/insmod /lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o
/lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o: unresolved symbol 
init_etherdev
/lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o: unresolved symbol 
ether_setup
/lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o: unresolved symbol 
unregister_netdev
/lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o: insmod 
/lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o failed
/lib/modules/2.4.3-pre8/kernel/drivers/net/pcnet32.o: insmod pcnet32 failed


The same thing happens with other ethernet drivers compiled as modules.
Ethernet card drivers compiled into the Kernel work fine.

Other modules such as lp, sg, st, vfat, modprobe without error.

The kernel was built on a Debian stable (potato) distribution and 
installed on this box which also runs Debian stable.  I've built 
numerous kernels like this before without incident, so I'm assuming it's 
a Kernel compile/configuration issue. However, Debian stable uses 
modutils 2.3.11, while linux/Documentation/Changes recommends modutils 
2.4.2.  Could this be part of the problem?

Any ideas?
Please cc replies to Jeff.McWilliams@acetechnologies.net if possible.
I browse the Kernel archives daily but dont' subscribe to the list.


Thanks,

Jeff McWilliams
Jeff.McWilliams@acetechnologies.net

