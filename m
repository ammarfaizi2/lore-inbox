Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTECWsK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTECWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:48:09 -0400
Received: from [128.173.39.159] ([128.173.39.159]:22146 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263448AbTECWsI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:48:08 -0400
Message-Id: <200305032300.h43N0UX9006675@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature 
In-Reply-To: Your message of "Sat, 03 May 2003 13:19:52 -0000."
             <20030503131952.5560.qmail@science.horizon.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030503131952.5560.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-884826295P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 03 May 2003 19:00:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-884826295P
Content-Type: text/plain; charset=us-ascii

On Sat, 03 May 2003 13:19:52 -0000, linux@horizon.com  said:

> An interesting question arises: is the number of useful interpreter
> functions (system, popen, exec*) sufficiently low that they could be
> removed from libc.so entirely and only staticly linked, so processes
> that didn't use them wouldn't even have them in their address space,
> and ones that did would have them at less predictible addresses?
> 
> Right now, I'm thinking only of functions that end up calling execve();
> are there any other sufficiently powerful interpreters hiding in common
> system libraries?  regexec()?

This does absolutely nothing to stop an exploit from providing its own
inline version of execve().  There's nothing in libc that a process can't
do itself, inline.

A better bet is using an LSM module that prohibits exec() calls from any
unauthorized combinations of running program/user/etc.

--==_Exmh_-884826295P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+tEoNcC3lWbTT17ARAripAJ9CT/0UGQ3KQ5u+/MjV2cjTeJpeHQCgrRYR
al88z3WLrN8yW9tKXEMW2tE=
=Q9gK
-----END PGP SIGNATURE-----

--==_Exmh_-884826295P--
