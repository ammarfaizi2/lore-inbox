Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVEEVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVEEVCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEEVCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:02:53 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:65029 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261797AbVEEVCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:02:50 -0400
Message-Id: <200505052102.j45L2kI7013191@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: does e2fsprogs needs to invoke file system related system calls? 
In-Reply-To: Your message of "Thu, 05 May 2005 16:49:33 EDT."
             <4ae3c1405050513493b5a1b88@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <4ae3c1405050513493b5a1b88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115326966_5123P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 May 2005 17:02:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115326966_5123P
Content-Type: text/plain; charset=us-ascii

On Thu, 05 May 2005 16:49:33 EDT, Xin Zhao said:
> does e2fsprogs needs to invoke file system related system calls?

Which calls do you mean?  I suspect that for the most part, it's
doing read/write/etc to the *underlying medium* - for instance, mkfs.ext3
can't use calls related to the *file system* because it's not mounted
yet (it doesn't even *exist* yet).

> The reason I want to ask this question is to know whether we can
> bypass the system call monitoring based access control with e2fsprogs.

It's been known since the Unix V7 days and even earlier that having read/write
access to the underlying /dev/hd-whatever partition was able to bypass
file permissions on the file system built on that partition.  Of course, write
access is at your own risk, as there's no easy/clean way to ensure that the
kernel doesn't have an in-core copy that doesn't match what you wrote (as
everybody who's run fsck on a live file system can testify ;)

--==_Exmh_1115326966_5123P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCeon2cC3lWbTT17ARAnsEAJ9Mw3AH+0CPFdiUwTW9e+sRfngTHgCgvO3h
4kWpyM7vWjiW6qJ41dzVJsk=
=hfqc
-----END PGP SIGNATURE-----

--==_Exmh_1115326966_5123P--
