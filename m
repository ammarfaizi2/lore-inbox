Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131559AbQLWDbU>; Fri, 22 Dec 2000 22:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132000AbQLWDbK>; Fri, 22 Dec 2000 22:31:10 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:60429 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S131559AbQLWDa7>; Fri, 22 Dec 2000 22:30:59 -0500
Date: Sat, 23 Dec 2000 03:58:13 +0100
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: tmscsim (DC390/AM53C974) SCSI driver 2.0f
Message-ID: <20001223035813.I17117@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan, Linus,

I'd like to sync my 2.0f version of the tmscsim (Tekram DC390/AM53C974)
Linux SCSI driver with both 2.2.19 and 2.4.0 mainstream kernels.

I did not sync with you more often, as I was always reported a problem or
finding one myself, when I was wanting to release the next version into the
kernel. And SCSI drivers are somewhat delicate ... so I decided to have all
open issues fixed, before submitting the driver to you.
(Same reason, why I don't ask for inclusion of the Tekram DC395 driver,
 which is also available from my web pages.)

I do believe it's time for submission now, as there is no open issue left.
Testers all reported success :-)

Unfortunately, I did not get around implementing the new SCSI error handling
in the driver. This is on my agenda though.

Bugs fixed / Features added:
* lots of cleanups: splitted sync nego handling in separate functions,
  tag handling, ...
* reset SYNC_NEGO_DONE after bus reset, so it's renegotiated
* removed copying of the CmdBlock
* don't retry timed out cmnds (broke scanners ... )
* dump special command (for debugging)
* return residual count for sg3 [2.4]
* pci_enable_device () [2.4]
* use dev_id for IRQ registering
* act correctly when INQUIRY is used for device scan [2.4]
* only negotiate sync, if INQUIRY reported the ability to do so
  (sigh, it should always work, but there are broken scanners and
   SCSI-1 devices out there)
* __setup (tmscsim=3D, dc390_setup) [2.4]
* allow cmd line parameters override SCSI Bios settings

I apologize for the diffs: There have been indenting changes, which make the
diffs hardly readable.=20
I'll send you diffs against 2.2.18 and 2.4.0-test12 in private mail.

Please apply!

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations <k.garloff@phys.tue.nl>   [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6RBTExmLh6hyYd04RArrJAJ9oG4299BAljeebI0OIKpTZZQvtGgCeJBOq
ggHUllb0tx5oZvNCfS4aLr8=
=5PfX
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
