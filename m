Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbRLEWSi>; Wed, 5 Dec 2001 17:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284754AbRLEWSa>; Wed, 5 Dec 2001 17:18:30 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:39330 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284755AbRLEWSP>; Wed, 5 Dec 2001 17:18:15 -0500
Date: Wed, 5 Dec 2001 22:18:12 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jakob Kemi <jakob.kemi@telia.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre4
Message-ID: <20011205221812.U14028@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0112051640570.20575-100000@freak.distro.conectiva> <200112052155.fB5Ltxa26014@d1o849.telia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+vRq5lKQn39NaQ8P"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112052155.fB5Ltxa26014@d1o849.telia.com>; from jakob.kemi@telia.com on Wed, Dec 05, 2001 at 10:54:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+vRq5lKQn39NaQ8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 05, 2001 at 10:54:26PM +0100, Jakob Kemi wrote:

> Since 2.4.14 the ieee1284 parport functions have worked improperly
> for some drivers (CPiA, W9966 and others). Joe
> <joeja@mindspring.com> was quick to find the failure. He said he was
> going to send the patch to you some week ago and maybe he already
> have. If it somehow got lost in an internet black-hole or something
> I try to also send it to you. It's just a one-liner which reverts to
> pre-2.4.14 behavior.

I am the maintainer of this code.  Why is this the first time that I
have seen this patch (or even heard of a problem report)?  Marcelo,
please don't apply it.

The correct fix is to change:

ctl &= ~(PARPORT_CONTROL_STROBE | PARPORT_CONTROL_INIT);

so that it also turns off AUTOFD as well.

I have several patches queued up for parport (see
http://people.redhat.com/twaugh/patches/).  It would be very helpful
to me if you could first send changes to me rather than Marcelo or
Linus, so that merging is not made more difficult.  In addition, there
is a ChangeLog file in that directory; changing the code without
updating the ChangeLog makes my attempt to keep it current futile. :-(

Tim.
*/

--+vRq5lKQn39NaQ8P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Dp0kyaXy9qA00+cRAm62AKC3dA8TlEu0ZZSgd0HgIKka+omOJgCbB1yo
a0QxgOv+BNCNPiLOcM89Q+k=
=FnK/
-----END PGP SIGNATURE-----

--+vRq5lKQn39NaQ8P--
