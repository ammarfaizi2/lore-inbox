Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbSJDVhb>; Fri, 4 Oct 2002 17:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262083AbSJDVhb>; Fri, 4 Oct 2002 17:37:31 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:31628 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S262074AbSJDVha>;
	Fri, 4 Oct 2002 17:37:30 -0400
Message-Id: <200210042154.g94Lsxv00543@www.veltzer.org>
Content-Type: text/plain; charset=US-ASCII
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Date: Sat, 5 Oct 2002 00:54:58 +0300
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 05 October 2002 00:06, David S. Miller wrote:
> There is simply no portable way to make changes to the system call
> table, so exporting it makes zero sense.
> -

I don't wish to comment on the need or lack thereof of exporting the sys call
table but it sounds to me that this is an area where some work would be
beneficial.

Is it too complication to produce a portable API along the lines of:

	syscall_entry_replace(int,func_t)

Which will be implemented per architecture with the appropriate locks ?

And if locking is the problem then even a trimmed version that doesn't do
locking and maybe could be used for other in kernel purposes in code where
the locking is not needed ?

Just wondering,
	Mark.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ng4yxlxDIcceXTgRApJPAKDTC5SMk5NTYtxdRyR24rjahJc6oACgwWJ6
LzVp9BpimttoWdFDyDgL5QU=
=5eOR
-----END PGP SIGNATURE-----
