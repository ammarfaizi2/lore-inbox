Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288234AbSACHYm>; Thu, 3 Jan 2002 02:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288231AbSACHYe>; Thu, 3 Jan 2002 02:24:34 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40147 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288235AbSACHYW>; Thu, 3 Jan 2002 02:24:22 -0500
Date: Thu, 3 Jan 2002 00:24:23 -0700
Message-Id: <200201030724.g037ONj04041@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jason Thomas <jason@topic.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in devfs
In-Reply-To: <20020103014507.GB19702@topic.com.au>
In-Reply-To: <20020103014507.GB19702@topic.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Thomas writes:
> Please CC me I'm not on the list
> 
> Hi, I get the following oops, usually after booting. I've done things
> like run memtest86 and changed the scsi cable.
> 
> Thanks.
> 
> cpu: 0, clocks: 1339387, slice: 446462
> cpu: 1, clocks: 1339387, slice: 446462
> kernel BUG at dcache.c:654!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0144b52>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 0000001c   ebx: f5f66210   ecx: c028dd20   edx: 00003757
> esi: f5da5280   edi: f5f661e0   ebp: f5f661e0   esp: f7a7df08
> ds: 0018   es: 0018   ss: 0018
> Process devfsd (pid: 24, stackpage=f7a7d000)
> Stack: c02408d3 0000028e f7324b40 f5da5280 f7a869a0 c016a31f f5f661e0 f5da5280 
>        f5f661e0 00000000 f7a7dfa4 f7a87c40 c013be5e f5f661e0 00000000 f7a7df74 
>        c013c6c1 f7a87c40 f7a7df74 00000000 f7a6a000 00000000 f7a7dfa4 00000009 
> Call Trace: [<c016a31f>] [<c013be5e>] [<c013c6c1>] [<c013c94a>] [<c013ce31>] 
>    [<c013984d>] [<c0132824>] [<c0106dbb>] 
> Code: 0f 0b 83 c4 08 f0 fe 0d a0 36 2e c0 0f 88 a3 63 0e 00 85 f6 
> 
> >>EIP; c0144b52 <d_instantiate+22/58>   <=====
> Trace; c016a31e <devfs_d_revalidate_wait+8a/bc>
> Trace; c013be5e <cached_lookup+2e/54>
> Trace; c013c6c0 <link_path_walk+5e0/850>
> Trace; c013c94a <path_walk+1a/1c>
> Trace; c013ce30 <__user_walk+34/50>
> Trace; c013984c <sys_stat64+18/70>
> Trace; c0132824 <sys_read+bc/c4>
> Trace; c0106dba <system_call+32/38>
> Code;  c0144b52 <d_instantiate+22/58>
> 00000000 <_EIP>:
> Code;  c0144b52 <d_instantiate+22/58>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0144b54 <d_instantiate+24/58>
>    2:   83 c4 08                  add    $0x8,%esp
> Code;  c0144b56 <d_instantiate+26/58>
>    5:   f0 fe 0d a0 36 2e c0      lock decb 0xc02e36a0
> Code;  c0144b5e <d_instantiate+2e/58>
>    c:   0f 88 a3 63 0e 00         js     e63b5 <_EIP+0xe63b5> c022af06 <stext_lo
> ck+2c22/88ee>
> Code;  c0144b64 <d_instantiate+34/58>
>   12:   85 f6                     test   %esi,%esi

Grab devfs-patch-v199.6 from your local kernel.org mirror site and try
again. If you still have the same problem, send the new ksymoops
output as well as *complete* kernel boot logs.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
