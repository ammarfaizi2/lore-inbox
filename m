Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVE3NXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVE3NXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVE3NXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:23:16 -0400
Received: from relay.snowman.net ([66.92.160.56]:2060 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S261528AbVE3NXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:23:00 -0400
Date: Mon, 30 May 2005 09:23:28 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAID-5 design bug (or misfeature)
Message-ID: <20050530132328.GA30011@ns.snowman.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Bernd Eckenfels <ecki@lina.inka.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net> <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz> <1117454144.2685.174.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uyMgqQZe5lFtt8vD"
Content-Disposition: inline
In-Reply-To: <1117454144.2685.174.camel@localhost.localdomain>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 09:21:48 up 485 days,  8:10, 31 users,  load average: 4.16, 4.29, 4.27
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uyMgqQZe5lFtt8vD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Llu, 2005-05-30 at 03:47, Mikulas Patocka wrote:
> > > In article <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz=
> you wrote:
> > > > I think Linux should stop accessing all disks in RAID-5 array if tw=
o disks
> > > > fail and not write "this array is dead" in superblocks on remaining=
 disks,
> > > > efficiently destroying the whole array.
>=20
> It discovered the disks had failed because they had outstanding I/O that
> failed to complete and errorred. At that point your stripes *are*
> inconsistent. If it didn't mark them as failed then you wouldn't know it
> was corrupted after a power restore. You can then clean it fsck it,
> restore it, use mdadm as appropriate to restore the volume and check it.

Could that I/O be backed out when it's discovered that there's too many
dead disks for the array to be kept online anymore?

	Just a thought,

		Stephen

--uyMgqQZe5lFtt8vD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCmxPPrzgMPqB3kigRAi2hAJwOhjcNEtiSF/R3oESduHoMdQWREACfe+wp
VnsDYkKHJf6gJPeOfxrRJek=
=nQsV
-----END PGP SIGNATURE-----

--uyMgqQZe5lFtt8vD--
