Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTJNPaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTJNPaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 11:30:14 -0400
Received: from intra.cyclades.com ([64.186.161.6]:23523 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262569AbTJNPaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 11:30:05 -0400
Date: Tue, 14 Oct 2003 12:32:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Janis Putrams <janis.putrams@delfi.lv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: paging request at virtual address 8a000018, pde = 00000000
In-Reply-To: <PDENKKCEFBFIMGJFDIBHCEAHCCAA.janis.putrams@delfi.lv>
Message-ID: <Pine.LNX.4.44.0310141231500.3366-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Oct 2003, Janis Putrams wrote:

> Hi!
> Got regular kernel crashes on high load nfs client/db server/www. Had
> crashes with kernels 2.4.18 as well as 2.4.20. Replaced RAM- no help.
> Managed to capture through serial console. If someone could give direction
> it would be great.
> Thanks
> Janis Putrams
>
>
> 
> cpu:2x Intel(R) XEON(TM) CPU 2.20GHz
> os:Red Hat Linux 7.3 2.96-113
> gcc:gcc version 2.96 20000731
> kernel-ver:linux-2.4.20-20.7(have happened also with 2.4.18)
> 
> Unable to handle kernel paging request at virtual address 8a000018
> c0106da7
> *pde = 00000000
> Oops: 0000
> CPU:    1
> EIP:    0010:[<c0106da7>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 8a000028   ebx: de110000   ecx: de110000   edx: 8a000000
> esi: 00000002   edi: 8a000018   ebp: de111f30   esp: de111f28
> ds: 0018   es: 0018   ss: 0018
> Process httpd (pid: 17454, stackpage=de111000)
> Stack: de110654 de111fc4 00000002 00000000 00000000 00000000 00000000
> c529f03b
>        de110000 00000000 e6c08780 f8a6aa33 e6c08780 00000000 de111f90
> 00000000
>        c0148c10 ec986f80 c0148b34 e6c08780 00000000 00000000 00000000
> c013d32a
> Call Trace:   [<f8a6aa33>]  (0xde111f54))
> [<c0148c10>]  (0xde111f68))
> [<c0148b34>]  (0xde111f70))
> [<c013d32a>]  (0xde111f84))
> [<c010708c>]  (0xde111fc0))
> Code: 8b 40 f0 83 f8 01 75 31 83 fe 11 0f 85 08 ff ff ff 90 8d b4
> 
> >>EIP; c0106da7 <do_signal+127/27b>   <=====
> Trace; f8a6aa33 <[nfs]nfs_permission+13/119>
> Trace; c0148c10 <path_release+10/30>
> Trace; c0148b34 <permission+44/80>
> Trace; c013d32a <sys_access+ea/120>
> Trace; c010708c <signal_return+14/18>
> Code;  c0106da7 <do_signal+127/27b>
> 00000000 <_EIP>:
> Code;  c0106da7 <do_signal+127/27b>   <=====
>    0:   8b 40 f0                  mov    0xfffffff0(%eax),%eax   <=====
> Code;  c0106daa <do_signal+12a/27b>
>    3:   83 f8 01                  cmp    $0x1,%eax
> Code;  c0106dad <do_signal+12d/27b>
>    6:   75 31                     jne    39 <_EIP+0x39> c0106de0
> <do_signal+160/27b>
> Code;  c0106daf <do_signal+12f/27b>
>    8:   83 fe 11                  cmp    $0x11,%esi
> Code;  c0106db2 <do_signal+132/27b>
>    b:   0f 85 08 ff ff ff         jne    ffffff19 <_EIP+0xffffff19> c0106cc0
> <do_signal+40/27b>
> Code;  c0106db8 <do_signal+138/27b>
>   11:   90                        nop
> Code;  c0106db9 <do_signal+139/27b>
>   12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

Hum I dont remember ever seeing this. 

Try memtest to check if the memory is indeed okay. 

