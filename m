Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266523AbUHXF63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUHXF63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUHXF63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:58:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47826 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266523AbUHXF61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:58:27 -0400
Message-Id: <200408240558.i7O5wFuP031966@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Jerry Haltom <wasabi@larvalstage.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setpeuid(pid_t, uid_t) proposal 
In-Reply-To: Your message of "Mon, 23 Aug 2004 23:50:05 CDT."
             <1093323005.1248.21.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <1093323005.1248.21.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1698845600P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 01:58:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1698845600P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 Aug 2004 23:50:05 CDT, Jerry Haltom said:

> Apache runs as a low privledge user, but can obtain the permissions of
> the user that requested the service. Apache can't give itself access, so
> it relies on a seperate process to do so. A request is received to
> Apache. The request comes with authentication information (in a number
> of forms, Basic, Kerberos (GSSAPI), CRAM, NTLM, whatever). The
> authentication information is received by the Apache module that handles
> the specific authentication type. This module passes the security
> information to a seperate stand alone daemon, which is running as root.
> This daemon is highly audited and does one purpose, and does it well.

What does this buy you that having the separate daemon just do
a fork/seteuid/exec to do the work, and passing the results back via a
Unix socket or shared mem or what-have-you?

Alternatively, what would this give you that isn't already done by
the SELinux support for cron, or Apache suexec, which already allow
"run the following in another context" functionality?

--==_Exmh_-1698845600P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBKtj2cC3lWbTT17ARAhQbAJwMu6A43hMkTmwdwoMAS7A+dIchswCgw34x
eTcIu2ARHI9pbMd/v5Z2qfI=
=ejCc
-----END PGP SIGNATURE-----

--==_Exmh_-1698845600P--
