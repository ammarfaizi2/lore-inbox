Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVHJVux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVHJVux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVHJVux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:50:53 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:36879 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1030291AbVHJVuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:50:52 -0400
Date: Wed, 10 Aug 2005 23:50:32 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with usb-storage and /dev/sd?
Message-ID: <20050810215032.GA27982@irc.pl>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050810192243.GA620@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20050810192243.GA620@DervishD>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2005 at 09:22:43PM +0200, DervishD wrote:
>     If I plug my MP3 player (USB), the usb-storage module assigns it
> device /dev/sda, which is right because I have it configured as such
> in my /etc/fstab. Well, another day, another boot and I plug my USB
> memory stick, and usb-storage assigns it device /dev/sda, quite cool
> because I have it configured as such in my /etc/fstab, too.
>=20
>     The problem is that if I plug my USB memory, unplug it and plug
> my MP3 player, it gets /dev/sdb this time, not /dev/sda. The mess is
> even greater if I plug my card reader, which has four LUN's...

 That's what udev is for. Example rule to give my memory stick
persistent name:

BUS=3D"usb", SYSFS_serial=3D"5B4B06010122", NAME=3D"pendriveZDZ%n", GROUP=
=3D"floppy", MODE=3D"0662", RUN+=3D "/sbin/udev_run_hotplugd"

 Go figure how to udev-enable your distribution.

--=20
Tomasz Torcz               "Never underestimate the bandwidth of a station
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFC+naoThhlKowQALQRAg0UAJwLBTNn1lAi3FfkpPA7O00NhWfexgCeJ0Jg
etNj+nS9++CDOb6+9i+CMvI=
=SHBe
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
