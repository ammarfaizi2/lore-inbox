Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUBLVGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266600AbUBLVGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:06:23 -0500
Received: from intra.cyclades.com ([64.186.161.6]:13755 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266599AbUBLVFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:05:08 -0500
Date: Thu, 12 Feb 2004 18:49:26 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: knfsd oops 2.4.24
In-Reply-To: <20040210210432.A2880@animx.eu.org>
Message-ID: <Pine.LNX.4.58L.0402121847481.4306@logos.cnet>
References: <20040210210432.A2880@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Feb 2004, Wakko Warner wrote:

> I was burning a cd over nfs (glad I have burnproof =) when knfsd crashed on
> me.  2 kjourneld oopses followed (sorry, wasn't able to capture).
>
> Disk is SCSI on an AHA2940UW controller.  I'm considering going to 2.6.x,
> but I'm simply not convinced of 2.6's stability and I've noticed a few knfsd
> problems there as well (minor problems).
>
> I'm sure I'll beable to capture the other oopses.
>
> The machine is an ms6163 pIII700 384mb ram (FYI, this used to be in another
> machine running 2.6 and did not actually have these problems).
>
> Any more information required will be given.
>
> Keep me in CC
>
> ksymoops 2.4.5 on i686 2.4.24.  Options used
>      -v /vegeta/usr/src/linux/nail/2.4.24/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.24/ (default)
>      -m /boot/System.map-2.4.24 (default)
>
> Unable to handle kernel paging request at virtual address fc3e2f3a
>  printing eip:
> c0115c6b
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0115c6b>]    Not tainted
> EFLAGS: 00010086
> eax: cd9a5948   ebx: fc3e2f3a   ecx: 00000001   edx: 00000003
> esi: cd9a5948   edi: 00000003   ebp: d5515d14   esp: d5515cf8
> ds: 0018   es: 0018   ss: 0018
> Process nfsd (pid: 324, stackpage=d5515000)
> Stack: cd9a5900 c013b835 00000001 00000286 cd9a5900 00000008 00000000 00001000
>        c01924af 00000000 cd9a5900 00000000 d7a9a400 00000030 cd9a5900 00000000
>        00000031 cd9a5900 c013c32c 00000000 cd9a5900 cd9a5900 00000000 00000010
> Call Trace:    [<c013b835>] [<c01924af>] [<c013c32c>] [<c0131213>] [<c012a54d>]
>   [<d882b310>] [<c012abcf>] [<c012ae4d>] [<c012b440>] [<c012b59a>] [<c012b440>]
>   [<d88a1964>] [<d88a1cf7>] [<d88362e0>] [<d88a7ee5>] [<d88a9a97>] [<d88ae418>]
>   [<d889d5ee>] [<c01ec1b7>] [<d88ae418>] [<d88adc78>] [<d88adc98>] [<d889d3bd>]
>   [<d88adc60>] [<d88adc60>] [<c010577e>] [<d889d200>]
>
> Code: 8b 13 0f 18 02 39 c3 74 22 8d b6 00 00 00 00 8d bf 00 00 00
> Reading Oops report from the terminal
> Unable to handle kernel paging request at virtual address fc3e2f3a
> c0115c6b
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0115c6b>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010086
> eax: cd9a5948   ebx: fc3e2f3a   ecx: 00000001   edx: 00000003
> esi: cd9a5948   edi: 00000003   ebp: d5515d14   esp: d5515cf8
> ds: 0018   es: 0018   ss: 0018
> Process nfsd (pid: 324, stackpage=d5515000)
> Stack: cd9a5900 c013b835 00000001 00000286 cd9a5900 00000008 00000000 00001000
>        c01924af 00000000 cd9a5900 00000000 d7a9a400 00000030 cd9a5900 00000000
>        00000031 cd9a5900 c013c32c 00000000 cd9a5900 cd9a5900 00000000 00000010
> Call Trace:    [<c013b835>] [<c01924af>] [<c013c32c>] [<c0131213>] [<c012a54d>]
>   [<d882b310>] [<c012abcf>] [<c012ae4d>] [<c012b440>] [<c012b59a>] [<c012b440>]
>   [<d88a1964>] [<d88a1cf7>] [<d88362e0>] [<d88a7ee5>] [<d88a9a97>] [<d88ae418>]
>   [<d889d5ee>] [<c01ec1b7>] [<d88ae418>] [<d88adc78>] [<d88adc98>] [<d889d3bd>]
>   [<d88adc60>] [<d88adc60>] [<c010577e>] [<d889d200>]
> Code: 8b 13 0f 18 02 39 c3 74 22 8d b6 00 00 00 00 8d bf 00 00 00
>
>
> >>EIP; c0115c6b <__wake_up+1b/90>   <=====
>
> >>eax; cd9a5948 <_end+d72851c/18582bd4>
> >>ebx; fc3e2f3a <END_OF_CODE+23b0633b/????>
> >>esi; cd9a5948 <_end+d72851c/18582bd4>
> >>ebp; d5515d14 <_end+152988e8/18582bd4>
> >>esp; d5515cf8 <_end+152988cc/18582bd4>
>
> Trace; c013b835 <get_unused_buffer_head+45/80>
> Trace; c01924af <submit_bh+df/f0>
> Trace; c013c32c <block_read_full_page+15c/280>
> Trace; c0131213 <lru_cache_add+63/80>
> Trace; c012a54d <page_cache_read+ad/d0>

__wake_up() is not called by get_unused_buffer_head(), so this trace looks
odd.

I hope someone corrects me.
