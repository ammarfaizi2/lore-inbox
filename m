Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267617AbUHRXmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267617AbUHRXmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUHRXmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:42:08 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:61825 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S267621AbUHRXls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:41:48 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Effect of deleting executables of running programs
Date: Wed, 18 Aug 2004 16:41:42 -0700
User-Agent: KMail/1.7
References: <20040818201100.54131.qmail@web11413.mail.yahoo.com>
In-Reply-To: <20040818201100.54131.qmail@web11413.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2940733.JACh8xQHrO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408181641.45314.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2940733.JACh8xQHrO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 18 August 2004 13:11, Shriram R wrote:
> Yes, the nodes were accessing the executable over NFS.

My wild guess is that this has to do with executables paging themselves in =
on=20
demand. In the NFS case, if the file disappears on the share, paging in wil=
l=20
fail. However, on a local filesystem, the inode won't disappear until all=20
users are gone, so paging in on demand will still work.

=2DRyan

--nextPart2940733.JACh8xQHrO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBI+k5W4yVCW5p+qYRAiqDAKDHr1ZuVfg9+Sb7Ax+Yj6eMjGlOygCgtmL/
lL6JVaUe2FiKGTdIjzBNXoU=
=A2f5
-----END PGP SIGNATURE-----

--nextPart2940733.JACh8xQHrO--
