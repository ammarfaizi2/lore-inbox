Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVAIBI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVAIBI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVAIBI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:08:29 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:60049 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262175AbVAIBIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:08:20 -0500
Subject: [PATCH] Security-Enhanced Linux back port for 2.4 rev.0.3
	(20050108)
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@epoch.ncsc.mil>,
       russell@coker.com.au
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6ftTo+bNs4wShzrD8VQz"
Date: Sun, 09 Jan 2005 02:07:35 +0100
Message-Id: <1105232856.24876.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6ftTo+bNs4wShzrD8VQz
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

During the past week, I've progressively worked on the back porting of
the latest features and fixes applied to 2.6 SELinux-related code, so,
we can now make use of them in 2.4.

I know that 2.4 is in maintenance mode, but this was mainly just for my
own fun and learning profit, even if there are some technical reasons to
do it.

Documentation and tracking is available at:
http://selinux.tuxedo-es.org/2.4-backport/

The patches can be retrieved by checking out the 2.4-backport module in
the SELinux CVS at SourceForge.Net:

http://cvs.sourceforge.net/viewcvs.py/selinux/2.4-backport/

Under ./pre-patches/ you can find the latest patches that are not yet
stable:
http://cvs.sourceforge.net/viewcvs.py/selinux/2.4-backport/pre-patches/

ASAP i will try to validate it's capabilities and see what's working and
what's not, and this will happen after i solve some personal
infrastructure problems.

The BTS at http://selinux.tuxedo-es.org/tracking/ should be used to
report bugs and so on.
I would appreciate a lot any type of help, testing would be surely
appreciated, and any type of feedback would be good too (even if you
want to say it's crap, which i don't think so ;) ).

If there's someone that made this possible, it's Stephen D. Smalley
which helped me giving me his attention and time to solve my extensive
lack of knowledge and skills.

Also i want to say thanks to Russell Coker from Red Hat for giving me
access to a testing machine where i can run out the back port kernel
patches, and also for helping me when understanding how the SELinux
policy works.

Currently, I'm researching on a possible bug introduced by an incorrect
back porting of the latest anonymous memory mappings control features.
Also, dynamic context transitions and mount contexts are not supported
because of lack of some code that makes me almost unable to back port
them without doing extra, geekish, hacking in the kernel core and memory
management stuff (help really welcome).

In short, the back port is now fully supporting up to v18 policies which
includes almost the Netlink classes (not fully back ported support, even
for ipv6 and some other things may be not fully supported as well) and
the policy booleans, etc (v15->v17).

Those who are using or testing the 0.2 revision are encouraged to move
to latest 0.3 pre-patches, as a kernel oops due to inexistent (and
superfluous) SLAB_PANIC handling has been solved since past 0.2
revisions.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager
http://www.tuxedo-es.org - http://lorenzo.debian-hardened.org

--=-6ftTo+bNs4wShzrD8VQz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB4IPXDcEopW8rLewRAufYAKCVQsUZucpcPgIWqFQE95j4730D5ACfSZEJ
C2zD6RFUH589QwF6a9KW03M=
=QVwf
-----END PGP SIGNATURE-----

--=-6ftTo+bNs4wShzrD8VQz--

