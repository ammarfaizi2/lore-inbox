Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbRFLPLB>; Tue, 12 Jun 2001 11:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbRFLPKv>; Tue, 12 Jun 2001 11:10:51 -0400
Received: from ns.snowman.net ([63.80.4.34]:38414 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S261800AbRFLPKo>;
	Tue, 12 Jun 2001 11:10:44 -0400
Date: Tue, 12 Jun 2001 11:09:33 -0400
From: Stephen Frost <sfrost@snowman.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Jeremy Sanders <jss@ast.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <20010612110933.G11136@ns>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Jeremy Sanders <jss@ast.cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk> <20010612154735.B17905@flint.arm.linux.org.uk> <15142.11907.782662.581523@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s8iJYNYVA1fg3NyN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15142.11907.782662.581523@pizda.ninka.net>; from davem@redhat.com on Tue, Jun 12, 2001 at 08:00:19AM -0700
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 11:07am  up 299 days, 13:36, 11 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s8iJYNYVA1fg3NyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* David S. Miller (davem@redhat.com) wrote:
>=20
> Russell King writes:
>  > At the time I suggested it was because of a missing wakeup in 2.4.2 ke=
rnels,
>  > but I was shouted down for using 2.2.15pre13.  Since then I've seen th=
ese
>  > reports appear on lkml several times, each time without a solution nor
>  > explaination.
>  >=20
>  > Oh, and yes, we're still using the same setup here at work, and its ru=
nning
>  > fine now - no rsync lockups.  I'm not sure why that is. ;(
>=20
> Look everyone, it was determined to be a deadlock because of some
> interaction between how rsync sets up it's communication channels
> with the ssh subprocess, readas: userland bug.
>=20
> I don't remember if the specific problem was in rsync itself or some
> buggy version of ssh.  One can search the list archives to discover
> Alexey's full analysis of the problem.  I don't have a URL handy.

	I have to say I find this likely to be the case for those who are
	having issues with rsync over ssh.  I was recently playing with
	rsync over ssh (newer openssh to older openssh) and was just using
	it as a pass-through to another machine.

	When I replaced ssh with rinetd, everything worked fine.  I havn't
	had a chance yet (though I'd like to) to try with two recent versions
	of ssh but I'm curious what the result will be.  It may be that the
	problem has been fixed in later versions of ssh.

			Stephen

--s8iJYNYVA1fg3NyN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7JjCtrzgMPqB3kigRAkllAJ9WMEGs0flGG5qVr9DkF8GT6KQLuACfQBuM
mdZ/J6LqqLcpWHIIvcrhZQo=
=LsMX
-----END PGP SIGNATURE-----

--s8iJYNYVA1fg3NyN--
