Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVIVUDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVIVUDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVIVUDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:03:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7560 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030311AbVIVUDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:03:51 -0400
Message-Id: <200509222003.j8MK3i8E010365@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: breno@kalangolinux.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: security patch 
In-Reply-To: Your message of "Thu, 22 Sep 2005 19:44:33 -0000."
             <20050922194433.13200.qmail@webmail2.locasite.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <20050922194433.13200.qmail@webmail2.locasite.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127419424_2709P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 16:03:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127419424_2709P
Content-Type: text/plain; charset=us-ascii

On Thu, 22 Sep 2005 19:44:33 -0000, breno@kalangolinux.org said:

> I'm doing a new feature for linux kernel 2.6 to protect against all kinds of buffer
> overflow. It works with new sys_control() system call controling if a process can or can't
> call a system call ie. sys_execve();

This has been done before. ;)

Also, note *VERY* carefully that this does *NOT* protect against buffer overflow
the way ExecShield and PAX and similar do - this merely tries to mitigate the
damage.

Note that you probably don't *DARE* remove open()/read()/write()/close() from
the "permitted syscall" list - and an attacker can have plenty of fun just with
those 4 syscalls.

(That's also why SELinux was designed to give better granularity to syscalls - it
can restrict a program to "write only to files it *should* be able to write").

--==_Exmh_1127419424_2709P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMw4gcC3lWbTT17ARAlBmAKCa9Ia2S3wIgs3WH/WBOL0AxatW1QCg6yUE
qXLoC+AuYvj0mybD5z2CdqQ=
=Bkq5
-----END PGP SIGNATURE-----

--==_Exmh_1127419424_2709P--
