Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290644AbSARJCP>; Fri, 18 Jan 2002 04:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290643AbSARJCG>; Fri, 18 Jan 2002 04:02:06 -0500
Received: from rpapar1.cgey.com ([194.3.224.25]:26340 "EHLO door.cgey.com")
	by vger.kernel.org with ESMTP id <S290644AbSARJBu>;
	Fri, 18 Jan 2002 04:01:50 -0500
Message-ID: <3C47E46C.2E322EC6@cgey.com>
Date: Fri, 18 Jan 2002 09:01:32 +0000
From: Fabien Ribes <fabien.ribes@cgey.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in sock_poll
In-Reply-To: <3C470105.ED9DDCE@cgey.com> <20020117.131224.108809922.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:
> 
> Can you reproduce this with a more recent kernel?  Anything
> >=2.4.9 (this includes all Red Hat errata kernels therefore)
> would be sufficient.
The kernel used is customized in many ways, it is a long work to upgrade
...

> And also please provide a full decoded OOPS log as well, thanks.
here it is:
ksymoops 2.3.7 on i686 2.4.3.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)
     -t elf_powerpc -a powerpc:common

Oops: kernel access of bad area, sig: 11
NIP: C00A0EB4 XER: 00000000 LR: C0046B20 SP: C1981E60 REGS: c1981db0
TRAP: 0300
MSR: 00009230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1980000[148] 'feemond' Last syscall: 142 
last math 00000000 last altivec 00000000
GPR00: C0046B20 C1981E60 C1980000 C1AEFBA0 C1981E78 C1981E78 C1BEB780
00000000 
GPR08: 00000000 00000000 00000000 C1BEB800 C1BEB780 1001D8B8 00000000
00000000 
GPR16: 00000000 00000000 00000000 00000000 C1981EE8 00000005 000000B4
00000000 
GPR24: C1981E78 00000004 00000145 C1981EC8 00000000 00000000 00000010
C1AEFBA0 
Call backtrace: 
C0046884 C0046B20 C0046FC4 C0007E1C C000266C 10001888 100016F8 
10000B30 0FEF6A6C 00000000 
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c00a0eb4 <sock_poll+14/3c>   <=====
Trace; c0046884 <poll_freewait+54/70>
Trace; c0046b20 <do_select+e4/208>
Trace; c0046fc4 <sys_select+330/470>
Trace; c0007e1c <ppc_select+a0/b0>
Trace; c000266c <ret_from_syscall_1+0/b4>
Trace; 10001888 Before first symbol
Trace; 100016f8 Before first symbol
Trace; 10000b30 Before first symbol
Trace; 0fef6a6c Before first symbol
Trace; 00000000 Before first symbol


1 warning issued.  Results may not be reliable.
