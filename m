Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSCJVxg>; Sun, 10 Mar 2002 16:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293299AbSCJVx1>; Sun, 10 Mar 2002 16:53:27 -0500
Received: from pop.gmx.net ([213.165.64.20]:4845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293291AbSCJVxJ>;
	Sun, 10 Mar 2002 16:53:09 -0500
Date: Sun, 10 Mar 2002 22:57:15 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Opss! on 2.5.6 with ReiserFS
Message-Id: <20020310225715.5aa53b37.sebastian.droege@gmx.de>
In-Reply-To: <20020310142609.A22174@rushmore>
In-Reply-To: <20020310142609.A22174@rushmore>
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.'J9OGAH)QDvK.R"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.'J9OGAH)QDvK.R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
I have a very similar Oops while mounting my ReiserFS root partition with 2.5.6
2.5.5-dj3 and 2.5.6-pre2 are working
If necessary I can handcopy the Oops

Bye

On Sun, 10 Mar 2002 14:26:09 -0500
rwhron@earthlink.net wrote:

> I have got oops at boot time from 2.5.6-pre3 and 2.5.6 on 
> system with reiserfs root filesystem on ide.  Oops occurs
> during attempt to mount /.   No modules in kernel.  
> 2.5.6-pre2 was okay.
> 
> 2.5.6:
> Unable to handle kernel NULL pointer dereference at virtual address 00000010
> c012cae6
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c012cae6>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010292
> eax: d8802000   ebx: 0000000f   ecx: 00000009   edx: 00000000
> esi: 00000009   edi: 00002012   ebp: 00000000   esp: c143bd7c
> ds: 0018   es: 0018   ss: 0018
> Stack: 00001000 00002012 00000000 d7e9a800 c0123f4b c012cfdb 00000000 00002012
>        00001000 d7e9a800 d7e54000 d88133ec c012d19c 00000000 00002012 00001000
>        d7e9a800 c018cb53 00000000 00002012 00001000 00000400 00000000 d7e9a954
> Call Trace: [<c0123f4b>] [<c012cfdb>] [<c012d19c>] [<c018cb53>] [<c012c480>]
>    [<c017f486>] [<c017fd43>] [<c0195402>] [<c0130329>] [<c0180112>] [<c017fc1c>]
>    [<c01304cf>] [<c013ecb8>] [<c013ef6e>] [<c013edd4>] [<c013f2e0>] [<c01051e9>]
>    [<c0105028>] [<c0105550>]
> Code: 0f b7 45 10 b0 00 66 0f b6 55 10 01 d0 25 ff ff 00 00 89 44
> 
> >>EIP; c012cae6 <__get_hash_table+1a/9c>   <=====
> Trace; c0123f4b <__vmalloc+fb/1c0>
> Trace; c012cfdb <__getblk+17/38>
> Trace; c012d19c <__bread+14/6c>
> Trace; c018cb53 <journal_init+eb/68c>
> Trace; c012c480 <__wait_on_buffer+84/90>
> Trace; c017f486 <read_bitmaps+ce/160>
> Trace; c017fd43 <reiserfs_fill_super+127/490>
> Trace; c0195402 <sprintf+12/18>
> Trace; c0130329 <get_sb_bdev+22d/29c>
> Trace; c0180112 <reiserfs_get_sb+1a/20>
> Trace; c017fc1c <reiserfs_fill_super+0/490>
> Trace; c01304cf <do_kern_mount+47/c4>
> Trace; c013ecb8 <do_add_mount+64/130>
> Trace; c013ef6e <do_mount+14a/164>
> Trace; c013edd4 <copy_mount_options+50/a0>
> Trace; c013f2e0 <sys_mount+7c/bc>
> Trace; c01051e9 <prepare_namespace+a9/e0>
> Trace; c0105028 <init+c/124>
> Trace; c0105550 <kernel_thread+28/38>
> Code;  c012cae6 <__get_hash_table+1a/9c>
> 00000000 <_EIP>:
> Code;  c012cae6 <__get_hash_table+1a/9c>   <=====
>    0:   0f b7 45 10               movzwl 0x10(%ebp),%eax   <=====
> Code;  c012caea <__get_hash_table+1e/9c>
>    4:   b0 00                     mov    $0x0,%al
> Code;  c012caec <__get_hash_table+20/9c>
>    6:   66 0f b6 55 10            movzbw 0x10(%ebp),%dx
> Code;  c012caf1 <__get_hash_table+25/9c>
>    b:   01 d0                     add    %edx,%eax
> Code;  c012caf3 <__get_hash_table+27/9c>
>    d:   25 ff ff 00 00            and    $0xffff,%eax
> Code;  c012caf8 <__get_hash_table+2c/9c>
>   12:   89 44 00 00               mov    %eax,0x0(%eax,%eax,1)
> 
>  <0>Kernel panic: Attempted to kill init!

--=.'J9OGAH)QDvK.R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8i9bAe9FFpVVDScsRAvFEAKD3UEDdPFbEfC4cCincuO0fFp5gAwCfb+mB
p2JzIMGZk/HXslCDmnnoVEg=
=V/Vr
-----END PGP SIGNATURE-----

--=.'J9OGAH)QDvK.R--

