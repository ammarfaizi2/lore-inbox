Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUFWGs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUFWGs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUFWGs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:48:28 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:53483 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S266163AbUFWGpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:45:08 -0400
Date: Tue, 22 Jun 2004 23:43:17 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] Linux 2.6.7
Message-Id: <20040622234317.523cae55@laptop.delusion.de>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__22_Jun_2004_23_43_17_-0700_7/gMK3qBClDDbUdM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__22_Jun_2004_23_43_17_-0700_7/gMK3qBClDDbUdM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hi,

Following oops just hit me out of the blue, after several days of uptime.

-Udo.


Unable to handle kernel paging request at virtual address 4145ab20
 printing eip:
c016545a
*pde = 10296067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c016545a>]    Not tainted
EFLAGS: 00010202   (2.6.7) 
EIP is at __d_lookup+0x8a/0x170
eax: 4145ab20   ebx: 4145ab20   ecx: 00000010   edx: c1340000
esi: c137d34c   edi: 00c21968   ebp: ced5c334   esp: d5951e64
ds: 007b   es: 007b   ss: 0068
Process sylpheed (pid: 5262, threadinfo=d5950000 task=ca3b08d0)
Stack: d5950000 00c21968 00000000 d5951e70 d5951e70 00000000 c137d34c d7b0f000 
       00000004 d5951ee4 cebd0740 00c21968 d5951f2c d5951edc d5951ee4 c015b1c6 
       d7fb7860 00c21968 d5951ee4 d7b0f004 d7b0f000 c015b7fd d5951f6c 00000000 
Call Trace:
 [<c015b1c6>] do_lookup+0x26/0x90
 [<c015b7fd>] link_path_walk+0x5cd/0x9e0
 [<c0104188>] common_interrupt+0x18/0x20
 [<c015be6a>] path_lookup+0x7a/0x140
 [<c015c0a9>] __user_walk+0x49/0x70
 [<c015716d>] vfs_stat+0x1d/0x60
 [<c015780f>] sys_stat64+0xf/0x30
 [<c01091ea>] do_gettimeofday+0x1a/0xc0
 [<c011bdd6>] sys_time+0x16/0x50
 [<c010401b>] syscall_call+0x7/0xb

Code: 8b 03 0f 18 00 90 8d 6b 98 8b 7c 24 04 39 7d 14 75 e4 8b 44 
 <6>note: sylpheed[5262] exited with preempt_count 1
bad: scheduling while atomic!
 [<c03c647a>] schedule+0x49a/0x4d0
 [<c013eac9>] zap_pmd_range+0x49/0x70
 [<c013eb2d>] unmap_page_range+0x3d/0x70
 [<c013ed2c>] unmap_vmas+0x1cc/0x1e0
 [<c0142f84>] exit_mmap+0x74/0x150
 [<c0116e45>] mmput+0x55/0x70
 [<c011ad6a>] do_exit+0x14a/0x3d0
 [<c0104901>] die+0x101/0x110
 [<c0113dc0>] do_page_fault+0x0/0x4e5
 [<c01140f1>] do_page_fault+0x331/0x4e5
 [<c0150c1d>] __find_get_block+0x8d/0xc0
 [<c01156e0>] scheduler_tick+0x170/0x430
 [<c01204cf>] do_timer+0x5f/0xe0
 [<c011c660>] __do_softirq+0x40/0x90
 [<c0105d26>] do_IRQ+0x106/0x130
 [<c0113dc0>] do_page_fault+0x0/0x4e5
 [<c0104225>] error_code+0x2d/0x38
 [<c016545a>] __d_lookup+0x8a/0x170
 [<c015b1c6>] do_lookup+0x26/0x90
 [<c015b7fd>] link_path_walk+0x5cd/0x9e0
 [<c0104188>] common_interrupt+0x18/0x20
 [<c015be6a>] path_lookup+0x7a/0x140
 [<c015c0a9>] __user_walk+0x49/0x70
 [<c015716d>] vfs_stat+0x1d/0x60
 [<c015780f>] sys_stat64+0xf/0x30
 [<c01091ea>] do_gettimeofday+0x1a/0xc0
 [<c011bdd6>] sys_time+0x16/0x50
 [<c010401b>] syscall_call+0x7/0xb

--Signature=_Tue__22_Jun_2004_23_43_17_-0700_7/gMK3qBClDDbUdM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2SaLnhRzXSM7nSkRArhDAJ4jw/j4VkP00YEQk21SZmiaimOxGgCbBNhx
9hmYWhLSQLfeMhoP70joieU=
=eS3J
-----END PGP SIGNATURE-----

--Signature=_Tue__22_Jun_2004_23_43_17_-0700_7/gMK3qBClDDbUdM--
