Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTH2KP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTH2KP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:15:28 -0400
Received: from aneto.able.es ([212.97.163.22]:46046 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264513AbTH2KPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:15:25 -0400
Date: Fri, 29 Aug 2003 12:15:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829101523.GC5417@werewolf.able.es>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Aug 29, 2003 at 07:35:10 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.29, Jamie Lokier wrote:
> Dear All,
> 
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.
> 

Uh ? So good are my PII ?

werewolf:~> gcc -march=pentium2 -O2 -fomit-frame-pointer -o vm-test vm-test.c
werewolf:~> vm-test
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
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
VM page alias coherency test: all sizes passed

werewolf:~> gcc -DHAVE_SYSV_SHM -march=pentium2 -O2 -fomit-frame-pointer -o vm-test vm-test.c
werewolf:~> vm-test
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
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
VM page alias coherency test: all sizes passed

werewolf:~> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.915
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 799.53

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.915
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 801.17


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
