Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310475AbSCSIjN>; Tue, 19 Mar 2002 03:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310479AbSCSIjE>; Tue, 19 Mar 2002 03:39:04 -0500
Received: from mx2.castel.nl ([195.85.130.77]:18183 "EHLO mx2.castel.nl")
	by vger.kernel.org with ESMTP id <S310475AbSCSIiv>;
	Tue, 19 Mar 2002 03:38:51 -0500
Message-Id: <200203182150.g2ILo2t22937@mx2.castel.nl>
From: Rene Herman <rene.herman@mail.com>
Subject: Re: 7.52 second kernel compile
To: linux-kernel@vger.kernel.org
Date: Mon, 18 Mar 2002 22:50:55 +0100
In-Reply-To: <Pine.LNX.4.33.0203181146070.4783-100000@home.transmeta.com> <Pine.LNX.4.33.0203181213130.12950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> So on a PII core, you'll see something like
> 
> 87.50: 36
> 12.39: 40
> 
> ie 87.5% (exactly 7/8) of the TLB misses take 36 cycles, while 12.4%
> (ie 1/8) takes 40 cycles (and I assuem that the extra 4 cycles is due
> to actually loading the thing from the data cache).
> 
> Yeah, my program might be buggy, so take the numbers with a pinch of
> salt. But it's interesting to see how on an athlon the numbers are
> 
>  3.17: 59
> 34.94: 62
>  4.71: 85
> 54.83: 88
> 
> ie roughly 60% take 85-90 cycles, and 40% take ~60 cycles. I don't
> know where that pattern would come from..

You scared me, so I ran the program on my AMD duron. Result are 
completely repeatable (4 runs):

   4.17: 20
  92.89: 21
   1.17: 26

   4.17: 20
  93.00: 21
   1.18: 26

   4.17: 20
  92.86: 21
   1.18: 26

   4.16: 20
  92.78: 21
   1.16: 26

Ie, rather violently different from the numbers you quoted for the 
Athlon...

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor 
stepping        : 1
cpu MHz         : 757.472
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1510.60

Rene.

