Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTE0LuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTE0LuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:50:09 -0400
Received: from [212.59.36.210] ([212.59.36.210]:13184 "HELO schottelius.net")
	by vger.kernel.org with SMTP id S263380AbTE0LuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:50:06 -0400
Date: Tue, 27 May 2003 13:29:18 +0200
From: Nico Schottelius <schottelius@wdt.de>
To: satyakumar.y@scandentgroup.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org
Subject: Re: [bug] 2.5.68: USB + renaming/splitting SCSI ?
Message-ID: <20030527112918.GA413@schottelius.org>
References: <OF2A9B6A94.2AB03675-ON65256D33.00210116@scandentgroup.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <OF2A9B6A94.2AB03675-ON65256D33.00210116@scandentgroup.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.70
X-Abuse: try 'Disposition-Notification-To: dev@null.org' in your header.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

satyakumar.y@scandentgroup.com [Tue, May 27, 2003 at 11:33:35AM +0530]:
> recompile the kernel   selecting the
> usb device  file system   option    in   usb support

The problem was I didn't have scsi / scsi_disk support..
Also I forgot to mount usbdevfs (but which is only informative,afai can see=
).

It's a little bit weired to have scsi support for usb discs..
perhaps scsi / scsi_disk should be splitted into _real_ scsi support
and generic modular (block) device support..
like mod_disk, mod_cdrom, mod_tape.=20
What do you think about this ?

Nico

> Hello!
>=20
> When attaching usb devices to my box, no new entries in /dev/ are
> created (tried with usbstick, harddisk in a box)..so I can't acces any
> of them!
>=20
> ------------------
> flapp:/usr # lsmod
> Module                  Size  Used by
> usb_storage            99536  0
> scsi_mod               48132  1 usb_storage
> ohci_hcd               13152  0
> usbcore                73436  4 usb_storage,ohci_hcd
> ...
>=20
> flapp:/usr # ls /dev/usb/
> .  ..
> flapp:/usr # ls /dev/scsi/
> .  ..
>=20
> flapp:/usr # cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: HITACHI_ Model: DK23AA-12        Rev: 0811
>   Type:   Direct-Access                    ANSI SCSI revision: 02
>=20
> (which is the usb harddisk)
>=20
> Or do I have to load the scsi disk driver ?
>=20
> Nico
>=20
> --
> Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt
> mails
> to mailing list!). If you don't know what pgp is visit www.gnupg.org.
> (public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)
> (See attached file: attkklzr.dat)
>=20



--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+00wOtnlUggLJsX0RAmhtAJ9tW1mngoxRO+bTRPCjWfF4iutQowCgoNeF
2cxlvkpyLgPupmFWx4F6jGg=
=P0CA
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
