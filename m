Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbULJO3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbULJO3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 09:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbULJO3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 09:29:50 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16332 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261600AbULJO3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 09:29:37 -0500
Message-Id: <200412101429.iBAETIs9029152@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Timothy Chavez <chavezt@gmail.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ltcfwd.linux.ibm.com,
       sds@epoch.ncsc.mil, rml@novell.com, ttb@tentacle.dhs.org
Subject: Re: [audit] Upstream solution for auditing file system objects 
In-Reply-To: Your message of "Fri, 10 Dec 2004 00:02:31 GMT."
             <f2833c760412091602354b4c95@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <f2833c760412091602354b4c95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1606294908P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Dec 2004 09:29:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1606294908P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Dec 2004 00:02:31 GMT, Timothy Chavez said:

> Over the last two months, I've been given the daunting task of
> implementing a feature by which an administrator can specify from user
> space, a list of file system objects (namely regular files and
> directories) that he/she wishes to audit. 

One *big* question that you don't address at all in your mail:

Do you need *real time* tracking of changes/etc, in which case inotify or
something based on it are probably an approach to follow (note that I don't
think inotify currently deals with read-only access to a file).

Or do you not care about real-time tracking, but have a requirement to be
able to go back and say "Oh, at 9:03:38.99342 last Tuesday, user XYZ
tried to open this file" - if that's what you want, you probably want to
look at the audit subsystem and its support for syscall auditing.

--==_Exmh_1606294908P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBubK9cC3lWbTT17ARAmGEAJ46WLVPQz1LB9qXblgeP+Z380eMHwCeIjpB
6XYOppW1kKIbieNGBh044Ec=
=a32L
-----END PGP SIGNATURE-----

--==_Exmh_1606294908P--
