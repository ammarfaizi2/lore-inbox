Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136513AbREAESu>; Tue, 1 May 2001 00:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136565AbREAESj>; Tue, 1 May 2001 00:18:39 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:16551 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S136513AbREAESa>; Tue, 1 May 2001 00:18:30 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 30 Apr 2001 21:18:10 -0700
Message-Id: <200105010418.VAA10295@adam.yggdrasil.com>
To: riel@conectiva.com.br
Subject: Re: 2.4.4 sluggish under fork load
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The fact that 2.4.4 gives the whole timeslice to the child
>is just bogus to begin with.

        I only did that because I could not find another way
to make the child run first that worked in practice.  I tried
other things before that.  Since Peter Osterlund's SCHED_YIELD
thing works, we no longer have to give all of the CPU to the
child.  The scheduler time slices are currently enormous, so as
long as the child gets even one clock tick before the parent runs,
it should reach the exec() if that is its plan.  1 tick = 10ms = 10
million cycles on a 1GHz CPU, which should be enough time to encrypt
my /boot/vmlinux in twofish if it's in RAM.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
