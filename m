Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbRGPIR0>; Mon, 16 Jul 2001 04:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbRGPIRQ>; Mon, 16 Jul 2001 04:17:16 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:26109 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267218AbRGPIRE>; Mon, 16 Jul 2001 04:17:04 -0400
Date: Mon, 16 Jul 2001 03:16:56 -0500
From: J Troy Piper <jtp@dok.org>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib
Message-ID: <20010716031656.D1391@dok.org>
In-Reply-To: <Pine.GSO.4.21.0107160128320.26491-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0107160727520.634-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107160727520.634-100000@tahallah.demon.co.uk>; from alex.buell@tahallah.demon.co.uk on Mon, Jul 16, 2001 at 07:30:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> As it turns out, the extraneous '..' is actually a file. I did a rm ..*,
> which left the original .. directory alone but removed the .. file. Did a
> e2fsck on reboot, no problems found.
>=20

Yes, good to remove the file, but now my main concern is that your system=
=20
may have been compromised as the old ".." dir-not-really file entry may=20
have other connotations.  It is definately a possibility of a cracked=20
system (as the .. file appears in many new r00tkit type exploits.) i would=
=20
do some extensive forensics on the machine in question.  are there new=20
entries in /etc/passwd or /etc/shadow that shouldn't be there? =20

DISCLAIMER - I am not insisting your machine was compromised, but why be=20
lax about it?  Check the system in every way possible to determine if=20
someone has cracked and installed a r00tkit on your box.  just getting rid=
=20
of the single .. entry may not be enough.  look for other suspicious=20
files, keep copies of them before deleting the ones available to the=20
public in /lib or /usr or whatever, and check out any suspicious files=20
that were created/modified/accessed in the same window (5 or 6 minuites)=20
as the double .. entry in /lib

it sounds to me like someone MAY have been trying to replace system lib=20
files, or even perhaps load malicious kernel code in modules.  at my job,=
=20
this system would be immediately taken off the 'production line' until a=20
thorough examination/investigation can be done.  check logins around the=20
ctime of the original .. creation and compare with who was logged in etc=20
etc.

this may be nothing, it may be a nasty kernel bug, or it may be malicious=
=20
hackers attampting to pull the wool over your eyes.

be PARANOID in any situation in which your machine MAY have been=20
compromised and persue the forensic evidence until you hit a titanium
wall (a brick wall can be easily broken down).=20

If you have no idea where to go from here, send me email logs of what has=
=20
been found and i will give it my best shot at determining whether this is=
=20
a kernel bug (which i would assume would've been caught and dealt with by=
=20
now), or a nasty attack involving a rootkit, so the 'attackers' can regain=
=20
access to the system.

Start with "netstat --inet -a" and see if you find any open ports that=20
shouldn't be open.  That would be the first indication of a rootkit that=20
allows the rootkitter (person installing the rootkit) to regain access to=
=20
the system even after it has been 'locked down'. =20

rootkits are well know for leaving SEVERAL backdoors so that if one is=20
found, the attacker still has multiple ways to re-enter and re-penetrate=20
the system.=20

----
J Troy Piper
jtp@dok.org

PS - sorry about the FUD slam about 'the evil cracker' but we all know=20
they DO exist, and the weaker the admin, the easier it is to take=20
advantage of the systems under the admin's control.


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7UqL3Cf6/EIKZzbMRAhmxAKDe6dQv9xlHx/i5L+GAdOq32jDySwCfQr+6
U7PN8S+OESwJZ6diDOpguXg=
=zspi
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
