Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUHXMBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUHXMBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 08:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUHXMBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 08:01:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16057 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267595AbUHXMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 08:01:38 -0400
Message-Id: <200408241201.i7OC1RWf021834@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Jerry Haltom <wasabi@larvalstage.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setpeuid(pid_t, uid_t) proposal 
In-Reply-To: Your message of "Tue, 24 Aug 2004 01:27:50 CDT."
             <1093328870.1248.31.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <1093323005.1248.21.camel@localhost> <200408240558.i7O5wFuP031966@turing-police.cc.vt.edu>
            <1093328870.1248.31.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1630948809P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 08:01:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1630948809P
Content-Type: text/plain; charset=us-ascii

On Tue, 24 Aug 2004 01:27:50 CDT, Jerry Haltom said:
> > What does this buy you that having the separate daemon just do
> > a fork/seteuid/exec to do the work, and passing the results back via a
> > Unix socket or shared mem or what-have-you?
> 
> To do a seteuid the daemon would need to be root.

And how is this different from:

> Only a process with uid 0 may call it. The first argument is a process
> id. The second argument is a uid. The function is effictivly the exact
> same as seteuid() except that it operates on another process. Very
> simple explanation, now here's why.
.....
> Apache runs as a low privledge user, but can obtain the permissions of
> the user that requested the service. Apache can't give itself access, so
> it relies on a seperate process to do so. A request is received to

You've already stated that the separate process has to be running as root....

--==_Exmh_-1630948809P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBKy4XcC3lWbTT17ARAmZCAJ9p7YFEq2TXN52R8l3+ykCZ+h2RSACgrEik
XexGjm1jLliNzZk8XG55Y38=
=/nsg
-----END PGP SIGNATURE-----

--==_Exmh_-1630948809P--
