Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUAFLTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 06:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUAFLTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 06:19:49 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:49354 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261898AbUAFLTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 06:19:46 -0500
Date: Tue, 6 Jan 2004 12:19:39 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040106111939.GA2046@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have an ancient laptop with a yenta_socket PCMCIA bridge and three
cards, each with Hinds' pcmcia-cs driver indicated:

  Orinico Wireless LAN (wvlan_cs)
  3COM 3c575 (3c575_cs)
  Psion Gold Card Modem (serial_cs)

I have compiled a 2.6.0 kernel with the following relevant options:

  CONFIG_PCMCIA=3Dy
  CONFIG_YENTA=3Dy
  CONFIG_CARDBUS=3Dy
  CONFIG_HOTPLUG_PCI=3Dy
  CONFIG_PCMCIA_HERMES=3Dm
  CONFIG_NET_PCMCIA=3Dy
  CONFIG_PCMCIA_3C574=3Dm
  CONFIG_SERIAL_8250=3Dm
  CONFIG_SERIAL_8250_CS=3Dy

Furthermore, I installed the following relevant software packages:

ii  pcmcia-cs      3.2.5-2        PCMCIA Card Services for Linux
ii  hotplug        0.0.20031013-2 Linux Hotplug Scripts

I can get the Orinico card working just fine, and the modem is also
detected perfectly. However, the 3c575 card won't be recognised. All
I get from the hotplug system is:

  pci.agent: ... no modules for PCI slot 0000:06:00.0

and that's whether I put "3c574_cs" into the $DRIVERS list of
/etc/hotplug/pci.agent  or not.

What's going on? Is the 3c575 not supported by 3c574_cs? Is there
any way to get this card working?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"convictions are more dangerous enemies of truth than lies."
                                                 - friedrich nietzsche

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+pnLIgvIgzMMSnURAmgVAKDgbPx9rhP8gGw9QDnTVJtNRBIUlQCbBfod
Yuzw6YT5u72yB1BypfJh4OQ=
=YHou
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
