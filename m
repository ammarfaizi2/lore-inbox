Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRD3EON>; Mon, 30 Apr 2001 00:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133047AbRD3EOE>; Mon, 30 Apr 2001 00:14:04 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:53255
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S132636AbRD3ENw>; Mon, 30 Apr 2001 00:13:52 -0400
Date: Sun, 29 Apr 2001 21:13:46 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mounting an external USB host-powered ZIP 250 drive hangs in mount()
Message-ID: <20010429211346.A8349@one-eyed-alien.net>
Mail-Followup-To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20010429075856.A821@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010429075856.A821@middle.of.nowhere>; from thunder7@xs4all.nl on Sun, Apr 29, 2001 at 07:58:56AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I see you're using the alternate uhci driver... are hte results the same
with the other UHCI driver?

Can you turn on usb mass storage verbose debuggig (compile option) and then
send me the logs?

Matt

On Sun, Apr 29, 2001 at 07:58:56AM +0200, thunder7@xs4all.nl wrote:
> I cannot seem to mount my external USB host-powered 250 Mb zip-drive in
> Linux-2.4.3-ac12. This is a freshly rebooted machine, rebooted with the
> zip-drive attached and a zip-disk inside that Windows-2000 will read
> without problems.
>=20
> dmesg:
> uhci.c: USB UHCI at I/O 0xc400, IRQ 7
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> uhci.c: USB UHCI at I/O 0xc800, IRQ 7
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 240k freed
> hub.c: USB new device connect on bus1/1, assigned device number 2
> scsi1 : SCSI emulation for USB Mass Storage devices
>   Vendor: IOMEGA    Model: ZIP 250           Rev: 61.T
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
> sda : READ CAPACITY failed.
> sda : status =3D 1, message =3D 00, host =3D 0, driver =3D 08=20
> sda : extended sense code =3D 2=20
> sda : block size assumed to be 512 bytes, disk size 1GB. =20
>  sda: I/O error: dev 08:00, sector 0
>  unable to read partition table
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> IRQ 7 is an unshared IRQ.
> I've read that the 'READ CAPACITY failed' indicates there is no disk
> in the drive - but there is.
>=20
>=20
> /proc/scsi/usb-storage-0/1:
>    Host scsi1: usb-storage
>        Vendor: Iomega
>       Product: USB Zip 250
> Serial Number: 003240BCC4D11622
>      Protocol: Transparent SCSI
>     Transport: Bulk
>          GUID: 059b0032003240bcc4d11622
>=20
> All seems fine, but when I do
>=20
> mount /dev/sda4 /mnt
>=20
> the whole kernel hangs, including the keyboard and the network.
> Windows-2000 on the same hardware can access the device. If I strace the
> mount progress, it hangs in
>=20
> mount("/dev/sda4", "/mnt", "vfat", 0xc0ed000, 0
>=20
> I've searched the web, searched the mailing lists at usb/sourceforge,
> and I seem to be alone in this.
>=20
> Hardware:
>=20
> Abit VP6, dual P3/866
> 512 Mb memory
> gcc-2.95.3
> SuSE 7.1 basis
> linux-2.4.3-ac12
>=20
> Kernel config:
>=20
> CONFIG_USB=3Dy
> CONFIG_USB_UHCI_ALT=3Dy
> CONFIG_USB_STORAGE=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DEBUG_QUEUES=3Dy
> CONFIG_SCSI_MULTI_LUN=3Dy
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_SYM53C8XX=3Dy
> CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=3D4
> CONFIG_SCSI_NCR53C8XX_MAX_TAGS=3D32
> CONFIG_SCSI_NCR53C8XX_SYNC=3D20
> CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=3Dy
>=20
> I thought that would do the trick?
>=20
> Thanks for any help that prevents me from rebooting into Windows-2000
> every time!
>=20
> Jurriaan
> --=20
> I have transcended that phase in my intellectual growth where I discover
> humour in simple freakishness. What exists is real, therefore it is tragi=
c,
> since whatever lives must die. Only fantasy, the vapors rising from sheer
> nonsense, can now excite my laughter.
> 	Jack Vance - Lyonesse II - The Green Pearl
> GNU/Linux 2.4.3-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.05 0.03 0.00

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Way to go, lava boy.
					-- Stef to Greg
User Friendly, 3/26/1998

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67OZ5z64nssGU+ykRAq2yAJ9z8XhjJLkAnqzos/X63Zxh5KV5mACgx25c
aSrx40nfcOvpSi7ZKA00ehg=
=T03X
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
