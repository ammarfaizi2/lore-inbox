Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTEBG4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 02:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTEBG4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 02:56:35 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:9897 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S261872AbTEBG4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 02:56:33 -0400
Message-ID: <3EB21939.70002@redhat.com>
Date: Fri, 02 May 2003 00:07:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: oops with current bk kernel on x86-64
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB3A90547F7C41C5E682E66BD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3A90547F7C41C5E682E66BD
Content-Type: multipart/mixed;
 boundary="------------040805000003090909010303"

This is a multi-part message in MIME format.
--------------040805000003090909010303
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some harmless code (while compiling glibc) caused two oopses with the
current bk kernel (as of 2003-05-01T21:00:00-07).  syslogd log the
attached lines but the remote session I was using is pretty dead.  This
is on a Solo machine.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------040805000003090909010303
Content-Type: text/plain;
 name="a"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a"

May  1 23:55:30 hammer kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
May  1 23:55:30 hammer kernel:  printing rip:
May  1 23:55:30 hammer kernel: ffffffff8021efe4
May  1 23:55:30 hammer kernel: PML4 eb8f067 PGD 27ad067 PMD 0 
May  1 23:55:30 hammer kernel: Oops: 0000 [1]
May  1 23:55:30 hammer kernel: CPU 0 
May  1 23:55:30 hammer kernel: Pid: 18070, comm: ld-linux-x86-64 Not tainted
May  1 23:55:30 hammer kernel: RIP: 0010:[<ffffffff8021efe4>] <ffffffff8021efe4>{copy_user_generic+1}
May  1 23:55:30 hammer kernel: RSP: 0018:000001000a475b88  EFLAGS: 00010246
May  1 23:55:30 hammer kernel: RAX: 0000000000000058 RBX: 0000000000000fa8 RCX: 0000000000000000
May  1 23:55:30 hammer kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000100027f4058
May  1 23:55:30 hammer kernel: RBP: 000001001ec83860 R08: 000000ff000000fe R09: 000000f7000000f6
May  1 23:55:30 hammer kernel: R10: 000000f9000000f8 R11: 000000f3000000f2 R12: 0000000000000000
May  1 23:55:30 hammer kernel: R13: 00000100027f4058 R14: 0000000000000000 R15: 0000000000000074
May  1 23:55:30 hammer kernel: FS:  0000002a95791300(0000) GS:ffffffff803e7440(0000) knlGS:0000000000000000
May  1 23:55:30 hammer kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
May  1 23:55:30 hammer kernel: CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
May  1 23:55:30 hammer kernel: 
May  1 23:55:30 hammer kernel: Call Trace:<ffffffff80194a2a>{ext3_prepare_write+106} <ffffffff8014b843>{__filemap_copy_from_user_iovec+67} 
May  1 23:55:30 hammer kernel:        <ffffffff8014bf2a>{generic_file_aio_write_nolock+1722} 
May  1 23:55:30 hammer kernel:        <ffffffff8019eea6>{journal_dirty_metadata+438} <ffffffff8014c2ae>{generic_file_write_nolock+94} 
May  1 23:55:30 hammer kernel:        <ffffffff8019eea6>{journal_dirty_metadata+438} <ffffffff801967b1>{ext3_do_update_inode+657} 
May  1 23:55:30 hammer kernel:        <ffffffff8019f32f>{journal_stop+511} <ffffffff8019a88d>{__ext3_journal_stop+45} 
May  1 23:55:30 hammer kernel:        <ffffffff8014c49a>{generic_file_writev+58} <ffffffff80164278>{do_readv_writev+392} 
May  1 23:55:30 hammer kernel:        <ffffffff80163d00>{do_sync_write+0} <ffffffff80164986>{get_empty_filp+118} 
May  1 23:55:30 hammer kernel:        <ffffffff801632e3>{dentry_open+227} <ffffffff801631f1>{filp_open+65} 
May  1 23:55:30 hammer kernel:        <ffffffff80164474>{sys_writev+68} <ffffffff801116a4>{system_call+124} 
May  1 23:55:30 hammer kernel:        
May  1 23:55:30 hammer kernel: Process ld-linux-x86-64 (pid: 18070, stackpage=10019826c50)
May  1 23:55:30 hammer kernel: Stack: 0000000000000fa8 ffffffff8014b843 00000000000005a8 000001001ec83850 
May  1 23:55:30 hammer kernel:        00000100010c7c40 00000100046a2300 0000000000000000 ffffffff8014bf2a 
May  1 23:55:30 hammer kernel:        000001000a475bd8 0000007fbffff630 
May  1 23:55:30 hammer kernel: Call Trace:<ffffffff8014b843>{__filemap_copy_from_user_iovec+67} 
May  1 23:55:30 hammer kernel:        <ffffffff8014bf2a>{generic_file_aio_write_nolock+1722} 
May  1 23:55:30 hammer kernel:        <ffffffff8019eea6>{journal_dirty_metadata+438} <ffffffff8014c2ae>{generic_file_write_nolock+94} 
May  1 23:55:30 hammer kernel:        <ffffffff8019eea6>{journal_dirty_metadata+438} <ffffffff801967b1>{ext3_do_update_inode+657} 
May  1 23:55:30 hammer kernel:        <ffffffff8019f32f>{journal_stop+511} <ffffffff8019a88d>{__ext3_journal_stop+45} 
May  1 23:55:30 hammer kernel:        <ffffffff8014c49a>{generic_file_writev+58} <ffffffff80164278>{do_readv_writev+392} 
May  1 23:55:30 hammer kernel:        <ffffffff80163d00>{do_sync_write+0} <ffffffff80164986>{get_empty_filp+118} 
May  1 23:55:30 hammer kernel:        <ffffffff801632e3>{dentry_open+227} <ffffffff801631f1>{filp_open+65} 
May  1 23:55:30 hammer kernel:        <ffffffff80164474>{sys_writev+68} <ffffffff801116a4>{system_call+124} 
May  1 23:55:30 hammer kernel:        
May  1 23:55:30 hammer kernel: 
May  1 23:55:30 hammer kernel: Code: 0f 18 1e 31 c0 89 f9 83 e1 07 0f 85 9b 00 00 00 48 89 d1 bb 

--------------040805000003090909010303--

--------------enigB3A90547F7C41C5E682E66BD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+shk+2ijCOnn/RHQRAnqUAJ484ZBURzT/NlL1xfj6a+0lyMQswwCfa4xh
CUYfAV76O73aFj0gByysKic=
=FEOH
-----END PGP SIGNATURE-----

--------------enigB3A90547F7C41C5E682E66BD--

