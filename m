Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVIWVlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVIWVlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVIWVlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:41:03 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:60090 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932067AbVIWVlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:41:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:reply-to:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to;
        b=q6spF8s5SeVgKWSs5W+tVtm+f/MCeeKEZvZmpV8RtW1E3xFhFMhGCmafX313FwOEwoZooG/EU1Q7AxynTlEeKq3fZWg3DK+J9R4C0whpz+XC9KPr6lX+TiwYLEkMcUnIC7RBVSk/EEstORM1jgEsyy+ripQcYpYW/UjIqGf115g=
Date: Fri, 23 Sep 2005 23:40:57 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Arnaud Boulan <arnaud.boulan@libertysurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs problem after usb hard drive disconnected
Message-ID: <20050923214057.GA15047@pc2>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: Arnaud Boulan <arnaud.boulan@libertysurf.fr>,
	linux-kernel@vger.kernel.org
References: <200509232121.52803.arnaud.boulan@libertysurf.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <200509232121.52803.arnaud.boulan@libertysurf.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arnaud Boulan <arnaud.boulan@libertysurf.fr> wrote:
| Hello,
|=20
| I am using an external USB hard drive, and i hit a bug in the reiserfs co=
de=20
| after the drive got disconnected by a power problem. You can see this in =
the=20
| attached logs.
| The disconnection of the hard drive was not done manually, it has been=20
| offlined "spontaneously" by what seems to be a power loss. In fact, i sus=
pect=20
| i have bad power at home since i have had other similar problems with ano=
ther=20
| device (an usb tv tuner)
|=20
| However, i already have disconnected my drive manually a few times by mis=
take,
| and i always recovered from that by unmouting, running reiserfsck and=20
| remounting the device.
|=20
| This time, although i can consider it is a hardware problem, it would hav=
e=20
| been nice if the kernel had also recovered from the USB problem. Instead,=
 i=20
| couldn't unmount the filesystem and the usb stack was stucked, leaving no=
=20
| choice but to reboot...
|=20

   Same problem here. Power went down and I had no other choice than to
   reboot. FS(ext3) got recovered almost completely but some page
   writes were lost. I were unable to unmount the disk too. I guess this
   is more a usb storage problem than a fs one (?)=20


Sep 22 09:57:46 pc2 kernel: scsi0 (0:0): rejecting I/O to dead device
Sep 22 09:57:46 pc2 kernel: Buffer I/O error on device sda1, logical
block 24884044
Sep 22 09:57:46 pc2 kernel: lost page write due to I/O error on sda1
Sep 22 09:57:46 pc2 kernel: scsi0 (0:0): rejecting I/O to dead device
Sep 22 09:57:46 pc2 kernel: journal_bmap: journal block not found at
offset 3144 on sda1
Sep 22 09:57:46 pc2 kernel: Aborting journal on device sda1.
Sep 22 09:57:46 pc2 kernel: scsi0 (0:0): rejecting I/O to dead device
Sep 22 09:57:46 pc2 kernel: Buffer I/O error on device sda1, logical
block 527
Sep 22 09:57:46 pc2 kernel: lost page write due to I/O error on sda1
Sep 22 09:58:13 pc2 kernel: ext3_abort called.
Sep 22 09:58:13 pc2 kernel: EXT3-fs error (device sda1):
ext3_journal_start_sb: Detected aborted journal
Sep 22 09:58:13 pc2 kernel: Remounting filesystem read-only


 Mateusz

--=20
  @..@   Mateusz Berezecki=20
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808=20
^^ ~~ ^^

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNHZpp4YOfsmwOwcRAlKSAJ0T1eAnT97ONpKfFHKKyld6xxNOawCfaOy6
eP4DEFthmOlTIxaOFnTGtnU=
=MFcC
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

