Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRDQMnP>; Tue, 17 Apr 2001 08:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRDQMnG>; Tue, 17 Apr 2001 08:43:06 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:59500 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132578AbRDQMnA>; Tue, 17 Apr 2001 08:43:00 -0400
Date: Tue, 17 Apr 2001 13:42:57 +0100
From: Tim Waugh <twaugh@redhat.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Is printing broke on sparc ?
Message-ID: <20010417134257.J29490@redhat.com>
In-Reply-To: <Pine.LNX.4.32.0104161752010.18324-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="up2r7mkFEYHJ3y+X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0104161752010.18324-100000@filesrv1.baby-dragons.com>; from babydr@baby-dragons.com on Mon, Apr 16, 2001 at 05:54:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--up2r7mkFEYHJ3y+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2001 at 05:54:41PM -0700, Mr. James W. Laferriere wrote:

> # /etc/printcap
> #
> # Please don't edit this file directly unless you know what you are doing!
> # Be warned that the control-panel printtool requires a very strict forma=
t!
> # Look at the printcap(5) man page for more info.
> #
> # This file can be edited with the printtool in the control-panel.
>=20
> ##PRINTTOOL3## LOCAL POSTSCRIPT 300x300 letter {} PostScript Default {}
> lp:\
> 	:sd=3D/var/spool/lpd/lp:\
> 	:mx#0:\
> 	:sh:\
> 	:lp=3D/dev/lp0:\
> 	:if=3D/var/spool/lpd/lp/filter:
[...]
> /c#eodiecnyotai rhernili s to rpaemn
>                                     s eehpo o-.ROLPR0 roif{\=3Dsl:x
>                                                                  	/p:ao/lr

This looks like characters are getting missed out, rather than
anything getting garbled.  The above characters all appear in
/etc/printcap in the order shown.  Obviously there isn't enough
redundancy in /etc/printcap for the print-out to be useful despite
that. :-)

Please try adjusting the 'udelay (1)' lines in
drivers/parport/ieee1284_ops.c:parport_ieee1284_write_compat to be
larger delays (for example, try replacing the 1s with 2s, or 5s, and
see if that makes things better).

Let me know what you need to change to get it working.

Thanks,
Tim.
*/

--up2r7mkFEYHJ3y+X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63DpRONXnILZ4yVIRArPSAKCg8k4cFKsNQ/7TyOC8r6gI+So0RQCglu1F
juullPUtHxeJWlNiFCSX5vU=
=hePd
-----END PGP SIGNATURE-----

--up2r7mkFEYHJ3y+X--
