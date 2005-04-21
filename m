Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVDURdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVDURdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVDURdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:33:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261566AbVDURdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:33:22 -0400
Date: Thu, 21 Apr 2005 13:33:07 -0400
From: Dave Jones <davej@redhat.com>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Need AES benchmark on Intel 64 bit
Message-ID: <20050421173307.GE18285@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andreas Steinmetz <ast@domdv.de>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <42679C86.5050604@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42679C86.5050604@domdv.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 02:28:54PM +0200, Andreas Steinmetz wrote:
 > Hi,
 > can anybody help out? I don't have access to Intel 64 bit CPUs and need
 > some microbenchmark results on Intel 64 bit. Usage guide for the
 > attached archive:
 > 
 > 'ref' contains the current generic AES implementation
 > 'new' contains the 64 bit AES assembler implementation
 > 
 > Do 'make' in both directories and run the resulting 'aes' on an
 > otherwise idle system without any cpufreq (speedstep) stuff active.
 > Preferrably do multiple runs to assert that the results are usable (a
 > few ticks difference between runs are ok).
 > 
 > The microbenchmark is set up to produce somewhat real life results with
 > hot caches, thus the same data block is processed all the time.

ref:
schedule128 1535
schedule192 1817
schedule256 2167
enc asm 128 1166
dec asm 128 1163
enc asm 192 1361
dec asm 192 1378
enc asm 256 1570
dec asm 256 1594

schedule128 1535
schedule192 1817
schedule256 2170
enc asm 128 1166
dec asm 128 1164
enc asm 192 1361
dec asm 192 1382
enc asm 256 1579
dec asm 256 1599


new:
schedule128 1542
schedule192 1823
schedule256 2177
enc asm 128 1034
dec asm 128 1018
enc asm 192 1212
dec asm 192 1213
enc asm 256 1409
dec asm 256 1401

schedule128 1547
schedule192 1828
schedule256 2182
enc asm 128 1036
dec asm 128 1024
enc asm 192 1217
dec asm 192 1222
enc asm 256 1412
dec asm 256 1395


subsequent runs present the same picture. 'new' seems slightly higher
scores on schedule*, but lower scores on the other tests.


Dual 2.8 Xeon w/HT...

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2793.079
cache size      : 1024 KB
physical id     : 3
siblings        : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5570.56
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:


		Dave

