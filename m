Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbREBJtp>; Wed, 2 May 2001 05:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132516AbREBJtf>; Wed, 2 May 2001 05:49:35 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:26358 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132503AbREBJtZ>; Wed, 2 May 2001 05:49:25 -0400
Date: Wed, 2 May 2001 11:49:23 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Tom Holroyd <tomh@po.crl.go.jp>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (2000) Assume 1024.
Message-ID: <20010502114923.I3305@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.30.0105021348480.27862-100000@holly.crl.go.jp> <200105020642.f426gww379046@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200105020642.f426gww379046@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Wed, May 02, 2001 at 02:42:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 02:42:58AM -0400, Albert D. Cahalan wrote:
> > In .../fs/proc/proc_misc.c:kstat_read_proc(), the cpu line is being
> > computed by:
> > 
> >         len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
> >                       jif * smp_num_cpus - (user + nice + system));
> 
> This is pretty bogus. The idle time can run _backwards_ on an SMP
> system. What is "top" supposed to do with that, print a negative
> number for %idle time? (some versions do, while others truncate
> at zero or wrap around to 4 billion -- pick your poison)

Just a "me too". I've seen this with one or two days uptime
already. An idle of more than 40.000%. May be this means, that
the machine was _very_ bored and needs my attention ;-)

cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 851.987
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1697.38

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 851.987
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1697.38

Just FYI.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
