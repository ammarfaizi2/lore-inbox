Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281572AbRKUFNx>; Wed, 21 Nov 2001 00:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281589AbRKUFNo>; Wed, 21 Nov 2001 00:13:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:20354 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281572AbRKUFNf>; Wed, 21 Nov 2001 00:13:35 -0500
Date: Tue, 20 Nov 2001 23:16:26 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: [VMBUG] 2.4.15-pre7 Severe VM Bugs in 2.4.15-pre7
Message-ID: <20011120231626.B3637@vger.timpanogas.org>
In-Reply-To: <20011120231449.A3637@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120231449.A3637@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Nov 20, 2001 at 11:14:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oh yeah, I forgot.  The crash occurs when I am mounting an 
NWFS volume.

Jeff

On Tue, Nov 20, 2001 at 11:14:49PM -0700, Jeff V. Merkey wrote:
> 
> 
> The attached oops results from using NWFS on 2.4.15-pre7 with the
> 3Ware adapter.  I do not know what is happening here, but looks
> like some sort of severe memory corruption.  In any event,
> a very nasty looking bug.
> 
> I am looking through my code to see if I caused this, however, the
> oops indicates my code does not seem to be involved in this oops.  I
> have noticed of late some severe stability issues with VM in 2.4.X
> and I noticed Linus addressing some problems with the compiler 
> generating garbage instructions.  I do not know if this is related.
> 
> Please advise, and let me know if anyone wants me to run down further
> info.  I do exercise the memory and IO subsystem a little more strenuously
> than the buffer cache and perhaps I am stressing the VM in a different
> way.  Could also just simply be a bug I am causing.
> 
> 
> Jeff 
> 

> ksymoops 2.4.0 on i686 2.4.15-pre7.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.15-pre7/ (default)
>      -m /boot/System.map-2.4.15-pre7 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
> Error (regular_file): read_system_map stat /boot/System.map-2.4.15-pre7 failed
> Nov 20 09:58:50 scimitar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
> Nov 20 09:58:50 scimitar kernel: c0172f1b
> Nov 20 09:58:50 scimitar kernel: *pde = 00000000
> Nov 20 09:58:50 scimitar kernel: Oops: 0000
> Nov 20 09:58:50 scimitar kernel: CPU:    1
> Nov 20 09:58:50 scimitar kernel: EIP:    0010:[<c0172f1b>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Nov 20 09:58:50 scimitar kernel: EFLAGS: 00010246
> Nov 20 09:58:50 scimitar kernel: eax: 00000000   ebx: cea30000   ecx: cea30018   edx: 000002b8
> Nov 20 09:58:50 scimitar kernel: esi: 00000000   edi: 00000000   ebp: 0000002f   esp: cead5ab8
> Nov 20 09:58:50 scimitar kernel: ds: 0018   es: 0018   ss: 0018
> Nov 20 09:58:50 scimitar kernel: Process mount (pid: 720, stackpage=cead5000)
> Nov 20 09:58:50 scimitar kernel: Stack: cea30018 c0173e29 cea30018 00000080 00000009 cea30018 00000003 00000004 
> Nov 20 09:58:50 scimitar kernel:        000000ae 09c23fff 00000000 c1556600 00000000 00000000 00000009 c019b9bb 
> Nov 20 09:58:50 scimitar kernel:        cead5b28 00001000 cead5b5c 00001000 c030f4fc 00000009 c0172e39 c0172e7f 
> Nov 20 09:58:50 scimitar kernel: Call Trace: [<c0173e29>] [<c019b9bb>] [<c0172e39>] [<c0172e7f>] [<c019a64a>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0124382>] [<c014463c>] [<c013c560>] [<c0295e70>] [<c01124ba>] [<c0176127>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0124d91>] [<c0124da2>] [<c0112320>] [<c010700c>] [<c0124804>] [<c0112320>] 
> Nov 20 09:58:50 scimitar kernel:    [<c010700c>] [<c02949fb>] [<c014bf8c>] [<c014cf8f>] [<c013c560>] [<c012d9e1>] 
> Nov 20 09:58:50 scimitar kernel:    [<c01241ba>] [<c0124214>] [<c0124382>] [<c012779c>] [<c01277c9>] [<c01124ba>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0128742>] [<c0183a39>] [<c01277c9>] [<c0154922>] [<c01125f0>] [<c0294922>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0137fe1>] [<c0138460>] [<c013894f>] [<c0148f53>] [<c0112320>] [<c010700c>] 
> Nov 20 09:58:50 scimitar kernel:    [<c01491ec>] [<c014905c>] [<c01492b0>] [<c0106f1b>] 
> Nov 20 09:58:50 scimitar kernel: Code: 8b 50 08 2b 51 f0 89 50 08 8b 41 f4 ff 48 04 8b 41 f8 83 f8 
> 
> >>EIP; c0172f1b <nlmsvc_invalidate_client+1ffb/32410>   <=====
> Trace; c0173e29 <nlmsvc_invalidate_client+2f09/32410>
> Trace; c019b9bb <nlmsvc_invalidate_client+2aa9b/32410>
> Trace; c0172e39 <nlmsvc_invalidate_client+1f19/32410>
> Trace; c0172e7f <nlmsvc_invalidate_client+1f5f/32410>
> Trace; c019a64a <nlmsvc_invalidate_client+2972a/32410>
> Trace; c0124382 <vmtruncate+542/b30>
> Trace; c014463c <dput+1c/150>
> Trace; c013c560 <path_release+40/180>
> Trace; c0295e70 <memparse+150/440>
> Trace; c01124ba <__verify_write+3ba/8c0>
> Trace; c0176127 <nlmsvc_invalidate_client+5207/32410>
> Trace; c0124d91 <do_mmap_pgoff+421/4f0>
> Trace; c0124da2 <do_mmap_pgoff+432/4f0>
> Trace; c0112320 <__verify_write+220/8c0>
> Trace; c010700c <__read_lock_failed+1290/2704>
> Trace; c0124804 <vmtruncate+9c4/b30>
> Trace; c0112320 <__verify_write+220/8c0>
> Trace; c010700c <__read_lock_failed+1290/2704>
> Trace; c02949fb <clear_user+2b/40>
> Trace; c014bf8c <may_umount+37cc/77f0>
> Trace; c014cf8f <may_umount+47cf/77f0>
> Trace; c013c560 <path_release+40/180>
> Trace; c012d9e1 <__alloc_pages+41/180>
> Trace; c01241ba <vmtruncate+37a/b30>
> Trace; c0124214 <vmtruncate+3d4/b30>
> Trace; c0124382 <vmtruncate+542/b30>
> Trace; c012779c <filemap_nopage+bc/200>
> Trace; c01277c9 <filemap_nopage+e9/200>
> Trace; c01124ba <__verify_write+3ba/8c0>
> Trace; c0128742 <read_cache_page+42/120>
> Trace; c0183a39 <nlmsvc_invalidate_client+12b19/32410>
> Trace; c01277c9 <filemap_nopage+e9/200>
> Trace; c0154922 <grok_partitions+1b02/1a570>
> Trace; c01125f0 <__verify_write+4f0/8c0>
> Trace; c0294922 <__generic_copy_from_user+32/60>
> Trace; c0137fe1 <get_super+351/d30>
> Trace; c0138460 <get_super+7d0/d30>
> Trace; c013894f <get_super+cbf/d30>
> Trace; c0148f53 <may_umount+793/77f0>
> Trace; c0112320 <__verify_write+220/8c0>
> Trace; c010700c <__read_lock_failed+1290/2704>
> Trace; c01491ec <may_umount+a2c/77f0>
> Trace; c014905c <may_umount+89c/77f0>
> Trace; c01492b0 <may_umount+af0/77f0>
> Trace; c0106f1b <__read_lock_failed+119f/2704>
> Code;  c0172f1b <nlmsvc_invalidate_client+1ffb/32410>
> 00000000 <_EIP>:
> Code;  c0172f1b <nlmsvc_invalidate_client+1ffb/32410>   <=====
>    0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
> Code;  c0172f1e <nlmsvc_invalidate_client+1ffe/32410>
>    3:   2b 51 f0                  sub    0xfffffff0(%ecx),%edx
> Code;  c0172f21 <nlmsvc_invalidate_client+2001/32410>
>    6:   89 50 08                  mov    %edx,0x8(%eax)
> Code;  c0172f24 <nlmsvc_invalidate_client+2004/32410>
>    9:   8b 41 f4                  mov    0xfffffff4(%ecx),%eax
> Code;  c0172f27 <nlmsvc_invalidate_client+2007/32410>
>    c:   ff 48 04                  decl   0x4(%eax)
> Code;  c0172f2a <nlmsvc_invalidate_client+200a/32410>
>    f:   8b 41 f8                  mov    0xfffffff8(%ecx),%eax
> Code;  c0172f2d <nlmsvc_invalidate_client+200d/32410>
>   12:   83 f8 00                  cmp    $0x0,%eax
> 
> 
> 2 warnings and 1 error issued.  Results may not be reliable.

