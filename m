Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316237AbSEVQQK>; Wed, 22 May 2002 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSEVQQI>; Wed, 22 May 2002 12:16:08 -0400
Received: from mailgate.bridgetrading.com ([62.49.201.178]:13748 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S316237AbSEVQPE>; Wed, 22 May 2002 12:15:04 -0400
Date: Wed, 22 May 2002 17:15:12 +0100
From: Chris <chris@directcommunications.net>
Message-Id: <200205221615.g4MGFCH30271@directcommunications.net>
To: linux-kernel@vger.kernel.org
Subject: It hurts when I shoot myself in the foot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A Cautionary Tale for Silly People
----------------------------------

For the past year now, I've had "ping" problems.

It pauses when it runs, and always returns warnings like so:

"Warning: time of day goes back, taking countermeasures"

I looked _everywhere_ on the net trying to find the problem.

I upgraded the kernel many times.
I upgraded glibc a few times.
I upgraded iputils a few times as well.

Nothing helped.

The clock was sync'd with an atomic clock every night.

Still, I kept getting the problem.

Then while moving log files around today, I noticed that the clock 'second'
didn't move.  Weird.

So I ran this:
  
  while :
  do
    date "+%H:%M:%S"
  done

I got interesting results:

17:05:24
17:05:24
17:05:24
17:05:33
17:05:33
17:05:25
17:05:25
17:05:33
17:05:25
17:05:25

Nice huh!

 Why?  

I looked inside the box and found a Pentium II 400, and a Pentium II 450.

Oddly enough they run together as a 266.

[root@hercules root]#cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 265.915
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 530.84

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 265.915
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 663.55

