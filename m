Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265609AbSJXTZx>; Thu, 24 Oct 2002 15:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265610AbSJXTZx>; Thu, 24 Oct 2002 15:25:53 -0400
Received: from pdbn-d9bb875a.pool.mediaWays.net ([217.187.135.90]:19204 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S265609AbSJXTZv>;
	Thu, 24 Oct 2002 15:25:51 -0400
Date: Thu, 24 Oct 2002 21:31:51 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024193151.GA29041@citd.de>
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:
> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.

Ripping out the tests that didn't function on a P-III this is the result:

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
copy_page() tests
copy_page function '2.4 non MMX'         took 15221 cycles per page
copy_page function '2.4 MMX fallback'    took 15090 cycles per page
copy_page function 'no_prefetch'         took 12531 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
copy_page() tests
copy_page function '2.4 non MMX'         took 15053 cycles per page
copy_page function '2.4 MMX fallback'    took 17020 cycles per page
copy_page function 'no_prefetch'         took 11344 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
copy_page() tests
copy_page function '2.4 non MMX'         took 14600 cycles per page
copy_page function '2.4 MMX fallback'    took 16427 cycles per page
copy_page function 'no_prefetch'         took 11822 cycles per page

System:
Dual-PIII
Serverworks HE-SL Chipset
3GB RAM. (2x512MB, 2x1GB (interleaved (AFAIK)))

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 930.214
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1854.66






Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

