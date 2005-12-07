Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVLGRJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVLGRJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVLGRJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:09:34 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:4286 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751201AbVLGRJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:09:33 -0500
Date: Wed, 7 Dec 2005 15:13:32 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207171332.GI20451@duckman.conectiva>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <20051207164118.GA28032@suse.de> <20051207145113.4cbdc264.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <20051207145113.4cbdc264.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2005 at 02:51:13PM -0200, Luiz Fernando Capitulino wrote:
> On Wed, 7 Dec 2005 08:41:18 -0800
> Greg KH <gregkh@suse.de> wrote:
>=20
> | On Tue, Dec 06, 2005 at 09:56:10AM -0200, Luiz Fernando Capitulino wrot=
e:
> | >  Greg,
> | >=20
> | >  Don't get scared. :-)
> |=20
> | I'm not scared, just not liking this patch series at all.
> |=20
> | In the end, it's just moving from one locking scheme to another.  No big
> | deal.
>=20
>  I understand.
>=20
> | The problem is, none of this should be needed at all.  We need to move
> | the usb-serial drivers over to use the serial core code.  If that
> | happens, then none of this locking is needed.
> |=20
> | That's the right thing to do, so I'm not going to take this patch series
> | right now because of that.  If you all want to work on moving to use the
> | serial core, I would love to see that happen.
>=20
>  If it's the right thing to do, I'll love to work on that. :)
>=20
>  There is only one problem though, I've never touched in the serial core.
> It means I'll need some time to do it, and maybe the first tries can be
> wrong.
>=20
>  Any tips you have in mind are very welcome.

I have a small question: in my view, this patch series is a small
step towards implementing the usb-serial drivers The Right Way, as it
removes a a bit of duplicated code. If we start to do The Big Change to
serial_core , probably we would make further refactorings on these parts,
going towards The Right Way to implement the drivers.

My question would be: where would the small refactorings belong, while
the big change to serial_core is work in progress? I would like them
to go to some tree for testing, while the work is being done, instead
of pushing lots of changes later, but I don't know if there is someone
who we could send them.

>=20
>  Eduardo, let's do it? :)

I would love it, but I will be on vacations in two weeks. So, probably
on January.

My wife is lucky that I won't have a notebook available during our
vacations.  8)

--=20
Eduardo

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlxg8caRJ66w1lWgRAjxHAKCYydzIfjx735zUjui+nxl2IT1uZQCggMKf
c128uSilO/+Z+mV0mdMF+xk=
=XDU0
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
