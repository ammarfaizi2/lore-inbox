Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTACU4w>; Fri, 3 Jan 2003 15:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267660AbTACU4w>; Fri, 3 Jan 2003 15:56:52 -0500
Received: from web41008.mail.yahoo.com ([66.218.93.7]:49300 "HELO
	web41008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267659AbTACU4v>; Fri, 3 Jan 2003 15:56:51 -0500
Message-ID: <20030103210518.4875.qmail@web41008.mail.yahoo.com>
Date: Fri, 3 Jan 2003 13:05:18 -0800 (PST)
From: me athome <any_junk@yahoo.com>
Subject: Dual P4 xeon and linux ethernet bridging 
To: linux-kernel@vger.kernel.org
Cc: any_junk@yahool.com, bridge@math.leidenuniv.nl
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am testing linux bridging with kernel 2.4.20 on a
dual P4 2.4 GHz Xeon and found problematic results.
With a packet size of 128Bytes the maximum throughput
is about 160Mbps (Full duplex). I than tried the same
test with only one P4 and the throughput was the same.
That leads me to believe that the second CPU was not
doing anything during the first test (and indeed the
system and use utilization was always 0%).

At this point I was convinced that the bridge code
cannot use the second cpu so I tried the whole setup
on my dual P3 and on that machine there is a big
difference between one and two cpus enabled. 

I went back to the dual P4 and tried the clean 2.4.20
kernel with Ingo’s irq balance patch
(irqbalance-2.4.20-MRC.patch.txt). The result was the
same although the interrupts were indeed balanced. The
behavior of ‘top’ was much different though, before
after 160Mbps cpu0 would be in 100% system and cpu1
was always 0% while now both cpu0 and cpu1 were at 50%
(and no more).

I tried every combination of hyper treading on/off
with or without the irqbalance patch as well as
acpismp=force.

Am I crazy for expecting the second P4 to do
something?

Ron.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
