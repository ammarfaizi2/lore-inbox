Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274720AbRIUAhc>; Thu, 20 Sep 2001 20:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274721AbRIUAhW>; Thu, 20 Sep 2001 20:37:22 -0400
Received: from eris.chemlab.org ([209.114.165.235]:29583 "EHLO eris")
	by vger.kernel.org with ESMTP id <S274720AbRIUAhC>;
	Thu, 20 Sep 2001 20:37:02 -0400
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
From: "steve j. kondik" <shade@chemlab.org>
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: Jari Ruusu <jari.ruusu@pp.inet.fi>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010920145950.I16647@alcove.wittsend.com>
In-Reply-To: <1000912739.17522.2.camel@discord>
	<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
	<3BA9DC30.DA46A008@pp.inet.fi> <20010920142555.B588@suse.de>
	<1000991848.569.1.camel@discord> <3BAA21B1.B579D368@pp.inet.fi>
	<1001006425.1498.9.camel@discord> <3BAA2D7F.DBBCFC8C@pp.inet.fi> 
	<20010920145950.I16647@alcove.wittsend.com>
X-Mailer: Evolution/0.13.99 (Preview Release)
Date: 20 Sep 2001 20:36:53 -0400
Message-Id: <1001032613.31730.3.camel@eris>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_eris-15138-1001032613-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_eris-15138-1001032613-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

agreed.  i've had this problem on two seperate systems, however i _am_
running a few other patches- notably the kpreempt patch.  but again, no
problems at all until 2.4.10-pre12.  i'll try some things in the morning
and see what i can come up with.  i see you are doing swapon, however
have you tried mkswap over your loopdev?  i can actually swapon just
fine, its mkswap that causes the panic. =20


On Thu, 2001-09-20 at 14:59, Michael H. Warfield wrote:
> On Thu, Sep 20, 2001 at 08:55:11PM +0300, Jari Ruusu wrote:
> > "steve j. kondik" wrote:
> > > hmm?  both cryptoapi and loop-aes work just fine when encrypting
> > > anything but swap.  this is _only_ with kernel 2.4.10-pre12.  i would
> > > suspect something changed that breaks swap on loopdev in general in t=
his
> > > kernel.
>=20
> > loop-AES encrypted swap works just fine on 2.4.10-pre12, see:
>=20
> 	But that's only your system.  He obvious has a counter example
> (which may not be the fault of loop-AES, but something else, that has
> yet to be determined).  So the two of you are now reduced to figuring
> out why his is broken as yours is not.  Standard debugging situation.
>=20
> > # uname -a
> > Linux debian 2.4.10-pre12 #1 Thu Sep 20 20:15:08 EEST 2001 i686 unknown
> > # vmstat=20
> >    procs                      memory    swap          io     system    =
     cpu
> >  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us=
  sy  id
> >  0  0  1   4708   2708   1824  12856  19  28   682   623  223   119   5=
  74  21
> > # swapon -s
> > Filename                        Type            Size    Used    Priorit=
y
> > /dev/loop6                      partition       191512  4704    -1
> > # losetup /dev/loop6
> > /dev/loop6: [0301]:170184 (/dev/hda2) offset 0, AES encryption
>=20
> > Regards,
> > Jari Ruusu <jari.ruusu@pp.inet.fi>
>=20
> 	Mike
> --=20
>  Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
>   (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mh=
w/
>   NIC whois:  MHW9      |  An optimist believes we live in the best of al=
l
>  PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."


--=_eris-15138-1001032613-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7qoulq7nxKnD1kxkRAnbSAJ0YBMiyuMYz3O+nbwN4lwC3bnCdMQCfZJWg
y2w1GnOxrhOhlAZI1nR4/Sg=
=mrzx
-----END PGP SIGNATURE-----

--=_eris-15138-1001032613-0001-2--
