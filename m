Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVAaBv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVAaBv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 20:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVAaBv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 20:51:26 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:33924 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261888AbVAaBvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 20:51:14 -0500
Message-ID: <41FD8F08.3020000@tequila.co.jp>
Date: Mon, 31 Jan 2005 10:51:04 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel panic on a 2.6.7
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I have a RedHat 9.0 box with a self compiled 2.6.7 kernel.

Today I had this error and a total lockup on the box. Before that (~6h
before I had another lockup, but no output to anywhere).

Jan 31 10:30:23 soba kernel: Unable to handle kernel paging request at
virtual address 95806adf
Jan 31 10:30:23 soba kernel:  printing eip:
Jan 31 10:30:23 soba kernel: c022117f
Jan 31 10:30:23 soba kernel: *pde = 00000000
Jan 31 10:30:23 soba kernel: Oops: 0000 [#1]
Jan 31 10:30:23 soba kernel: Modules linked in: appletalk psnap llc
Jan 31 10:30:23 soba kernel: CPU:    0
Jan 31 10:30:23 soba kernel: EIP:    0060:[<c022117f>]    Not tainted
Jan 31 10:30:23 soba kernel: EFLAGS: 00010097   (2.6.7)
Jan 31 10:30:23 soba kernel: EIP is at __lookup_tag+0x6f/0x140
Jan 31 10:30:23 soba kernel: eax: 00000000   ebx: 008b5000   ecx:
00000000   edx: 00000001
Jan 31 10:30:23 soba kernel: esi: 958069db   edi: ffffffff   ebp:
00000001   esp: c15d8d5c
Jan 31 10:30:23 soba kernel: ds: 007b   es: 007b   ss: 0068
Jan 31 10:30:23 soba kernel: Process pdflush (pid: 34,
threadinfo=c15d8000 task=dfe14630)
Jan 31 10:30:23 soba kernel: Stack: 00000000 00000000 00000000 958069db
00000000 00000000 0000000a 00000010
Jan 31 10:30:23 soba kernel:        3fffffff c15d8da0 c02212a9 de282800
c15d8e60 008b2000 00000006 c15d8da0
Jan 31 10:30:23 soba kernel:        00000000 008b2000 c15d8e38 c15d8e24
00000010 c15d8f38 c0131187 de282800
Jan 31 10:30:23 soba kernel: Call Trace:
Jan 31 10:30:23 soba kernel:  [<c02212a9>]
radix_tree_gang_lookup_tag+0x59/0x80
Jan 31 10:30:23 soba kernel:  [<c0131187>] find_get_pages_tag+0x37/0x70
Jan 31 10:30:23 soba kernel:  [<c013ab76>] pagevec_lookup_tag+0x36/0x40
Jan 31 10:30:23 soba kernel:  [<c016bcbb>] mpage_writepages+0x10b/0x350
Jan 31 10:30:23 soba kernel:  [<c0153a50>] blkdev_writepage+0x0/0x30
Jan 31 10:30:23 soba kernel:  [<c0154a5f>] generic_writepages+0x1f/0x23
Jan 31 10:30:23 soba kernel:  [<c0136485>] do_writepages+0x25/0x50
Jan 31 10:30:23 soba kernel:  [<c016a519>] __sync_single_inode+0x59/0x1e0
Jan 31 10:30:23 soba kernel:  [<c0188413>] ext3_put_inode+0x13/0x30
Jan 31 10:30:23 soba kernel:  [<c016a8df>] sync_sb_inodes+0x19f/0x2b0
Jan 31 10:30:23 soba kernel:  [<c0136cf0>] pdflush+0x0/0x30
Jan 31 10:30:23 soba kernel:  [<c016aa80>] writeback_inodes+0x90/0xa0
Jan 31 10:30:23 soba kernel:  [<c0136258>] wb_kupdate+0xf8/0x170
Jan 31 10:30:23 soba kernel:  [<c0136c24>] __pdflush+0xa4/0x170
Jan 31 10:30:23 soba kernel:  [<c0136d18>] pdflush+0x28/0x30
Jan 31 10:30:23 soba kernel:  [<c0136160>] wb_kupdate+0x0/0x170
Jan 31 10:30:23 soba kernel:  [<c0136cf0>] pdflush+0x0/0x30
Jan 31 10:30:23 soba kernel:  [<c0127eca>] kthread+0xaa/0xb0
Jan 31 10:30:23 soba kernel:  [<c0127e20>] kthread+0x0/0xb0
Jan 31 10:30:23 soba kernel:  [<c01023e5>] kernel_thread_helper+0x5/0x10
Jan 31 10:30:23 soba kernel:
Jan 31 10:30:23 soba kernel: Code: 0f a3 8e 04 01 00 00 19 c0 85 c0 0f
85 a0 00 00 00 21 fb 01
Jan 31 10:30:25 soba kernel:  <1>Unable to handle kernel paging request
at virtual address 1eb3f12f
Jan 31 10:30:25 soba kernel:  printing eip:
Jan 31 10:30:25 soba kernel: c0220eb4
Jan 31 10:30:25 soba kernel: *pde = 00000000
Jan 31 10:30:25 soba kernel: Oops: 0000 [#2]
Jan 31 10:30:25 soba kernel: Modules linked in: appletalk psnap llc
Jan 31 10:30:25 soba kernel: CPU:    0
Jan 31 10:30:25 soba kernel: EIP:    0060:[<c0220eb4>]    Not tainted
Jan 31 10:30:25 soba kernel: EFLAGS: 00010046   (2.6.7)
Jan 31 10:30:25 soba kernel: EIP is at radix_tree_tag_set+0x54/0x90
Jan 31 10:30:25 soba kernel: eax: 00000000   ebx: 1eb3f02b   ecx:
1eb3f02b   edx: 00000000
Jan 31 10:30:25 soba kernel: esi: 00000001   edi: 00000000   ebp:
c622fe40   esp: de36bd88
Jan 31 10:30:25 soba kernel: ds: 007b   es: 007b   ss: 0068
Jan 31 10:30:25 soba kernel: Process kjournald (pid: 1164,
threadinfo=de36b000 task=de7ea7b0)
Jan 31 10:30:25 soba kernel: Stack: 00000000 de2827fc dd5f6a2c dd5f6a50
d8e1d3bc c01366c3 de282800 008b5040
Jan 31 10:30:25 soba kernel:        00000000 d432e0ec c014f133 c12619c0
c0198d3f c2be489c c019e703 cbe8f2fc
Jan 31 10:30:25 soba kernel:        de36bdc4 00000001 d432e0ec dd5f6a2c
00000000 00000000 c019a02e d432e0ec
Jan 31 10:30:25 soba kernel: Call Trace:
Jan 31 10:30:25 soba kernel:  [<c01366c3>]
__set_page_dirty_nobuffers+0xe3/0x140
Jan 31 10:30:25 soba kernel:  [<c014f133>] mark_buffer_dirty+0x23/0x30
Jan 31 10:30:25 soba kernel:  [<c0198d3f>]
__journal_unfile_buffer+0x7f/0x180
Jan 31 10:30:25 soba kernel:  [<c019e703>]
journal_put_journal_head+0x43/0x80
Jan 31 10:30:25 soba kernel:  [<c019a02e>]
journal_commit_transaction+0x88e/0x1040
Jan 31 10:30:25 soba kernel:  [<c019c8e4>] kjournald+0xc4/0x220
Jan 31 10:30:25 soba kernel:  [<c01156b0>] autoremove_wake_function+0x0/0x60
Jan 31 10:30:25 soba kernel:  [<c01156b0>] autoremove_wake_function+0x0/0x60
Jan 31 10:30:25 soba kernel:  [<c0104042>] ret_from_fork+0x6/0x14
Jan 31 10:30:25 soba kernel:  [<c019c800>] commit_timeout+0x0/0x10
Jan 31 10:30:25 soba kernel:  [<c019c820>] kjournald+0x0/0x220
Jan 31 10:30:25 soba kernel:  [<c01023e5>] kernel_thread_helper+0x5/0x10
Jan 31 10:30:25 soba kernel:
Jan 31 10:30:25 soba kernel: Code: 0f a3 91 04 01 00 00 19 c0 85 c0 75
0a 0f ab 91 04 01 00 00

gcc, library files are all still from redhat 9, but there are a lot of
extra things compiled by hand or from fedora core libraries.

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/Y8IjBz/yQjBxz8RArO7AKDXpJ9FQ8VQFV1Bunz1rlqdsWa3yACfVVuA
FNeuo+2A+5ZHdkD2KE1ly3Q=
=rBmN
-----END PGP SIGNATURE-----
