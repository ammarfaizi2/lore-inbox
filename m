Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTH2Th2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTH2Th2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:37:28 -0400
Received: from pD9532865.dip.t-dialin.net ([217.83.40.101]:18187 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S261756AbTH2ThY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:37:24 -0400
Date: Fri, 29 Aug 2003 19:37:18 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829193718.A19684@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Aug 29, 2003 at 06:35:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:35:10AM +0100, Jamie Lokier wrote:
> Dear All,
> 
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.
 

Dual Alpha ev6:


ds20:~/src/cachetest$ ./doit 
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
VM page alias coherency test: minimum fast spacing: 32768 (4 pages)

real    0m4.148s
user    0m4.029s
sys     0m0.075s
cpu                     : Alpha
cpu model               : EV6
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Tsunami
system variation        : Goldrush
system revision         : 0
system serial number    : ay91560403
cycle frequency [Hz]    : 500000000 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 998.56
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer DS20 500 MHz
cpus detected           : 2
cpus active             : 2
cpu active mask         : 0000000000000003



Single Alpha ev4 (AXPpci33):

Marvin:~/src/cachetest$ ./doit 
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

real    0m1.442s
user    0m0.853s
sys     0m0.471s
cpu                     : Alpha
cpu model               : LCA4
cpu variation           : -4294967301
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : Noname
system variation        : 0
system revision         : 0
system serial number    : MILO-2.2-17
cycle frequency [Hz]    : 166868457 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 320.40
kernel unaligned acc    : 56014443 (pc=fffffc0000ab65a4,va=fffffc0000b99105)
user unaligned acc      : 2695 (pc=2000031ff90,va=11fffef26)
platform string         : N/A
cpus detected           : 0




ordinary Pentium II:


bash-2.03$ ./doit           
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

real    0m0.342s
user    0m0.290s
sys     0m0.030s
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 300.691
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips        : 599.65




bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
