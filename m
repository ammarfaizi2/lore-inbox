Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271255AbTHCVqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271283AbTHCVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:46:12 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:55498
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S271255AbTHCVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:46:00 -0400
Date: Sun, 3 Aug 2003 17:47:55 -0400
From: Diffie <diffie@blazebox.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-ID: <20030803214755.GA1010@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net> <20030801144455.450d8e52.akpm@osdl.org> <20030803015510.GB4696@blazebox.homeip.net> <20030802190737.3c41d4d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20030802190737.3c41d4d8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.4.21-xfs
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.20.0.1; VDF: 6.20.0.55; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 02, 2003 at 07:07:37PM -0700, Andrew Morton wrote:
> Diffie <diffie@blazebox.homeip.net> wrote:
> >
> > After applaying the above patch and testing it still oopses the kernel.
> >=20
> > I noticed same patch in today's mm3 which i compiled and use right now.
> >=20
> > When using cat /proc/scsi/aic7xxx/0 i get segmentation fault and oops
> > which i'll attach to this email.
> >
> > ...
> >
> >  EIP is at aic7xxx_proc_info+0xc28/0xc80
>=20
> This is crashing in a different place.  Probably the same bug, showing up
> later on.
>=20
> I don't know if anyone is maintaining aic7xxx_old in 2.7.  It looks like =
it
> was subject to some random untested change a couple of months back.
>=20
>=20
>=20

Hi Andrew,

I think this bug is due to me using the aic7xxx_old code ver 5.x.x.

Under kernel 2.4.21 the aic7xxx (new) is ver 6.2.8 and it works great
with Adaptec AHA-2940U2W controller i have.

On 2.6.0-test2-mm3 (tried Linus test1,test2,mm1 and mm2) the NEW aic7xxx
uses ver 6.2.35 and will not scan my IBM drive even though it
initializes the correct SCSI ID,LUN etc...

I would like to contact and report this issue to the aic7xxx maintaner
and perhaps get it resolved.Where would be the best place to report this
kind of problem?

I have taken few screen captures which are available at:
http://www.blazebox.homeip.net:81/diffie/images/2.6.0-test2/ and show
the aic7xxx (new) failure.


Regards,

Paul B.


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LYMLIymMQsXoRDARAlmkAKCWH1i6Cbyd10rPhXoJGDmhZO2S+QCZAUJy
gnkyiWxkIdhWtIlcXrZ87o0=
=X0OR
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
