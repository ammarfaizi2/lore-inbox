Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTH0QFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTH0QDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:03:01 -0400
Received: from main.gmane.org ([80.91.224.249]:12196 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263553AbTH0QCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:02:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Date: Wed, 27 Aug 2003 16:02:35 +0000 (UTC)
Message-ID: <slrnbkplgr.eu5.psavo@varg.dyndns.org>
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030826122621.GB3140@malvern.uk.w2k.superh.com> <20030827140121.GA1973@mail.jlokier.co.uk>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jamie Lokier <jamie@shareable.org>:
> Richard Curnow wrote:
>> OK, since I get something different to the other reports I saw:
>> 
>>  1:20PM-malvern-0-534-% ./sysenter
>>  1:20PM-malvern-STKFLT-535-% echo $?
>> 144
> 
> Hi Richard,
> 
> That's because you ran it on a 2.5/2.6 kernel, right?  The test code
> is meant for 2.4 kernels and earlier :)

If this is of any help..

- -
pvsavola@a11a:~/code$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 6
cpu MHz         : 199.312
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
bogomips        : 397.31

pvsavola@a11a:~/code$ ./sysent ; echo $?
Segmentation fault
139
pvsavola@a11a:~/code$ uname -a
Linux a11a 2.4.19-ck3-rmap #1 Mon Aug 26 21:38:49 EEST 2002 i686 GNU/Linux
- -

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

