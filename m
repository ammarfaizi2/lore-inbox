Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUAKMcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUAKMcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:32:16 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:48841 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265802AbUAKMcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:32:13 -0500
Date: Sun, 11 Jan 2004 13:32:08 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111123208.GA4766@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net> <20040111120053.C1931@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20040111120053.C1931@flint.arm.linux.org.uk>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for taking the time to reply!

also sprach Russell King <rmk+lkml@arm.linux.org.uk> [2004.01.11.1300 +0100=
]:
> >   Orinico Wireless LAN (wvlan_cs)
> >   3COM 3c575 (3c575_cs)
> >   Psion Gold Card Modem (serial_cs)
>=20
> What is 3c575_cs ?  I think you actually mean 3c574_cs.  Or maybe you
> mean you have a 3com 3ccfe575 Cardbus card?  The above is rather too
> ambiguous.

The card is a 3CCFE575BT-D. Under 2.4 with Hinds' pcmcia-cs modules,
the driver was called 3c575_cs. Under 2.6 with the kernel drivers,
only 3c574_cs exists. I assumed that 3c574_cs would also support the
3c575_cs, but I guess I am wrong.

A 3CCFE574BT works just fine with 574_cs (although upon removal,
ifconfig will hang in the 'D' state forever. I guess that's
a separate issue though. I will research this and post another time.

> > However, the 3c575 card won't be recognised. All
> > I get from the hotplug system is:
> >=20
> >   pci.agent: ... no modules for PCI slot 0000:06:00.0
>=20
> This indicates that the card you inserted is a Cardbus card.  In which
> case, the PCMCIA driver "3c574_cs" is definitely not what you want.
> You want to use the 3c59x driver, though the hotplug subsystem should
> automatically pick that up from the PCI ids.

Interesting. Well, I do not have 3c59x compiled in the kernel.
I shall do this and find out.

> Could you insert the card, and then provide the output of lspci -vx ?

ftp://ftp.madduck.net/scratch/3c575-lspci.gz [1.5Kb]

Thanks for your time!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
until lions have their historians,
tales of the hunt shall always glorify the hunter.
                                                    -- african proverb

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAUJIIgvIgzMMSnURAiBoAJ94ICcHzWrmPzDTR88m9Nk7+7gT1QCgzrZi
ce74Xcbg1U/T+O3rIQepLMY=
=EvYZ
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
