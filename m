Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131762AbQKWAi0>; Wed, 22 Nov 2000 19:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132190AbQKWAiQ>; Wed, 22 Nov 2000 19:38:16 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:22031 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S131762AbQKWAh4>; Wed, 22 Nov 2000 19:37:56 -0500
Date: Thu, 23 Nov 2000 01:07:12 +0100
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [2.2.17] oops in /proc/scsi/scsi
Message-ID: <20001123010712.C32555@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        linux-kernel@vger.kernel.org,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
In-Reply-To: <20001122020618.A1411@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001122020618.A1411@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Wed, Nov 22, 2000 at 02:06:18AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Wed, Nov 22, 2000 at 02:06:18AM +0100, Matthias Andree wrote:
> I ran that script several times since it did not collect all devices,

Strange.

> and at one time, I got two oopsen that I decoded.
> * dc390 2.0e3

> Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list =
not found in System.map.  Ignoring ksyms_base entry
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
052
> current->tss.cr3 =3D 05463000, %%cr3 =3D 05463000
> EIP:    0010:[sr_finish+112/388]
> Process rescan-scsi-bus (pid: 18301, process nr: 122, stackpage=3Dc267b00=
0)
> Call Trace: [scan_scsis+491/1076] [common_interrupt+24/32] [scan_scsis+55=
9/1076] [get_new_inode+147/312] [vsprintf+720/764] [wake_up_process+64/76] =
[__wake_up+59/68]=20
> Code: 80 48 52 20 a1 ac 99 2a c0 80 4c 18 16 08 a1 ac 99 2a c0 80=20
> Using defaults from ksymoops -t elf32-i386 -a i386
>=20
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
???

While 2.0e3 contains a bug that can cause an OOps inside the driver (just
use the echo "INQUIRY 0" >/proc/scsi/tmscsim/?), the normal bus rescanning
should not be able to trigger it. The above looks like the bug is occuring
somewhere else.
Having said this, I'd like to ask you to try 2.0e6 of the tmscsim driver and
check whether you are able to reproduce the bug.
Thanks!

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6HF+vxmLh6hyYd04RAhWfAJ0dJKRmPBDg069+7MWk3g7rgE+u1gCfblFd
tp1htDn8DtTXuubZPHXMq/I=
=jJNQ
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
