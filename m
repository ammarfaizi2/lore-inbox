Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTJFIB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbTJFIB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:01:28 -0400
Received: from h80ad26c9.async.vt.edu ([128.173.38.201]:2711 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262979AbTJFIB0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:01:26 -0400
Message-Id: <200310060801.h9681BCE023675@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Leigh Purdie <spammagnet@intersectalliance.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security Auditing subsystem for Linux - request for advice/assistance 
In-Reply-To: Your message of "Mon, 06 Oct 2003 17:13:10 +1000."
             <1065424389.7059.90.camel@inferno> 
From: Valdis.Kletnieks@vt.edu
References: <1065424389.7059.90.camel@inferno>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1583492812P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Oct 2003 04:01:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1583492812P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Oct 2003 17:13:10 +1000, Leigh Purdie <spammagnet@intersectalliance.com>  said:

> The current implementation has a few areas that would really benefit
> from a bit of care-and-feeding from an experienced kernel hacker. In
> particular:
> * Filenames
>   - Grabbing the REAL source / destination path for file-related events,
> regardless of:
>   a) Whether the system call succeeds or fails

> * Potentially many other areas.
>   - LSM integration for some calls, if viable?

You could do all of this from an LSM, except that the LSM exits are restrictive
rather than authoritative.  The upshot is that if an open() syscall fails due
to file permissions, the LSM exit is never called, so you won't get an audit
record that way - you need a more invasive patch for that.

Read the LSM archives, there's a lot of discussion of doing auditing in there,
much of it revolving around the fact that proper audit makes for one hell of an
invasive patch.  Now that LSM is in for 2.6, it *might* be feasible to discuss
audit for 2.7/8.

You probably want to port your patch to the 2.6 tree, as more development is
going on there.


--==_Exmh_-1583492812P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/gSFEcC3lWbTT17ARAqxLAKDqsOUFxaFuG+PJECDokxYi6+uG0wCgja6d
L6gR17gNmMBzQx5KqPgEFRg=
=2uTg
-----END PGP SIGNATURE-----

--==_Exmh_-1583492812P--
