Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSLVWyk>; Sun, 22 Dec 2002 17:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSLVWyk>; Sun, 22 Dec 2002 17:54:40 -0500
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:13282 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S265523AbSLVWyi>; Sun, 22 Dec 2002 17:54:38 -0500
Date: Sun, 22 Dec 2002 23:02:46 +0000
From: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>
To: Arador <diegocg@teleline.es>
cc: <linux-kernel@vger.kernel.org>, <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs bug
In-Reply-To: <20021222154655.0a2d1125.diegocg@teleline.es>
Message-ID: <Pine.SGI.4.33.0212222301400.120984-100000@mole.bio.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the report. I am on holiday at the moment so I am going to look
into it when I get back in January unless someone beats me to it.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

On Sun, 22 Dec 2002, Arador wrote:

> kernel 2.5.52, smp,
> ntfs compiled as module,
> writing not enabled, when i try to mount
> an partition from xp:
>
> NTFS driver 2.1.0 [Flags: R/O MODULE].
> Unable to handle kernel NULL pointer dereference at virtual address 00000028
>  printing eip:
> d48b685f
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060:[<d48b685f>]    Not tainted
> EFLAGS: 00010202
> EIP is at ntfs_fill_super+0x16f/0x6c8 [ntfs]
> eax: 00000000   ebx: c387de00   ecx: d4893000   edx: 00000200
> esi: c03bb3ec   edi: c4dde760   ebp: c387de00   esp: cea5de8c
> ds: 0068   es: 0068   ss: 0068
> Process mount (pid: 523, threadinfo=cea5c000 task=c957e0c0)
> Stack: c387de00 c03bb3ec c387df48 cea5decc c4dde694 00000200 c014ed36 c387de00
>        c505b000 00000000 c387de00 00000200 d48bc9e0 fffffff4 d48bc9e0 c15bb2b8
>        cea5df0c d48b6df7 d48bc9e0 00000000 c5059000 c505b000 d48b66f0 cffe6874
> Call Trace:
>  [<c014ed36>] get_sb_bdev+0xe2/0x12c
>  [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
>  [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
>  [<d48b6df7>] ntfs_get_sb+0x1f/0x24 [ntfs]
>  [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
>  [<d48b66f0>] ntfs_fill_super+0x0/0x6c8 [ntfs]
>  [<c014ef07>] do_kern_mount+0x4b/0xb8
>  [<d48bc9e0>] ntfs_fs_type+0x0/0x20 [ntfs]
>  [<c0164896>] do_add_mount+0x66/0x158
>  [<c0164b6d>] do_mount+0x139/0x150
>  [<c019639b>] copy_from_user+0x2f/0x3c
>  [<c0165178>] sys_mount+0xd8/0x164
>  [<c0109037>] syscall_call+0x7/0xb
>
> Code: 8b 40 28 85 c0 74 11 66 83 b8 b6 00 00 00 00 74 07 0f b7 90
>
> diego@estel:~$
>
> config.gz attached
>
>
> Diego Calleja

