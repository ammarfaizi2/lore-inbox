Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSJDEtz>; Fri, 4 Oct 2002 00:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbSJDEtz>; Fri, 4 Oct 2002 00:49:55 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:26601 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S261483AbSJDEty>; Fri, 4 Oct 2002 00:49:54 -0400
Date: Fri, 4 Oct 2002 07:53:29 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004045329.GI15215@actcom.co.il>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003225842.GA79989@compsoc.man.ac.uk> <20021004040503.GH15215@actcom.co.il> <20021004044652.GA3556@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="to+bXLvrczl8f0V1"
Content-Disposition: inline
In-Reply-To: <20021004044652.GA3556@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--to+bXLvrczl8f0V1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2002 at 09:46:53PM -0700, Greg KH wrote:
> On Fri, Oct 04, 2002 at 07:05:03AM +0300, Muli Ben-Yehuda wrote:
> >=20
> > http://marc.theaimsgroup.com/?l=3Dkernelnewbies&m=3D102267164910800&w=
=3D2,=20
>=20
> You didn't read my post to that same thread did you:
>
> http://marc.theaimsgroup.com/?l=3Dkernelnewbies&m=3D102130770415962

I did, and considered using LSM, but decided not to since, as you
mention below, it doesn't give me the capabilities I need.=20

> And for the most part, the people on kernelnewbies have given up on
> trying to explain to new people why this does not work.  I know I sure
> have :)

As I've written, I maintain that it does work on *some* archs (atomic
pointer updates are required) and with certain precautions (no module
unload).=20

> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101821127019203&w=3D2
> >=20
> > [2] Can the LSM hooks be used for notification and modification on
> > every system call's entry and exit? =20
>=20
> No.  See the LSM mailing list archives for why we did not decide to do
> this.  (hint, you don't really achieve what you want to by doing
> this.)

Well, since I want to hook every system call, I get exactly what I
want ;-)

I'm not doing access policies or security. I'm doing "who is deleting
my file?" and "who is calling settimeoday on my router once in a blue
moon.", and even "if process foo calls getpid(), tell it's actually
process bar".=20

> If you _really_ want to hook things like this, look at LTT or dprobes.
> They should work just fine for you.

Neither is in the core kernel (AFAIK), and I'm not sure how useful
they are for a module only solution. I'll take a look, though.=20

Thanks,=20
Muli.=20
--=20
Muli Ben-Yehuda					http://www.mulix.org/=09
mulix@mulix.org:~$ sctrace strace /bin/foo 	http://syscalltrack.sf.net/
Quis custodes ipsos custodiet?

--to+bXLvrczl8f0V1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9nR7JKRs727/VN8sRAhYqAKC4nTqkBOS75lP2KpUUDtdCtzv6DACbB3j4
I1QNxTwp9HnxH5WwZCGCXA4=
=7apz
-----END PGP SIGNATURE-----

--to+bXLvrczl8f0V1--
