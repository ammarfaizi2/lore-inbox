Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbULPL2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbULPL2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 06:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbULPL2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 06:28:38 -0500
Received: from mivlgu.ru ([81.18.140.87]:5601 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S262617AbULPL2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 06:28:36 -0500
Date: Thu, 16 Dec 2004 14:28:32 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Horms <horms@verge.net.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jason Baron <jbaron@redhat.com>
Subject: Re: tty/ldisc fix in 2.4
Message-ID: <20041216112832.GB10876@master.mivlgu.local>
References: <20041216044227.GC13680@verge.net.au> <20041216081452.GA8113@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <20041216081452.GA8113@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2004 at 06:14:52AM -0200, Marcelo Tosatti wrote:
> Sergey, I recall you seeing SieFS breakage due to Jason's patch -=20
> what was your finding on that?

I have found the bug - the call to tty->driver.set_termios in
change_termios() was removed, therefore serial port speed was not set
correctly.  I sent patches fixing this to Jason Baron and to LKML:

http://lkml.org/lkml/2004/11/7/105
http://lkml.org/lkml/2004/11/7/106
http://lkml.org/lkml/2004/11/7/107

But I did not get any reply.

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBwXFfW82GfkQfsqIRAl6gAKCOF+jeRvJ2vP24bf4vLlyI3jtqvgCeJN8b
F+86kPZH84wMOCl1S79QqlI=
=UCAR
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
