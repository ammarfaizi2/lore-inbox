Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUEKBHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUEKBHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 21:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUEKBHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 21:07:10 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:39837 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S262051AbUEKBGy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 21:06:54 -0400
Message-Id: <200405110106.i4B16o97010526@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Richard A Nelson <cowboy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1 Oops with dummy network device (sysfs related?) 
In-Reply-To: Your message of "Mon, 10 May 2004 16:59:54 EDT."
             <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1165704454P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 May 2004 21:06:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1165704454P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 16:59:54 EDT, Richard A Nelson <cowboy@debian.org>  said:
> : divert: allocating divert_blk for dummy0
> : Unable to handle kernel NULL pointer dereference at virtual address 0000000
0
> :  printing eip:
> : c016dcad
> : *pde = 00000000
> :        ___      ______
> :       0--,|    /OOOOOO\
> :      {_o  /  /OO plop OO\
> :        \__\_/OO oh dear OOO\s
> :           \OOOOOOOOOOOOOOOO/
> :            __XXX__   __XXX__
> : Oops: 0000 [#1]
> : PREEMPT
> : CPU:    0
> : EIP:    0060:[d_move+109/576]    Not tainted VLI
> : EFLAGS: 00210246   (2.6.6-mm1)
> : EIP is at d_move+0x6d/0x240
> : eax: 00000000   ebx: c25549a4   ecx: c2554a0c   edx: 00000000
> : esi: c313d908   edi: c155f928   ebp: c496aebc   esp: c496aea8
> : ds: 007b   es: 007b   ss: 0068
> : Process ip (pid: 5604, threadinfo=c496a000 task=c7cc54c0)
> : Stack: 00000006 c0149c27 c480cca0 c313d908 c155f928 c496aedc c018e251 00200
286
> :        c496af44 c480ce50 c480ce50 c480cca0 c50d5113 c496aeec c01d18b1 c480c
e48
> :        c480cca0 c496aefc c0231ca8 c480cca0 c480cdcc c496af24 c028f56b c496a
f24
> : Call Trace:
> :  [show_stack+122/144] show_stack+0x7a/0x90
> :  [show_registers+324/432] show_registers+0x144/0x1b0
> :  [die+153/272] die+0x99/0x110
> :  [do_page_fault+485/1327] do_page_fault+0x1e5/0x52f
> :  [error_code+45/56] error_code+0x2d/0x38
> :  [sysfs_rename_dir+193/224] sysfs_rename_dir+0xc1/0xe0
> :  [kobject_rename+33/64] kobject_rename+0x21/0x40
> :  [class_device_rename+56/80] class_device_rename+0x38/0x50
> :  [dev_change_name+315/448] dev_change_name+0x13b/0x1c0
> :  [dev_ioctl+339/704] dev_ioctl+0x153/0x2c0
> :  [inet_ioctl+154/176] inet_ioctl+0x9a/0xb0
> :  [sock_ioctl+239/656] sock_ioctl+0xef/0x290
> :  [sys_ioctl+261/608] sys_ioctl+0x105/0x260
> :  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

Am seeing this as  well, while running 'nameif' to rename real Ethernet interfaces.

--==_Exmh_-1165704454P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoCcqcC3lWbTT17ARAjFUAJ40/zDB0Lpa8N/9R42tz6SwCqI0bQCcDVcV
QuEnd9Q+/yI+DEuS5w4kJa4=
=zVPC
-----END PGP SIGNATURE-----

--==_Exmh_-1165704454P--
