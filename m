Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUBAWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUBAWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:31:58 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:18310 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265547AbUBAWby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:31:54 -0500
Subject: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-541+bcHfm3/tY/Rd8Bqq"
Message-Id: <1075674718.27454.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 00:31:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-541+bcHfm3/tY/Rd8Bqq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

A quick question on module-init-tools/udev and module auto-loading ...
lets say I have a module called 'foo', that I want the kernel to
auto-load.

If I now have in modprobe.conf:

--
alias char-major-<foo_major>-* foo
alias /dev/foo foo
--

and /dev/foo exists, it works just fine.  If I delete /dev/foo
however, it does not.  Say the module _do_ support sysfs (meaning
udev will create /dev/foo on loading, this do not really affect
things, as without /dev/foo it do not work anyhow.

This a known issue (sure I know I can add it to local initscript to
load, but this is not always the preferred 'fix')?  Any ideas on
how to 'fix' this?

Then a distant related issue - anybody thought about dynamic major
numbers of 2.7/2.8 (?) and the 'alias char-major-<whatever>-* whatever'
type modprobe rules (as the whole fact of them being dynamic, will make
that alias type worthless ...)?


Thanks,

--=20
Martin Schlemmer

--=-541+bcHfm3/tY/Rd8Bqq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHX5eqburzKaJYLYRAn94AKCbwfMcRQ/cjJd8wr/m5JBw2WCjbgCdGE+j
286xD3gGPZ9ZetK9So2u5z4=
=kNhz
-----END PGP SIGNATURE-----

--=-541+bcHfm3/tY/Rd8Bqq--

