Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTHYAQC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 20:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbTHYAQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 20:16:01 -0400
Received: from pool-141-155-159-60.ny5030.east.verizon.net ([141.155.159.60]:31681
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S261363AbTHYAP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 20:15:57 -0400
Date: Sun, 24 Aug 2003 20:16:30 -0400
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
Message-ID: <20030825001630.GA5132@blazebox.homeip.net>
References: <1060543928.887.19.camel@blaze.homeip.net> <2425882704.1060622541@aslan.btc.adaptec.com> <1060623576.2826.9.camel@blaze.homeip.net> <3F37F1A4.2030404@genebrew.com> <31044.199.181.174.146.1060650619.squirrel@www.blazebox.homeip.net> <3F384819.4070108@genebrew.com> <1060711760.854.6.camel@blaze.homeip.net> <3245752704.1060799900@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <3245752704.1060799900@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Slackware Linux 9.0
X-Kernel-Version: Linux 2.6.0-test4-bk2
X-Mailer: Mutt 1.4.1i http://www.mutt.org
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.1; VDF: 6.21.0.26; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2003 at 12:38:20PM -0600, Justin T. Gibbs wrote:
>=20
> It will be a little while before I can get my own distributions up
> and running in the 2.6 stream.  I hope to start looking at this next
> week.
>=20
> --
> Justin
>=20

Hi Justin,

After some more testing i have good news to report.
I am currently running kernel 2.6.0-test4 with aic7xxx driver.

The solution to my earlier problem was in SCSI-Select Utility under
Advanced Settings tab.I have never changed any options under the
AHA-2940U2W bios 2.57.2 but this time i've changed BIOS Support for
Int 13 Extensions from Enabled (default) to Disabled.That made all the
difference when the adapter is probed.

I have a question related to this setting, will this affect anything
when set to Disabled? Perhaps there's something in the driver that
prevents the Int 13 extention from functioning properly?

I can provide .config,dmesg output or verbose messages if needed.

Thank you for helping thus far.

Regards,

Paul


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/SVVeIymMQsXoRDARAlYhAJ4nkvXdidlzJNq8DmQZtDH9vdNRXwCfbECY
uiD0IomIvXoTt1ZTQGPI8Hc=
=a/DU
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
