Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSJ1Uut>; Mon, 28 Oct 2002 15:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSJ1Uut>; Mon, 28 Oct 2002 15:50:49 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:35222 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261489AbSJ1Uus>; Mon, 28 Oct 2002 15:50:48 -0500
Date: Mon, 28 Oct 2002 21:56:47 +0100
From: Martin Waitz <tali@admingilde.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021028205647.GC1402@admingilde.org>
Mail-Followup-To: Hanna Linder <hannal@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <53100000.1035832459@w-hlinder>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <53100000.1035832459@w-hlinder>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Oct 28, 2002 at 11:14:19AM -0800, Hanna Linder wrote:
> 	The results of our testing show not only does the system call=20
> interface to epoll perform as well as the /dev interface but also that ep=
oll=20
> is many times better than standard poll. No other implementations of poll=
=20
> have performed as well as epoll in any measure. Testing details and resul=
ts=20
> are published here, please take a minute to check it out: http://lse.sour=
ceforge.net/epoll/index.html
how does this compare to the kqueue mechanism found in {Free,Net}BSD?
(see http://people.freebsd.org/~jlemon/papers/kqueue.pdf)

i especially like their combined event update/event wait,
needing only one syscall per poll while building a changelist in
userspace...

a replacement for poll/select is _really_ needed.
but i think we should use existing interfaces if possible,
to reduce the changes needed in userspace.


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9vaSOj/Eaxd/oD7IRAqWFAJ9f+uJrbT9gZ5/DicWtOnIHUpQe7wCfdzPw
USjx5AbCT+oQ7V8wAMbX69E=
=JM/6
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
