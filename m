Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTH2KER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTH2KER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:04:17 -0400
Received: from village.ehouse.ru ([193.111.92.18]:55826 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S264490AbTH2KEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:04:07 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Date: Fri, 29 Aug 2003 14:04:12 +0400
User-Agent: KMail/1.5
References: <20030829053510.GA12663@mail.jlokier.co.uk>
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308291404.12201.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On Friday 29 August 2003 09:35, Jamie Lokier wrote:
> Dear All,
>
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.
rathamahata@test rathamahata $ gcc -march=athlon-xp -mcpu=athlon-xp -fomit-frame-pointer -O2 -o test test.c
rathamahata@test rathamahata $ time ./test
Test separation: 4096 bytes: FAIL - too slow
Test separation: 8192 bytes: FAIL - too slow
Test separation: 16384 bytes: FAIL - too slow
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 32768 (8 pages)

real	0m0.097s
user	0m0.091s
sys	0m0.006s
rathamahata@test rathamahata $ cat /proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) MP 2200+
stepping	: 0
cpu MHz		: 1800.967
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3538.94

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) Processor
stepping	: 0
cpu MHz		: 1800.967
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3596.28


-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
