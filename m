Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVHSGgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVHSGgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVHSGgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:36:08 -0400
Received: from main.gmane.org ([80.91.229.2]:10929 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751035AbVHSGgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:36:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Bug? scheduling while atomic: wine-preloader
Date: Thu, 18 Aug 2005 23:31:49 -0700
Message-ID: <de3ucq$d9t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig63B8C619A85DBB3BF142D152"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-216-211.dsl.pltn13.pacbell.net
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig63B8C619A85DBB3BF142D152
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I got this on a stock 2.6.12 (haven't added .5 yet) setup while trying
to do crazy stuff with Wine.

scheduling while atomic: wine-preloader/0x1000000c/13047
 [<c032f517>] schedule+0x5d7/0x5e0
 [<c01923f7>] ext3_ordered_commit_write+0xc7/0xf0
 [<c032fcb9>] cond_resched+0x29/0x40
 [<c0138971>] generic_file_buffered_write+0x2e1/0x650
 [<c016ff02>] inode_update_time+0x52/0xe0
 [<c013900b>] __generic_file_aio_write_nolock+0x32b/0x570
 [<c0191b60>] ext3_get_block+0x0/0xa0
 [<c013b6a2>] __alloc_pages+0x2d2/0x420
 [<c0139502>] generic_file_aio_write+0x72/0xe0
 [<c018fab4>] ext3_file_write+0x44/0xd0
 [<c015488e>] do_sync_write+0xbe/0xf0
 [<c0145e7e>] do_no_page+0x1ae/0x310
 [<c01401c8>] mark_page_accessed+0x28/0x30
 [<c014498e>] __follow_page+0x9e/0xc0
 [<c012c770>] autoremove_wake_function+0x0/0x60
 [<c0144ad8>] get_user_pages+0xb8/0x390
 [<c017ef2b>] dump_write+0x2b/0x40
 [<c017ffcd>] elf_core_dump+0xa5d/0xc70
 [<c0160dab>] do_coredump+0x1cb/0x208
 [<c0121d35>] __dequeue_signal+0xf5/0x1d0
 [<c0121e45>] dequeue_signal+0x35/0xe0
 [<c0123b19>] get_signal_to_deliver+0x209/0x2f0
 [<c0102aa8>] do_signal+0x98/0x130
 [<c0109fa3>] restore_i387_fxsave+0x83/0x90
 [<c0123c6d>] sigprocmask+0x3d/0xb0
 [<c0123d62>] sys_rt_sigprocmask+0x82/0x100
 [<c0112730>] do_page_fault+0x0/0x599
 [<c0102b75>] do_notify_resume+0x35/0x38
 [<c0102d32>] work_notifysig+0x13/0x15
note: wine-preloader[13047] exited with preempt_count 12

I'm assuming that This Shouldn't Happen, so I thought that kernel
hackers in tune with current developments might like to know about this.

Please CC me on replies.

-- 
Joshua Kwan

--------------enig63B8C619A85DBB3BF142D152
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQwV82aOILr94RG8mAQL6oBAAgXNoNOUp7ZdYZKQ0RElPMSUudbh2ZGeD
j0QOEVmcBNAEDZGU7iIhZlDlgactEgo1hUMK1FONVGXgOnW4dJD6jmykogjq3LE9
Ws1phlRaOnIGPGA3DnozDbGMtMUKBx5UZ1uX+PAocaOQnlb7KtDi6IL37+Dg5Nad
PtQcGFaWMGBXFC7z5dzhbkn1PdoMR4wMX/C1CrUfGDLO0T3QXqwwIGhgQOxPj6KS
dOQ+aijR2R+8jw+yIS69wrkLnuGUeT/LuWW7nf3OnSTS9O/OJvK+KjkzcEP12Gk8
D12dG1hW11NtoMF/mIdjERIoNXPsfcYS1u/rRFma5ngIoMCstfP7FgSy3msy9UmP
hDO5FIRvdSNvfnw2m7jrHdRe6YUcXnmXpFAuCEL9FDq0V8r3qoWf30itdrmmju8z
r31RsHH8dpk+yycgq8V8/bdZe1ZCqmbKFXeuwQN8oipS4WxHsXvedvv8/eKMt+Bo
R1uIH0i2SizkRj6MUPj07SssQ5lew9K48JAsTf+t55FLT/v1ln0thC5MBjhAxH/0
YsQtJLf7y/C1YFhaKGYQJAR35x88x+n5GOyAQPkI7d8qpZohs2Of1MZy0CfYZKtw
ses4ytEJt8LBrmemCKfcqgGjlvqot800SMKx+Qyf2g2+a/rffB0q4lOHlEIxVRRP
0EnTD892dT0=
=zWFz
-----END PGP SIGNATURE-----

--------------enig63B8C619A85DBB3BF142D152--

