Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272828AbRIIRHr>; Sun, 9 Sep 2001 13:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272819AbRIIRHh>; Sun, 9 Sep 2001 13:07:37 -0400
Received: from arioch.oche.de ([194.94.252.126]:42508 "HELO arioch.oche.de")
	by vger.kernel.org with SMTP id <S272872AbRIIRH2>;
	Sun, 9 Sep 2001 13:07:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Athlon/K7-Opimisation problems
Mail-Copies-To: never
From: Carsten Leonhardt <leo@debian.org>
Date: 09 Sep 2001 19:07:39 +0200
Message-ID: <87g09w70o4.fsf@cymoril.oche.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's my data regarding the K7 optimisation problem.

Until last week I had a 1GHz Athlon with 133MHz FSB. I then bought a
1.4GHz Athlon, again 133MHz FSB.

I never had any problems with the 1GHz processor, but as soon as I
stuck the 1.4GHz processor in, the kernel oopsed itself to
oblivion. (That was with kernel 2.4.5-ac5, approximately)

I also noticed that the computer booted ok with the Debian
bootfloppies, which use a kernel compiled for i386. So after several
kernel compile/boot cycles, I found out that I had to disable K7
optimisation to make the system boot again.

The mainboard is a Tyan Trinity KT-A (S2390B) with a VIA KT133A
chipset.

After reading here that it may be the PSU, I upgraded my 300W PSU to a
431W Enermax, which made no difference.

The only difference I can make out between the working and the
non-working CPU is the internal clockspeed of the CPU and the
stepping (old: 2, new: 4).

Appended is the output of /proc/cpuinfo (I sold the old CPU, but the
guy who bought it sent me the output).

I really hope this helps someone. If anyone needs any more data, or
wants me to test something, contact me.


Yours,
 leo



Old CPU:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1012.530
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr 6 mce cx8 sep mtrr pge 14 cmov
pat 17 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 2018.51

New CPU:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1400.098
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2791.83
