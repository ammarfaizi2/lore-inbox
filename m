Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSLOX3I>; Sun, 15 Dec 2002 18:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSLOX3H>; Sun, 15 Dec 2002 18:29:07 -0500
Received: from mail.michigannet.com ([208.49.116.30]:519 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S263342AbSLOX3G>; Sun, 15 Dec 2002 18:29:06 -0500
Date: Sun, 15 Dec 2002 18:36:54 -0500
From: Paul <set@pobox.com>
To: John Bradford <john@bradfords.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Oops 2.5.51] PnPBIOS: cat /proc/bus/pnp/escd
Message-ID: <20021215233654.GF1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	John Bradford <john@bradfords.org.uk>, linux-kernel@vger.kernel.org
References: <20021215230344.GE1432@squish.home.loc> <200212152339.gBFNddsV002213@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212152339.gBFNddsV002213@darkstar.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@bradfords.org.uk>, on Sun Dec 15, 2002 [11:39:38 PM] said:
> > 
> > 	Hi;
> > 
> > 	'cat /proc/bus/pnp/escd' consistantly produces this:
> > 
> > Paul
> > set@pobox.com
> > 
> > (need any more info, just ask)
> 
> Could you run that oops through ksymoops, please?
> 
> John.

	Hi;

	Sorry, I had, but it didnt seem to add any more info
than what the kernel popped out, with all the debugging on:

Paul
set@pobox.com

ksymoops 2.4.7 on i686 2.4.20-rc2.  Options used
     -v ./vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m ./System.map (specified)

SGI XFS for Linux 2.5.51 with no debug enabled
Unable to handle kernel paging request at virtual address ffffd000
00007b74
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0088:[<00007b74>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: 000000a0   ebx: 00a0d07b   ecx: 00000400   edx: 00000000
esi: 0000d000   edi: 00000000   ebp: c31e7eb0   esp: c31e7e88
ds: 00a0   es: 0098   ss: 0068
Stack: 00000000 0090d000 00907b89 d049d4eb 00000042 00680068 0246d016 00920098 
       c31e7efc 0080000b 00000042 00a00098 00000090 00000000 c0217074 00000060 
       00000082 00000000 00000000 00000068 00000068 00000246 00000042 c31e7efc 
Call Trace:
 [<c0217074>] __pnp_bios_read_escd+0xf0/0x14c
 [<c02170df>] pnp_bios_read_escd+0xf/0x30
 [<c02180cf>] proc_read_escd+0x5f/0xf0
 [<c015dab5>] proc_file_read+0xb9/0x174
 [<c0138d27>] vfs_read+0xab/0x150
 [<c0138ff4>] sys_read+0x28/0x3c
 [<c010a7c7>] syscall_call+0x7/0xb
Code:  Bad EIP value.


>>EIP; 00007b74 Before first symbol   <=====

Trace; c0217074 <__pnp_bios_read_escd+f0/14c>
Trace; c02170df <pnp_bios_read_escd+f/30>
Trace; c02180cf <proc_read_escd+5f/f0>
Trace; c015dab5 <proc_file_read+b9/174>
Trace; c0138d27 <vfs_read+ab/150>
Trace; c0138ff4 <sys_read+28/3c>
Trace; c010a7c7 <syscall_call+7/b>

