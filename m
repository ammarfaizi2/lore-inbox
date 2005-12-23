Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbVLWFyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbVLWFyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbVLWFyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:54:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23462 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030420AbVLWFyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:54:41 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051211000039.GR11190@wotan.suse.de>
References: <1134154208.14363.8.camel@mindpipe> <439A0746.80208@mnsu.edu>
	 <1134173138.18432.41.camel@mindpipe> <439A201D.7030103@mnsu.edu>
	 <1134179410.18432.66.camel@mindpipe> <p73oe3ppbxj.fsf@verdi.suse.de>
	 <1134191524.18432.82.camel@mindpipe> <20051210071935.GQ11190@wotan.suse.de>
	 <1134243273.18432.104.camel@mindpipe>
	 <20051211000039.GR11190@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 00:59:04 -0500
Message-Id: <1135317544.4473.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-11 at 01:00 +0100, Andi Kleen wrote:
> > Here are the relevant lines of arch/x86_64/kernel/vmlinux.lds:
> > 
> >     382 OUTPUT_FORMAT("elf64-x86-64", "elf64-x86-64", "elf64-x86-64")
> >     383 OUTPUT_ARCH(1:x86-64)
> >     384 ENTRY(phys_startup_64)
> > 
> > Any ideas?  Another toolchain quirk?
> 
> The original is 
> 
> OUTPUT_ARCH(i386:x86-64)
> 
> It replaced the i386 with 1, which obviously doesn't work.
> 
> Try (full patch again) 
> 

I still get:

  SYSCALL arch/x86_64/ia32/vsyscall-sysenter.so
/usr/bin/ld: warning: i386:x86-64 architecture of input file
`arch/x86_64/ia32/vsyscall-sysenter.o' is incompatible with i386 output
  AS      arch/x86_64/ia32/vsyscall-syscall.o
  SYSCALL arch/x86_64/ia32/vsyscall-syscall.so
/usr/bin/ld: warning: i386:x86-64 architecture of input file
`arch/x86_64/ia32/vsyscall-syscall.o' is incompatible with i386 output
  AS      arch/x86_64/ia32/syscall32_syscall.o

Lee


