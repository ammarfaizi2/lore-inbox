Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313627AbSDPH5K>; Tue, 16 Apr 2002 03:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSDPH5J>; Tue, 16 Apr 2002 03:57:09 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:36163 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S313627AbSDPH5I>; Tue, 16 Apr 2002 03:57:08 -0400
Date: Tue, 16 Apr 2002 09:57:03 +0200
From: Kurt Garloff <garloff@suse.de>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre6aa1 (possible all kernel after 2.4.19-pre2) athlon PCI workaround
Message-ID: <20020416095703.A12012@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Steve Kieu <haiquy@yahoo.com>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020415174059.E2345@nbkurt.etpnet.phys.tue.nl> <20020416064306.91089.qmail@web10407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Tue, Apr 16, 2002 at 04:43:06PM +1000, Steve Kieu wrote:
> I think this is a known problem but it is strange that
> no one bother to implement something to make it easier
> for the end user to compile their own kernel rather
> than seraching the file and edit it.

The reason for the code there was that people had problems without it.
Somebody found some docu from VIA and came up with the patch that is now=20
in the kernel. And it helped those people.

So, it's not that nobody bothers, it's just that we don't want to break
those people's computers.

> Of course I believe my box is not the only one suffering such
> problem.

No, there have been a few reports on LKML.

> > arch/i386/kernel/pci-pc.c:
>=20
> Just after posting my first email, I found the file,
> yes it is in arch/i386/kernel/pci-pc.c and I just
> comment out all lines in struct pci_fixup
> pcibios_fixups[] related to VIA; that is
> PCI_FIXUP_HEADER, PCI_VENDOR_ID_VIA  etc...
>=20
> I have no idea if this affects the system, but it
> seemed that the problem is solved and no thing wierd
> happened yet :-). May be if I got some trouble I will
> set the bit as you said.=20

You complain that no one bothers. The opposite is true:
Hacking solutions that work for some and not for others is just not
acceptable. But that's what you did now.
(Nothing wrong with it, if it helps you. But you don't help finding a
solution that works for everybody.)

> > and claiming that not clearing bit 5 did make the
> > problem go away.
> > (IOW: Replace v &=3D 0x1f; /* clear bits 5, 6, 7 */
> >            by v &=3D 0x3f; /* clear bits 6, 7 */
> >  and see whether this helps.)

It would be intersting to know. Maybe just clearing bits 6 and 7
would make everybody happy?=20
But the docu seems to indicate otherwise and there have not yet been=20
enough reports to be sure.=20

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8u9lOxmLh6hyYd04RAqmmAKCMg2p1tHW83G5ZHYmrNclm03aEmACeIWxJ
Sg+RDd6WMICrxn104xHes44=
=UCRB
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
