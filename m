Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263432AbVGASoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbVGASoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbVGASoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:44:20 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:32175 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S263437AbVGASnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:43:07 -0400
Message-ID: <3505.192.167.206.189.1120243369.squirrel@new.host.name>
In-Reply-To: <a728f9f905070111133a24590@mail.gmail.com>
References: <a728f9f905070111133a24590@mail.gmail.com>
Date: Fri, 1 Jul 2005 20:42:49 +0200 (CEST)
Subject: Re: jfs mount causes oops on sparc64
From: "Luigi Genoni" <genoni@darkstar.linuxpratico.net>
To: "Alex Deucher" <alexdeucher@gmail.com>
Cc: jfs-discussion@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       ag@m-cam.com
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be interesting to understand if it is FS related as it seems.
have you tried another FS?

does it work with reiserfs, XFS or ext3 and ext2?



On Fri, July 1, 2005 20:13, Alex Deucher wrote:
> I have a 6.9 TB jfs LVM volume on a sparc64 debian box, however mount
> seems to cause an oops when I attempt to mount the volume:
>
> jfs_mount: diMount(ipaimap) failed w/rc = -5
> data_access_exception: SFSR[0000000000801009] SFAR[000000000043f770],
> going. \|/ ____ \|/
> "@'/ .. \`@"
> /_| \__/ |_\
> \__U_/
> mount(3502): Dax [#1]
> TSTATE: 0000004411009607 TPC: 000000000051b8d0 TNPC: 000000000051b8d4
> Y: 00000000    Not tainted
> TPC: <diFree+0x30/0xe20>
> g0: fffff800bd24aca1 g1: 0000000000000000 g2: fffff800bdd39800 g3:
> fffff800bdd398c8 g4: fffff800bbcce800 g5: 0000000000000000 g6:
> fffff800bd248000 g7: fffff80093977d88 o0: 0000000000000000 o1:
> 0000000000000001 o2: fffff800bd167c10 o3:
> 0000000000000000
> o4: fffffffffffffffa o5: 0000000000000001 sp: fffff800bd24acf1 ret_pc:
> 00000000004410d4
> RPC: <__wake_up_common+0x34/0x80>
> l0: 0000000000000000 l1: 0000000000000001 l2: 0000000000444d0c l3:
> 0000000000000400
> l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7:
> 0000000000000008
> i0: fffff80093977d68 i1: fffff800bd24b6d0 i2: 0000000000000001 i3:
> 737400000043f76c
> i4: 0000000000000000 i5: 00000000007e1400 i6: fffff800bd24ae61 i7:
> 000000000050fcd0
> I7: <jfs_delete_inode+0x30/0x160>
> Caller[000000000050fcd0]: jfs_delete_inode+0x30/0x160
> Caller[000000000049f004]: generic_delete_inode+0xc4/0x160
> Caller[000000000049f28c]: iput+0x6c/0xc0
> Caller[0000000000512c8c]: jfs_mount+0x8c/0x320
> Caller[000000000050f3b0]: jfs_fill_super+0xb0/0x2c0
> Caller[000000000048bd68]: get_sb_bdev+0x108/0x160
> Caller[000000000048bfc0]: do_kern_mount+0x40/0x100
> Caller[00000000004a1ca4]: do_new_mount+0x64/0xa0
> Caller[00000000004a2338]: do_mount+0x118/0x180
> Caller[00000000004ad950]: compat_sys_mount+0xb0/0x160
> Caller[0000000000410df4]: linux_sparc_syscall32+0x34/0x40
> Caller[0000000000012824]: 0x12824
> Instruction DUMP: c2586028  c277a767  f6587f98 <c206e004> 80a58001
> 16400369  ae100018  f40e3dfa  833da000
>
>
> kernel is 2.6.12rc3 on debian sparc.  Any ideas?
>
> Alex
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

