Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTFYO5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFYO5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:57:52 -0400
Received: from h80ad2736.async.vt.edu ([128.173.39.54]:38542 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264500AbTFYO5u (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:57:50 -0400
Message-Id: <200306251511.h5PFBpdA021017@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: grendel@debian.org
Cc: Steve Lord <lord@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas 
In-Reply-To: Your message of "Wed, 25 Jun 2003 15:41:29 +0200."
             <20030625134129.GG1745@thanes.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com>
            <20030625134129.GG1745@thanes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1285876347P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Jun 2003 11:11:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1285876347P
Content-Type: text/plain; charset=us-ascii

On Wed, 25 Jun 2003 15:41:29 +0200, Marek Habersack said:

> And what about the right to partially control the file whose ownership you
> transferred to another user? Currently it is possible to chmod a file to
> 0600 (or directory to 0700), chown it to root and then remove it - but you
> cannot write to it not even open it. Also, an administrator might expect
> that a file created with the root rights in the user's directory will remain
> untouchable/unreadable/inmutable to the user, but this is not so - the user
> can remove any files created by root whether or not restricted_chown is in
> effect. That might be quite a nightmare for the admins. Or at the very least
> it's inconsistent with other filesystems.

Maybe I'm low on caffeine and therefor misreading it, but isn't this just an
example of "file rename/remove requires write permission on the *parent*
dirctory, since that's what's being changed", which often surprises novice (and
not-so-novice) sysadmins?  See also the reason for the sticky bit on directories..

In any case, I didn't notice that any behavior (other than the 'chown giveaway')
was different than other filesystems?

--==_Exmh_-1285876347P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE++bu3cC3lWbTT17ARAvegAKCVA9KEDLH+x43zLbD2nhvuIV/fkQCgwYUO
5kLPsHyrMkS+NWGGgcHOh0k=
=4C5T
-----END PGP SIGNATURE-----

--==_Exmh_-1285876347P--
