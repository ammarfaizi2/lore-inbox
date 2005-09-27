Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVI0X1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVI0X1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVI0X1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:27:07 -0400
Received: from h80ad2583.async.vt.edu ([128.173.37.131]:43694 "EHLO
	h80ad2583.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751160AbVI0X1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:27:06 -0400
Message-Id: <200509272326.j8RNQqHM031916@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag 
In-Reply-To: Your message of "Tue, 27 Sep 2005 08:45:07 MDT."
             <21FFE0795C0F654FAD783094A9AE1DFC086EFADA@cof110avexu4.global.avaya.com> 
From: Valdis.Kletnieks@vt.edu
References: <21FFE0795C0F654FAD783094A9AE1DFC086EFADA@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127863610_31960P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Sep 2005 19:26:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127863610_31960P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Sep 2005 08:45:07 MDT, "Davda, Bhavesh P (Bhavesh)" said:

> Then propose an alternative way where a real-time (SCHED_FIFO/SCHED_RR)
> CPU bound application getting lots of SEGVs for normal operation doesn't

If it's RT, *and* CPU-bound, *and* tossing enough SEGV's to matter, it's a
train wreck waiting to happen.  If something attaches to that locomotive
with a ptrace(), making sure that a SEGV doesn't cause a priority inversion
merely delays the wreck until the *next* thing the debugger is interested in.
What's *next*, prohibit the overhead of whatever "stop at" or "trace value"
command the debugger has?  By the time you clean all of that stuff up, you're
basically left with "why bother allowing a ptrace()?".

--==_Exmh_1127863610_31960P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDOdU6cC3lWbTT17ARAklGAKDhC6mgyFF/q7zqoUpTb/G+ahk8eQCfTJiR
AzuDvvwDGP295exvQb96/30=
=ZpUF
-----END PGP SIGNATURE-----

--==_Exmh_1127863610_31960P--
