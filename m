Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267082AbUBFAWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267083AbUBFAWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:22:36 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:777 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S267082AbUBFAW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:22:27 -0500
Date: Thu, 5 Feb 2004 19:22:24 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: John Cherry <cherry@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, gregkh@us.ibm.com
Subject: Re: [patch] 2.6.2-mm1: fix warning introduced by input-2wheel-mouse-fix
Message-ID: <20040206002223.GA16808@babylon.d2dc.net>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	John Cherry <cherry@osdl.org>, Andrew Morton <akpm@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz, gregkh@us.ibm.com
References: <20040205014405.5a2cf529.akpm@osdl.org> <1076003898.12450.15.camel@cherrytest.pdx.osdl.net> <20040205231226.GC26093@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20040205231226.GC26093@fs.tum.de>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2004 at 12:12:27AM +0100, Adrian Bunk wrote:
> On Thu, Feb 05, 2004 at 09:58:18AM -0800, John Cherry wrote:
> >...
> > The nit warnings that sprung up in the defconfig builds are...
> >...
> > drivers/usb/input/hid-input.c: In function `hidinput_hid_event':
> > drivers/usb/input/hid-input.c:436: warning: suggest parentheses around
> > && within ||
> >...
>=20
> This one's easy to fix:
>=20
> --- linux-2.6.2-mm1/drivers/usb/input/hid-input.c.old	2004-02-06 00:05:19=
=2E000000000 +0100
> +++ linux-2.6.2-mm1/drivers/usb/input/hid-input.c	2004-02-06 00:05:50.000=
000000 +0100
> @@ -433,7 +433,7 @@
>  	input_regs(input, regs);
> =20
>  	if (((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA) && (usage->code =
=3D=3D BTN_EXTRA))
> -		|| (hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_BACK) && (usage->code =
=3D=3D BTN_BACK)) {
> +		|| ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_BACK) && (usage->code =
=3D=3D BTN_BACK))) {
>  		if (value)
>  			hid->quirks |=3D HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
>  		else
>=20
>=20
> Please apply

Ah hell, yes, please do apply.

*looks around for a brown paper bag*

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

On Sat, 13 Jul 2002, Alexander Viro wrote:
>
> So I'd just do
>
> vi fs/dcache.c -c '/|=3D DCACHE_R/d|/nr_un/pu|<|x'
>
> and be done with that.  Linus?

Done.

For future reference - don't anybody else try to send patches as vi
scripts, please. Yes, it's manly, but let's face it, so is bungee-jumping
with the cord tied to your testicles.

                Linus

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIt4/RFMAi+ZaeAERAjTxAKDbP/Q0KuWjdttf2Sp1iGTWhzViGQCffm7G
nZ577PusSNGQitzY1tgdcfE=
=VpX5
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
