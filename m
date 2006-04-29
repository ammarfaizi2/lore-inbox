Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWD2HIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWD2HIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 03:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWD2HIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 03:08:09 -0400
Received: from lug-owl.de ([195.71.106.12]:47075 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751779AbWD2HII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 03:08:08 -0400
Date: Sat, 29 Apr 2006 09:08:06 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: make O="<dir>" install; output not relocated; 2.6.16.11(kbuild)
Message-ID: <20060429070806.GK25520@lug-owl.de>
Mail-Followup-To: Linda Walsh <lkml@tlinx.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <4451B77D.7070000@tlinx.org> <20060428075832.GD25520@lug-owl.de> <44524A3F.6060203@tlinx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5EqXjnbnoPR4rQBx"
Content-Disposition: inline
In-Reply-To: <44524A3F.6060203@tlinx.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5EqXjnbnoPR4rQBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-28 10:00:47 -0700, Linda Walsh <lkml@tlinx.org> wrote:
> Jan-Benedict Glaw wrote:
> > The  modules_install  target uses O=3D for its _input_ files (that is,
> > for the readily compiled modules) and outputs to
> > $(INSTALL_MOD_PATH)/lib/modules/$VERSION/ .  So you may want to set
> > $(INSTALL_MOD_PATH) in the same way as you've set V=3D or O=3D before.
> >
> > If you're trying to prepare something to be copied over to a target
> > system, the tar-pkg, targz-pkg and tarbz2-pkg targets may be exactly
> > what you're searching for.
> > =20
> Quite possibly. What about an installed kernel (apart from the
> modules)?  Will the kernel image and map, etc, get installed into
> the "INSTALL_MOD_PATH" as well?  It doesn't sound, intuitively,

`make modules_install' will never ever end up installing the kernel
image or the System.map or any other architecture-specific boot
images. It'll install the modules, nothing more.

The packaging scripts OTOH will of course also take that stuff.

> to be so from the environment variable name.
> > It's maybe a bit misleading, but `modules_install' isn't a compilation
> > run, it's an installation run. O=3D was ment to hold all
> > compiled/generated objects, but to have a working installation, you
> > need to break out of that (or have INSTALL_MOD_PATH set.)
>
>    Fair enough, but I'm more interested in where to specify
> the target location of the installed kernel and System.map as
> I don't always have modules for a generated kernel, but usually
> (near 100% :-)) have an installable kernel image.  For development,
> I could see it being useful to mount the target system's root in
> a local directory (like /mnt), then have the kernel build install
> to a target root of "/mnt".

Installing the kernel image is quite architecture specific; most
architectures use $(INSTALL_PATH), so this could be something like
/path/to/target_system/boot .  Though they may also re-run lilo or
something like that, so it's possibly not what you actually want to
use.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--5EqXjnbnoPR4rQBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEUxDWHb1edYOZ4bsRAheVAJ4m8NDjtG94U3gEjJK7hJKUh4EbrQCfUEui
jGsczBcuHWtrlskg1loVzVU=
=/VG2
-----END PGP SIGNATURE-----

--5EqXjnbnoPR4rQBx--
