Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280948AbRKLT1Y>; Mon, 12 Nov 2001 14:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280944AbRKLT1Q>; Mon, 12 Nov 2001 14:27:16 -0500
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:52496
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S280948AbRKLT1B>; Mon, 12 Nov 2001 14:27:01 -0500
Date: Mon, 12 Nov 2001 11:26:58 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Message-ID: <20011112112658.A4770@one-eyed-alien.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 12, 2001 at 11:01:56AM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just as a heads-up for interested people... this kernel does contain the
final fixes for the Freecom adaptor, even tho it's not listed.

Matt

On Mon, Nov 12, 2001 at 11:01:56AM -0800, Linus Torvalds wrote:
>=20
> Ok, this kernel hopefully contains all the high-priority merges with Alan,
> which means that as far as that is concerned, I'm done with 2.4.x and
> ready to pass it on to Marcelo.
>=20
> Which means that I'd also like people to double-check that there are no
> embarrassing missing pieces due to the merge (or other patches).
>=20
> Known issue: Al Viro fixed the nasty overflow with /proc/cpuinfo and
> multiple CPU's, but only for x86. So other architectures need to convert
> from the old "get_cpuinfo()" to the seq-file-based "show_cpuinfo()". The
> conversion should be pretty mindless and straightforward.. (ie use
> "seq_printf()"  instead of "sprintf()" etc - see arch/i386/kernel/setup.c
> for the example code).
>=20
> Changelog appeded,
>=20
> 		Linus
>=20
> -----
> pre4:
>  - Mikael Pettersson: make proc_misc happy without modules
>  - Arjan van de Ven: clean up acpitable implementation ("micro-acpi")
>  - Anton Altaparmakov: LDM partition code update
>  - Alan Cox: final (yeah, sure) small missing pieces
>  - Andrey Savochkin/Andrew Morton: eepro100 config space save/restore ove=
r suspend
>  - Arjan van de Ven: remove power from pcmcia socket on card remove
>  - Greg KH: USB updates
>  - Neil Brown: multipath updates
>  - Martin Dalecki: fix up some "asmlinkage" routine markings
>=20
> pre3:
>  - Alan Cox: more driver merging
>  - Al Viro: make ext2 group allocation more readable
>=20
> pre2:
>  - Ivan Kokshaysky: fix alpha dec_and_lock with modules, for alpha config=
 entry
>  - Kai Germaschewski: ISDN updates
>  - Jeff Garzik: network driver updates, sysv fs update
>  - Kai M=E4kisara: SCSI tape update
>  - Alan Cox: large drivers merge
>  - Nikita Danilov: reiserfs procfs information
>  - Andrew Morton: ext3 merge
>  - Christoph Hellwig: vxfs livelock fix
>  - Trond Myklebust: NFS updates
>  - Jens Axboe: cpqarray + cciss dequeue fix
>  - Tim Waugh: parport_serial base_baud setting
>  - Matthew Dharm: usb-storage Freecom driver fixes
>  - Dave McCracken: wait4() thread group race fix
>=20
> pre1:
>  - me: fix page flags race condition Andrea found
>  - David Miller: sparc and network updates
>  - various: fix loop driver that thought it was part of the VM system
>  - me: teach DRM about VM_RESERVED
>  - Alan Cox: more merging
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

SP: I sell software for Microsoft.  Can you set me free?
DP: Natural Selection says I shouldn't.
					-- MS Salesman and Dust Puppy
User Friendly, 4/2/1998

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78CKCz64nssGU+ykRAoMgAKCt/2CX0M+fMwsPfHDLfSqNmg3SWQCfYUfj
hEpZECztnEp1c2i+MBTF7VU=
=jRSq
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
