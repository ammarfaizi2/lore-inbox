Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUBAMVi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 07:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUBAMVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 07:21:38 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:57988 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265279AbUBAMVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 07:21:37 -0500
Date: Sun, 1 Feb 2004 12:21:34 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Julien Rebetez <julien.r@bluewin.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.22  memory overwriting
Message-ID: <20040201122134.GC3183@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Julien Rebetez <julien.r@bluewin.ch>, linux-kernel@vger.kernel.org
References: <401CEDAD.70601@bluewin.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <401CEDAD.70601@bluewin.ch>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 01, 2004 at 01:14:37PM +0100, Julien Rebetez wrote:
> Hi !
> I've writen the following program :
[snip]
> Should I not get a SIGSEV from the system ? Isn't it dangerous to allow 
> the user to put 5 elements in a 4 elements tab?

   This is nothing to do the the kernel. It's to do with C.

   Yes, it is dangerous to allow this behaviour. However, C doesn't
perform bounds checking on arrays -- this is left to the programmer to
ensure that an array is never accessed outside its bounds. The effects
of accessing (reading or writing) an array outside its bounds are
undefined. In this case, it's worked. In other situations, with
different arrays, it may not work.

   Nothing to see here. Move along.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Well, you don't get to be a kernel hacker simply by looking ---   
                    good in Speedos. -- Rusty Russell                    

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAHO9OssJ7whwzWGARAi1hAKCjsgvr0G0FERUTq1veXMdRMvTelACdGE46
F6uADFFfOFfgKDidfqxcZ+U=
=CD1d
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
