Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280628AbRKNPIu>; Wed, 14 Nov 2001 10:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280629AbRKNPIk>; Wed, 14 Nov 2001 10:08:40 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:45030 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S280628AbRKNPI1>; Wed, 14 Nov 2001 10:08:27 -0500
Date: Wed, 14 Nov 2001 15:08:25 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
In-Reply-To: <3BF285D7.8F5AAB6E@redhat.com>
Message-ID: <Pine.LNX.4.33.0111141502110.8473-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:55 -0000 Arjan van de Ven wrote:

>Alastair Stevens wrote:
>>
>> Hi folks - I'm having real problems getting our new dual CPU server
>> going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP chipset, with
>
>Ehm you know that XP cpu's don't support SMP configuration ?

I hope they do; I've just set up a very similar beast (looks like the same
mobo and same CPUs). Is the RAM "registered" ECC? Are your CPUs the same
stepping? One problem we were bitten by was the Radeon DRI, so we disabled
it (in XF86Config-4) and it now seems to at least boot into X. However,
it's not any faster than a dual PIII (1GHz) at the task it's meant to
perform :( both CPUs report 75% usage, and vmstat 1 doesn't show the IO
systems being slugged. Very strange. We're wondering if we've hit memory
bandwidth as the tasks involve some hard sums with big matrices.

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1526.519
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3047.42

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1526.519
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3047.42


