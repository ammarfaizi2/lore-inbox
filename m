Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAVPLn>; Mon, 22 Jan 2001 10:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAVPLe>; Mon, 22 Jan 2001 10:11:34 -0500
Received: from thor.lule.ava.se ([195.100.138.33]:22289 "EHLO thor.lule.ava.se")
	by vger.kernel.org with ESMTP id <S129835AbRAVPLY>;
	Mon, 22 Jan 2001 10:11:24 -0500
Date: Mon, 22 Jan 2001 16:11:21 +0100 (CET)
From: Listuser AVA System <listuser@thor.lule.ava.se>
To: linux-kernel@vger.kernel.org
Subject: Driver crash 2.4.0 nicstar.c
Message-ID: <Pine.LNX.4.10.10101221606240.15879-100000@thor.lule.ava.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled the nicstar ATM nic driver.
The following happens :

swapper(1): Kernel Bug 1
pc = [<fffffc0000341df0>] ra = [<fffffc00003c2154>] ps = 0000
v0 = 0000000000000000 t0 = 0000000000000000 t1 = fffffc0000513c60
t2 = 0000000000000000 t3 = 0000000000000000 t4 = fffffc87002b00c8
t5 = 0000000000000000 t6 = 0000000000000000 t7 = fffffc0001cd4000
a0 = 0000000000000000 a1 = 0000000000000000 a2 = fffffc0001cd4000
a3 = fffffc0001cd7cc0 a4 = 0000000000000000 a5 = 0000000000000000
t8 = 0000000000000000 t9 = fffffc0000412448 t10= 0000000000000007
t11= 000000000000000a pv = fffffc0000341ce0 at = 0000000000000000
gp = fffffc0000534ec8 sp = fffffc0001cd7d90
Code: 47ff0400 or zero,zero,v0
 c3e00006 br .+28
 40431402 addq t1,24,t1
 a4220000 ldq t0,0(t1)
 f43fffcd bge t0,.-200
 00000081 call_pal 129
*47ff0400 or zero,zero,v0
 2fe00000 ldq_u zero,0(v0)

Trace:3c2154 372f68 310000 310080 310080 310098 310630 310080 310604
3105d8 310604

Kernel panic: Attempted to kill init!

I see there are a lot of unsigned long in the driver and I suspect this
may be the cause.
Can someone tell me what happens ? 
Oh, right, it's a ev56a on a ruffian board, exact kernel is : 2.4.0-ac6
I hope I typed the oops message correctly, since no drive was mounted as
it happened. 


Have a nice day.
//Peter Hellman



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
