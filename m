Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbSJACp3>; Mon, 30 Sep 2002 22:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSJACp2>; Mon, 30 Sep 2002 22:45:28 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:2432 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261459AbSJACp0>;
	Mon, 30 Sep 2002 22:45:26 -0400
Date: Mon, 30 Sep 2002 21:50:52 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Steven Cole <elenstev@mesatop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
In-Reply-To: <1033434784.3100.10.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209302147380.961-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2002, Steven Cole wrote:

> I tried to boot 2.5.39 on my home machine and got the
> following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).
> 
> *pde = 00000000
> Oops: 0002
> 
> CPU:	0
> EIP:	0060:[<c01a7979>]	Not tainted
> EFLAGS:	00010286
> EIP is at attach+0x1d/0x30
> eax: c0276724	ebx: 00000000	ecx: c40c8060	edx: c40c8078
> esi: c0276700	edi: 00000000	ebp: 00000000	esp: c40ddf94
> ds:  0068 	es: 0068	ss: 0068
> Process swapper (pid: 1, threadinfo=c40dc000 task=c40da040)
> Stack: 00000000 c01a7a5a c40c8060 c40c8060 c01a7c20 c40c8060 c40c8060 c40c8060
>        c40d7720 c028b879 c40c8060 00000001 c02b9bf4 00000000 00000000 00000000
>        c027e6f2 c0105030 c010504c c0105030 00000000 00000000 00000000 c0105495
> Call Trace:
> [<c01a7a5a>] device_attach+0x3a/0x40
> [<c01a7c20>] device_register+0xd0/0x120
> [<c0105030>] init+0x0/0x160
> [<c010504c>] init+0x1c/0x160
> [<c0105030>] init+0x0/0x160
> [<c0105495>] kernel_thread_helper+0x5/0x10
> 

I believe the oops on boot people have been seeing in 2.5.39 may be 
related to problems inserting ide-scsi modules (sr_mod, mod_scsi, 
ide-scsi).  Since I have to get up early tomorrow I'm going to beg off for 
tonight, but I can reliably produce the above oops.  I'll provide full 
data and explanations when I'm not so tired.  

