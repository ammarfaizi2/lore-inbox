Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264817AbSJ3TcD>; Wed, 30 Oct 2002 14:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264832AbSJ3TcD>; Wed, 30 Oct 2002 14:32:03 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:41898 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264817AbSJ3TcC>; Wed, 30 Oct 2002 14:32:02 -0500
Date: Wed, 30 Oct 2002 20:38:10 +0100
From: Martin Waitz <tali@admingilde.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021030193810.GD2300@admingilde.org>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021029225419.GA1463@admingilde.org> <Pine.LNX.4.44.0210291819080.1457-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210291819080.1457-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

> > what is the motivation to make it edge based?

On Tue, Oct 29, 2002 at 06:24:27PM -0800, Davide Libenzi wrote:
> You have two ways to know if "something" changed. You call everyone each
> time and you ask him if his changed, or you call everyone one time by
> saying "call me when you're changed".
well, you don't say 'call me when you're changed' but
'i'm interested in your status, please be prepared to report if you
have changed' when calling epoll_ctl.

> It's behind the "call me when you're changed" phrase that lays the
> concept of edge triggered APIs.
in most situations, you are not really interested in 'has it changed?'
but in 'what has it changed to?'.
this is the difference between edge- or level-triggered notification.

e.g. the application wants to know
'from which fds can i read without blocking' and not which fds
happend to change their block-state
(perhaps there is still data available after the last read, in
which case the application would like to be notified about this
situation)

> So, pretty evidently, the answer to your question is : efficency.
but the api should be useful, too...


is it possible that www.xmailserver.org is down atm?
i couldn't get as much docu about epoll as i wanted to,
so please correct me if my above view about epoll is incorrect

and yes, i haven't looked at any code yet,
i just like the kevent docu better then the epoll docu... ;)
and yes, i would like to port kevent to linux,
but i don't have any time to do this in the next months... :(

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

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9wDUij/Eaxd/oD7IRAnKUAJ9RBerF9O+Xf7saRElAHVee6CPrzwCfRtUf
Dce/hHmVSVHLZnbC3tcrVZo=
=lgva
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
