Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVIEKat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVIEKat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 06:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVIEKat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 06:30:49 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:30930 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750999AbVIEKat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 06:30:49 -0400
Date: Mon, 5 Sep 2005 12:30:44 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050905103044.GG20386@sunbeam.de.gnumonks.org>
References: <20050904101218.GM4415@rama.de.gnumonks.org> <20050904110800.GN4415@rama.de.gnumonks.org> <9a87484905090315273f9b7048@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <9a87484905090315273f9b7048@mail.gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 04, 2005 at 12:27:20AM +0200, Jesper Juhl wrote:
> On 9/4/05, Harald Welte <laforge@gnumonks.org> wrote:
> > On Sun, Sep 04, 2005 at 12:12:18PM +0200, Harald Welte wrote:
> > > Hi!
> > >
> > > Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> > > Smartcard Reader.
> >=20
> > Sorry, the patch was missing a "cg-add" of the header file.  Please use
> > the patch below.
>=20
> It would be so much nicer if the patch actually was "below" - that is
> "inline in the email as opposed to as an attachment". Having to first
> save an attachment and then cut'n'paste from it is a pain.

This is a neverending discussion.  A number of kernel develpoers I know
prefer attachements these days.  It's a matter of your email client, and
why it doesn't just append a "plaintext" attachment at the bottom of
your mail and rather display you the "save as" icon/button/whatever.

> Anyway, a few comments below :
>=20
> +#define DEBUG(n, x, args...) do { if (pc_debug >=3D (n)) 			    \
>=20
>=20
> line longer than 80 chars. Please adhere to CodingStyle and keep lines
> <80 chars.

The line is _not_ longer than 80 chars, at least not if you remove the
"+" from the beginning of the patch and you hve 8 chars wide

> There's more than one occourance of this.

there was one occurrence in the file which I have missed, thanks.

> +static inline int cmx_waitForBulkOutReady(reader_dev_t *dev)
>=20
>=20
> Why TheStudlyCaps ?  Please keep function names lowercase. There are
> more instances of this, only pointing out one.

Yes, there are.  My initial idea was to diverge as little as possible
=66rom the original vendor driver, making it easy to pull in changes from
their tree in the future, should it be neccessarry.

However, it has diverged that much now, it doesn't really matter whether
I also rename the functions, too.  Please stay tuned for the next
revision of the patch.

> Please use only tabs for indentation (line 1 of the above is indented
> with spaces).

thanks, should have catched all of them now.

> lowercase prefered also for variables.

done

> Space after ","s please : DEBUG(5, "cmx_waitForBulkInReady rc=3D%.2x\n", =
rc);

done

> get rid of the space before the opening paren :=20
> static int cmx_open(struct inode *inode, struct file *filp)

done

> How about not having to indent so deep by rewriting that as

done

> +	cmx_poll_timer.function =3D &cmx_do_poll;
>=20
> shouldn't this be=20
> 	 cmx_poll_timer.function =3D cmx_do_poll;
> ???

I don't really know what difference it would make.  My understanding of
'c' is that both cases would take the address of the function.

My personal taste is rather to explicitly indicate this with an '&' than
let the compiler implicitly take the address.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHB5UXaXGVTD0i/8RAlP6AKCTZllsgYuCvVkvA7EF0cJszz4WtwCfbzDp
k4ZGYJlC1igWElzQwQseR7A=
=mO9q
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
