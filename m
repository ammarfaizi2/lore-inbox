Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312871AbSDOPlG>; Mon, 15 Apr 2002 11:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312887AbSDOPlF>; Mon, 15 Apr 2002 11:41:05 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:51252 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S312871AbSDOPlE>; Mon, 15 Apr 2002 11:41:04 -0400
Date: Mon, 15 Apr 2002 17:40:59 +0200
From: Kurt Garloff <garloff@suse.de>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre6aa1 (possible all kernel after 2.4.19-pre2) athlon PCI workaround
Message-ID: <20020415174059.E2345@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Steve Kieu <haiquy@yahoo.com>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020413085840.75689.qmail@web10404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 13, 2002 at 06:58:40PM +1000, Steve Kieu wrote:
> This is a known problem I know, the screen problem
> with some athlon computer due to some PCI optimization
> code  etc..; but how can I work around this. For
> 2.4.19-pre2 I remember to go somewhere to find pci.c
> and comment out the code related, but in
> 2.4.19-pre6aa1 I got stuck..
>=20
> Is there an official way to overcome/fix this problem
> ? (kernel build option?) Or just anyone interested in
> doing such job?

I don't know of an "official way".
There were a number of postings refering to
arch/i386/kernel/pci-pc.c: pci_fixup_via_northbridge_bug()
and claiming that not clearing bit 5 did make the problem go away.
(IOW: Replace v &=3D 0x1f; /* clear bits 5, 6, 7 */
           by v &=3D 0x3f; /* clear bits 6, 7 */
 and see whether this helps.)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8uvSLxmLh6hyYd04RAlZnAJwImBIikklinn8Cr1SekCosYRAaRQCdHUbi
ms93MSr9aKy6zw77/+NSQ+w=
=ASui
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
