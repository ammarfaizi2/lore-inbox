Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJDEB2>; Fri, 4 Oct 2002 00:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJDEB2>; Fri, 4 Oct 2002 00:01:28 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:9414 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S261474AbSJDEB1>; Fri, 4 Oct 2002 00:01:27 -0400
Date: Fri, 4 Oct 2002 07:05:03 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004040503.GH15215@actcom.co.il>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003225842.GA79989@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="csjV5iuXLa65tnQH"
Content-Disposition: inline
In-Reply-To: <20021003225842.GA79989@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--csjV5iuXLa65tnQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2002 at 11:58:42PM +0100, John Levon wrote:

> Sort of. They've broken IA64 oprofile, and they seem not to care.

They've also broken syscalltrack, and I'll be surprised if they care.=20

Would someone please explain to me why a mechanism which *is* safe
under certain circumstances[1] is removed *without any suitable
alternative for modules*[2], just because it's "ugly"? We've had this
discussion before, numerous times. Ref:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101820103913072&w=3D2=20

I agree that it should not be done. I maintain that sometimes, if you
want to keep your code as a module only (because forcing users to
recompile their kernel is not a viable solution) it can be done safely
if you observe certain precautions and your architecture supports
it[3]. So why remove it?=20

[1]
http://marc.theaimsgroup.com/?l=3Dkernelnewbies&m=3D102267164910800&w=3D2,=
=20
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101821127019203&w=3D2

[2] Can the LSM hooks be used for notification and modification on
every system call's entry and exit? =20

[3] I'd like to know if I'm wrong, of course.=20
--=20
Muli Ben-Yehuda					http://www.mulix.org/=09
mulix@mulix.org:~$ sctrace strace /bin/foo 	http://syscalltrack.sf.net/
Quis custodes ipsos custodiet?

--csjV5iuXLa65tnQH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9nRNvKRs727/VN8sRAj/kAKCxwhbntTEn6mX8vJy0WMo6s4AjnACfWcjf
q5JozIAeEm94AIXjb+rqbqA=
=IgGA
-----END PGP SIGNATURE-----

--csjV5iuXLa65tnQH--
