Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUIMNeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUIMNeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUIMNeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:34:44 -0400
Received: from smtp0.telegraaf.nl ([217.196.45.192]:6322 "EHLO
	smtp0.telegraaf.nl") by vger.kernel.org with ESMTP id S266717AbUIMNel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:34:41 -0400
Date: Mon, 13 Sep 2004 15:34:38 +0200
From: Roel van der Made <roel@telegraafnet.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040913133437.GW3951@telegraafnet.nl>
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu> <41456536.6090801@sw.ru> <20040913092443.GA19437@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PSXRUCbmiibGgnYg"
Content-Disposition: inline
In-Reply-To: <20040913092443.GA19437@elte.hu>
User-Agent: Mutt/1.5.3i
X-telegraaf-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PSXRUCbmiibGgnYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 13, 2004 at 11:24:43AM +0200, Ingo Molnar wrote:
> * Kirill Korotaev <dev@sw.ru> wrote:
> > >the BUG() is useful for all the code that uses next_thread() - you can
> > >only do a safe next_thread() iteration if you've locked ->sighand.
> > 1. I don't see spin_lock() on p->sighand->siglock in do_task_stat()=20
> > before calling next_thread(). And the check inside next_thread() permit=
s=20
> > only one of the locks to be taken:
> >         if (!spin_is_locked(&p->sighand->siglock) &&
> >                                 !rwlock_is_locked(&tasklist_lock))

<snip>

> > the last check ensures that we are still hashed and this check is more=
=20
> > straithforward for understanding, agree?
>=20
> yep - please send a new patch to Andrew.

I'll be awaiting the patch and give it a shot.

Thanks all for the feedback.

--=20
Roel van der Made                             .--.
GNU/Linux Systems/Network Engineer           |o_o |
Telegraaf Media ICT - Internet Services      |:_/ |
Tel.: 020 585 2229                          //   \ \
GnuPG Key available at: http://roel.net/gpgkey.asc=20

--PSXRUCbmiibGgnYg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBRaHtPkMWyL8l9u8RAtWCAKCVPWWQz++gLxXzehX2hl1o9YWqSgCg4+sI
pLzD3+ZJtiH577YRLKRkR7Y=
=khQ8
-----END PGP SIGNATURE-----

--PSXRUCbmiibGgnYg--
