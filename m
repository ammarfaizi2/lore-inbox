Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVGLKSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVGLKSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVGLKSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:18:34 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:41962 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261301AbVGLKSe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:18:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vn2tTKw1w/SbA/1vY21WlzoseCmHFWcNZmKsImFll2x5kUhKZpKBhM4MWRfRg0co3dJY4lvUYpm9ZwOCTzfM2hktW4UyO53McWmX7w7eyf4UyUu4YKzoXX/l8s7Je9Aily/XpYmBubW/XcUw1fql0sAvVU0gaWgUSWDRgkRupAo=
Message-ID: <6278d22205071203185a50a104@mail.gmail.com>
Date: Tue, 12 Jul 2005 11:18:32 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with more than 8 AMD Opteron Cores per System
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find the ondemand governor works as expected with 2.6.12 on my
Athlon64 Winchester [1]; as soon as I bzip2 a file, processor freq is
pinned at 1.8GHz and drops to 1GHz when idle.

--- [1]

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 31
model name      : AMD Athlon(tm) 64 Processor 3000+
stepping        : 0
cpu MHz         : 1004.646
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow
bogomips        : 1988.83
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

Oliver Weihe wrote:
> Hello,
> 
> I've two Iwill 8way Opteron equipped with 8 Opteron 875 CPUs each.
> (In the past we build some systems with singlecore CPUs and they went
> very well)
> 
> The Problem now is that the machines crash during boot when maxcpus is
> greater than 8.
> 2.6.12-rc4 works well with maxcpus=8, with 9 or more it freezes after
> "Testing NMI Watchdog... OK"
> 
> 2.6.12-rc5 and above have more problems even with maxcpus=4 or less very
> early during booting.
> 
> 2.6.13-X crashes later during boot (from 2 to 16 cores it's the same
> behavior)
> 
> The last I can so on the console (kernel 2.6.13-rc2-git4, maxcpus=2..16)
> is:
> 
> NET: Registered protocol family 1
> Using IPI Shortcut mode
> int3: 0000 [1] SMP
> CPU4
> Modules linked in:
> Freeing unused kernel memory: 212k freed
> Pid: 0, comm: swapper Not tainted 2.6.13-rc2-git4-default
> RIP: 0010:[<ffffffff8050fc00>]
> 
> After that the machines are totally freezed.
> 
> With maxcpus=1 all (tested) versions >=2.6.12-rc3 are able to boot.
> 
> Any hints/ideas/what ever?
> 
> Regards,
>    Oliver Weihe
> 
> P.S. if you answer CC me ;)
___
Daniel J Blueman
