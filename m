Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133005AbRDMAzf>; Thu, 12 Apr 2001 20:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132998AbRDMAzY>; Thu, 12 Apr 2001 20:55:24 -0400
Received: from cc265407-a.hwrd1.md.home.com ([24.3.45.174]:51844 "EHLO
	athens.nanticoke.ellicott-city.md.us") by vger.kernel.org with ESMTP
	id <S133005AbRDMAzI>; Thu, 12 Apr 2001 20:55:08 -0400
Date: Thu, 12 Apr 2001 20:53:59 -0400
From: Tim Meushaw <meushaw@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive
Message-ID: <20010412205358.E9569@pobox.com>
In-Reply-To: <20010411225356.A574@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010411225356.A574@pobox.com>; from meushaw@pobox.com on Wed, Apr 11, 2001 at 10:53:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've got an update for this problem I emailled about last night (and for
which I only received one reply :-) ).

Strangely enough, I'm able to actually burn a CD using the cd-rw
described below, and can verify data written to it (using X-CD-Roast).
I still can't actually mount a cd in the drive without getting the error
described below, but at least I can burn CDs now.

Does this behavior sound like a kernel problem, or does it suggest a bug
in the 'mount' utility?

Tim

On Wed, Apr 11, 2001 at 10:53:57PM -0400, Tim Meushaw wrote:
> Hi there.  I just got a new CD-RW drive and am trying to get it working
> under Linux.  I've got the ide-scsi modules all loaded, but have weird
> errors when trying to mount a disk.
>=20
> Here are the messages from "dmesg" that I get when the ide-cd and
> ide-scsi modules are loaded.  My DVD-ROM is /dev/hdc, and the CD-RW is
> /dev/hdd (or /dev/sr0):
>=20
> -----------------------------------------------------
> hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> ide-cd: ignoring drive hdd
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: SONY      Model: CD-RW  CRX160E    Rev: 1.0e
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> -----------------------------------------------------
>=20
> So, it looks like the drive is attached to /dev/sr0 properly.  Then, I
> run "cdrecord -scanbus" to make sure:
>=20
> -----------------------------------------------------
> Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 J=F6rg Schilling
> Linux sg driver version: 3.1.17
> Using libscg version 'schily-0.1'
> scsibus0:
>         0,0,0     0) 'SONY    ' 'CD-RW  CRX160E  ' '1.0e' Removable CD-ROM
> -----------------------------------------------------
>=20
> So, it REALLY looks like it's working.  However, here's what I get when
> I try to mount an ordinary data CD:
>=20
> -----------------------------------------------------
> athens:~# mount -t iso9660 /dev/sr0 /cdrw
> mount: block device /dev/sr0 is write-protected, mounting read-only
> SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code =3D 28000000
> [valid=3D0] Info fld=3D0x0, Current sd0b:00: sense key Hardware Error
> Additional sense indicates Logical unit communication CRC error (Ultra-DM=
A/32)
>  I/O error: dev 0b:00, sector 64
> isofs_read_super: bread failed, dev=3D0b:00, iso_blknum=3D16, block=3D32
> mount: wrong fs type, bad option, bad superblock on /dev/sr0,
>        or too many mounted file systems
> -----------------------------------------------------
>=20
> I've tried this with both kernel 2.4.1 and 2.4.3 and have the exact same
> error.  I've also tried multiple data CDs and have the same messages.
> The CD-RW is a Sony CRX-160E, plugged in to an Asus A7V motherboard (the
> PCI bus is described by "lspci" as "VIA Technologies, Inc. VT8363/8365
> [KT133/KM133 AGP]").  I'm not sure what other information I can provide,
> but I'll be happy to give anything else that might be needed to help fix
> this problem.
>=20
> Thanks a lot!
> Tim
>=20
> --=20
> Timothy A. Meushaw
> meushaw@pobox.com
> http://www.pobox.com/~meushaw/



--=20
Timothy A. Meushaw
meushaw@pobox.com
http://www.pobox.com/~meushaw/

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE61k4mMVO+gCLjJFkRApWtAJ9bvQpI9yo/uLKXEVL3oznIW04dogCgl9ji
CqPGrOq13AnGq4xQfNkJORk=
=N2OD
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
