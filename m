Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270651AbRHNSbd>; Tue, 14 Aug 2001 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270653AbRHNSbT>; Tue, 14 Aug 2001 14:31:19 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:45618 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S270643AbRHNSa1>; Tue, 14 Aug 2001 14:30:27 -0400
Date: Tue, 14 Aug 2001 19:35:43 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kurt Garloff <garloff@suse.de>, Andries.Brouwer@cwi.nl,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mantel@suse.de,
        rubini@vision.unipv.it
Subject: Re: [PATCH] make psaux reconnect adjustable
Message-ID: <20010814193543.V1085@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	mantel@suse.de, rubini@vision.unipv.it
In-Reply-To: <20010814170306.Q1085@gum01m.etpnet.phys.tue.nl> <Pine.LNX.4.33.0108140954390.1679-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOaLjq+VdFesH+wR"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108140954390.1679-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GOaLjq+VdFesH+wR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

thanks for your comments.

On Tue, Aug 14, 2001 at 09:58:55AM -0700, Linus Torvalds wrote:
> I really have two comments, but I haven't followed the whole discussion,
> so feel free to just say that it's been hashed out already:
>=20
>  - sysconf entries are suspicious for stuff like this. If some code really
>    requires this to work correctly, that's exactly the kind of code that
>    would run automatically at bootup. A sysconf doesn't really help people
>    in that case - we'd be much better off with just a bootup switch.

Maybe that's the difference of whether you define the kernel behaviour by
deciding what goes in and the one that tries to avoid a breakage without
changing the default behaviour ...
Of course the sysctl is less intrusive (from a user's point of view).

>  - do we actually need the config switch AT ALL, whether at bootup or not?
>    What exactly breaks if we just always pass the AA 00 values through?
>    Apparently nothing ever breaks, which makes me suspect that people are
>    just being unnecessarily defensive.

PS2 mouses need this ping thing to be operational after being plugged.
But, there's no reason it needs to be done in the kernel.
* It works for plain PS2 only (not: imps2, synps2, ...)
* The userspace driver (gpm, X11) can do it as well, AFAICS

I guess the thing has been introduced because it was more convenient than
fixing userspace.
Maybe the kernel does it a bit more efficient by throwing away the queue ...

> In short, I'd prefer a patch that just unconditionally removes the code,
> unless somebody KNOWS that it could break something. That failing, a
> simple kernel command line option sounds better than more files in /proc.

I'd be happy with removing it.
Patch will follow!

> Remember: the biggest mistake to do is to overdesign. The road to hell is
> paved with good intentions.

A few sysctls don't qualify as overdesign yet, I hope.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--GOaLjq+VdFesH+wR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7eWFvxmLh6hyYd04RAid0AJkBRbQAelKjAXzaA8rRQifEPscH2ACfUUsp
BqZqeLRrmag8Bsup3yELdnY=
=dhec
-----END PGP SIGNATURE-----

--GOaLjq+VdFesH+wR--
