Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSJZMEz>; Sat, 26 Oct 2002 08:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSJZMEz>; Sat, 26 Oct 2002 08:04:55 -0400
Received: from a127-0-0-1.xs4all.nl ([213.84.70.4]:55044 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id <S262084AbSJZMEy>; Sat, 26 Oct 2002 08:04:54 -0400
Date: Sat, 26 Oct 2002 14:11:09 +0200
From: Jurjen Oskam <jurjen@quadpro.stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021026121054.GA1985@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:

> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?

joskam@hobbes:~> gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.3/specs
gcc version 2.95.3 20010315 (SuSE)
joskam@hobbes:~> gcc athlon.c
joskam@hobbes:~> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 19425 cycles per page
copy_page function '2.4 non MMX'         took 22285 cycles per page
copy_page function '2.4 MMX fallback'    took 21698 cycles per page
copy_page function '2.4 MMX version'     took 19587 cycles per page
copy_page function 'faster_copy'         took 11082 cycles per page
copy_page function 'even_faster'         took 11203 cycles per page
copy_page function 'no_prefetch'         took 7140 cycles per page
joskam@hobbes:~> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 19463 cycles per page
copy_page function '2.4 non MMX'         took 22378 cycles per page
copy_page function '2.4 MMX fallback'    took 21863 cycles per page
copy_page function '2.4 MMX version'     took 19558 cycles per page
copy_page function 'faster_copy'         took 11036 cycles per page
copy_page function 'even_faster'         took 11292 cycles per page
copy_page function 'no_prefetch'         took 7152 cycles per page
joskam@hobbes:~> ./a.out
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 21519 cycles per page
copy_page function '2.4 non MMX'         took 22224 cycles per page
copy_page function '2.4 MMX fallback'    took 21707 cycles per page
copy_page function '2.4 MMX version'     took 19399 cycles per page
copy_page function 'faster_copy'         took 11002 cycles per page
copy_page function 'even_faster'         took 11211 cycles per page
copy_page function 'no_prefetch'         took 7147 cycles per page
joskam@hobbes:~> cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP1700+
stepping        : 2
cpu MHz         : 1477.400
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2949.12

This was run on an Asus A7V266-E motherboard with a KT266A chipset, with
512 MB of DDR SDRAM.


-- 
Jurjen Oskam

PGP Key available at http://www.stupendous.org/
