Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRCKX4F>; Sun, 11 Mar 2001 18:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRCKXzq>; Sun, 11 Mar 2001 18:55:46 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:36361 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129274AbRCKXzk>; Sun, 11 Mar 2001 18:55:40 -0500
Date: Mon, 12 Mar 2001 00:44:01 +0100
From: Kurt Garloff <kurt@garloff.de>
To: 陳王展 <cwz@aic.ee.ndhu.edu.tw>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: About DC-315U scsi driver
Message-ID: <20010312004401.H2697@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	陳王展 <cwz@aic.ee.ndhu.edu.tw>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <20010311163710.11a86b52.cwz@aic.ee.ndhu.edu.tw>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010311163710.11a86b52.cwz@aic.ee.ndhu.edu.tw>; from cwz@aic.ee.ndhu.edu.tw on Sun, Mar 11, 2001 at 04:37:10PM +0800
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 11, 2001 at 04:37:10PM +0800, =B3=AF=A4=FD=AEi wrote:
> The driver has not to be included in officeal kernel.

Yes, that's what I tell people that ask me to submit the driver from
inclusion. The reason are strange problems, which unfortunately I have not
been able to track down, yet. Fortunately, they don't happen for everyone.
Unfortunately, that means I can't reproduce most of them.

I added quite some debugging feature to the driver, like a complete history
of every SCSI command being kept and output if something goes wrong
(_abort()). I guess, a good chipset docu would give more insight.

> And the maintainer has not updated the driver from 2.4.0-test9-pre7.
> Maybe he is very busy.The last update is 2000-12-03.

I'm quite busy, that's true.
The driver 1.32 (Dec 3 2000) can be used with 2.4.2. Just ignore the
patch rejection in the file MAINTAINERS.

> I used some kernels from 2.4.0 to 2.4.2-ac17,and the driver always go wro=
ng
> when I burn CDRs. Some files burned is different from the origin at HD.
> I use 2.2.17 with Tekram's driver,and nothing is wrong.

Indeed; people report more problems on 2.4 kernels than on 2.2 kernels. I
currently have no clue why.
Anyway, you can use the patch from 1.32 to have the driver integrated in the
2.4 kernel and the use the version from Tekram. (I believe they distribute
my version 1.27, but I didn't check fro quite some time.)
I would like to hear your results.

> I think the scsi layer maybe changed from 2.2.x,so the driver cannot run =
well.

It did change. For example the way SCSI devices are scanned fro changed from
T_U_R to INQUIRY. However, the driver has been changed to accept that.

> I am sure the hardware&software is ok,and no error messages about scsi
> found by me.
>=20
> Can anyone do me a favor to modify the driver in order to suite the
> new kernel?

Compiling it should be no problem.
Making it work flawlessly is. I'd like to know as well.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6rA3BxmLh6hyYd04RAkRsAKDEyK+sQ50vFQZ7qlnnzwlRWlqgSACfToUD
Vn1HHw9jt7GHkgdc5YLBrTU=
=2QB/
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
