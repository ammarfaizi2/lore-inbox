Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbTL3MDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTL3MDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 07:03:13 -0500
Received: from dsl-217-155-72-205.zen.co.uk ([217.155.72.205]:7692 "EHLO
	nicole.computer-surgery.co.uk") by vger.kernel.org with ESMTP
	id S265765AbTL3MDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 07:03:09 -0500
Date: Tue, 30 Dec 2003 12:02:37 +0000
To: Christophe Saout <christophe@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] oops in lvm or raid
Message-ID: <20031230120237.GA13811@computer-surgery.co.uk>
References: <20031229145936.GA19936@computer-surgery.co.uk> <1072718170.5152.130.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <1072718170.5152.130.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
X-GPG-Fingerprint: ADAD DF3A AE05 CA28 3BDB  D352 7E81 8852 817A FB7B
X-GPG-Key: 1024D/817AFB7B (wwwkeys.uk.pgp.net)
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 06:16:10PM +0100, Christophe Saout wrote:
> Am Mo, den 29.12.2003 schrieb Roger Gammans um 15:59:
>=20
> > Dec 29 13:15:23 turin kernel: lvm -- giving up to snapshot /dev/rootvg/=
data_root on /dev/rootvg/data_20031218: out of spa
> > Dec 29 13:15:23 turin kernel: Unable to handle kernel paging request at=
 virtual address 00015618
> > Dec 29 13:15:23 turin kernel:  printing eip:
> > Dec 29 13:15:23 turin kernel: c4847a7c
> >                               c4847a7c -> lvm_snapshot_remap_block (c48=
47a0c)
> >
> > This is a stock kernel (bf2.4) from debian stable (Version: 2.4.18-5)
>=20
> LVM1 snapshotting in the plain 2.4.18 kernel is known to have bugs.

Ah. Ok.
But to be honest I could have (and indeed should have) deleted the sanpshot=
=20
before doing the write to the volume which caused the snapshot ot=20
run out of space. As long as the snapshot intergrity is good I'm happy.

My real worry is taht this was triggered by a raid problem and we've got
serious data corruption in both the ext3 and lvm metadata.

> You should upgrade to the latest LVM 1.0.8 kernel code. Well, I can't
> access the Sistina website at the moment. I'm sure you can find a
> lvm_1.0.8.tar.gz (or lvm_1.0.7.tar.gz which also has most bugs fixed)
> somewhere.

The site seems to be back now.

> [snip]=20
> Or you can upgrade to the 2.4.23 kernel, I think it contains the LVM
> 1.0.7 code.

Ok. We need to make some sort of decision here about what kernel to use
then there has been an degree of discusson about exactly how
conservative we should be anyway . Does 2.4.23 have the vfs-locking
patch ?

TTFN
--=20
Roger. 	                        Home| http://www.sandman.uklinux.net/
Master of Peng Shui.      (Ancient oriental art of Penguin Arranging)
Work|Independent Sys Consultant | http://www.computer-surgery.co.uk/
So what are the eigenvalues and eigenvectors of 'The Matrix'? --anon

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/8WldfoGIUoF6+3sRAht1AKC9Zml66AfP3tdTQOfwFm5w/eAlxwCfdA/F
dbgxfFLzmo01th57/G0iVuk=
=HHcR
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
