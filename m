Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269594AbRHQETc>; Fri, 17 Aug 2001 00:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269599AbRHQETW>; Fri, 17 Aug 2001 00:19:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46488 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269594AbRHQETJ>; Fri, 17 Aug 2001 00:19:09 -0400
Date: Thu, 16 Aug 2001 22:19:07 -0600
Message-Id: <200108170419.f7H4J7c20693@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Taylor Carpenter <taylorcc@codecafe.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net>
In-Reply-To: <20010816222811.A1672@pioneer.oftheInter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taylor Carpenter writes:
> Any access to /dev/fd0 gives a kernel oops.  Have not accessed the floppy in a
> while, but noticed the complaint when booting and after looking further.
> 
> kernel: 2.4.7  (using devfs)
> devfsd: 1.3.11

If you think the problem may be devfs-related, a good test is to try
again with CONFIG_DEVFS_FS=n.

However, I run devfs, and I don't see this problem.

> [12]# insmod floppy
> Using /lib/modules/2.4.7athlon/kernel/drivers/block/floppy.o
> inserting floppy driver for 2.4.7athlon
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> 
> [13]# ls -l /dev/fd0
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c013c4c4
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c013c4c4>]
> EFLAGS: 00010246
> eax: 00000000   ebx: 00001000   ecx: ffffffff   edx: 00000000
> esi: 00000000   edi: 00000000   ebp: dd439fa4   esp: dd439f5c
> ds: 0018   es: 0018   ss: 0018
> Process ls (pid: 367, stackpage=dd439000)
> Stack: df693ec0 00000000 00001000 c015469b df693ec0 bfffec54 00001000 00000000
>        df092840 c01376d2 df693ec0 bfffec54 00001000 df092840 dd438000 bffffead
>        00000003 bffffc7c df693ec0 c188e4c0 00003000 dd438000 08057000 00000008
> Call Trace: [<c015469b>] [<c01376d2>] [<c0106c2b>]
> 
> Code: f2 ae f7 d1 49 89 ce 39 de 0f 47 f3 56 52 8b 44 24 1c 50 e8
> Segmentation fault

You need to run this through ksymoops before anyone can help you.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
