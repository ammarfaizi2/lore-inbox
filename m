Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUCASBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUCASBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:01:31 -0500
Received: from theshire.demon.nl ([82.161.26.30]:15662 "EHLO
	hal.shire.sytes.net") by vger.kernel.org with ESMTP id S261388AbUCASB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:01:29 -0500
Date: Mon, 1 Mar 2004 19:01:28 +0100
From: Robbert Haarman <inglorion@inglorion.net>
To: linux-kernel@vger.kernel.org
Subject: Progress on RTL8180 Driver for Linux 2.6
Message-ID: <20040301180128.GE8057@shire.sytes.net>
References: <20040229183143.GA8057@shire.sytes.net> <20040229193251.GA2181@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20040229193251.GA2181@mars.ravnborg.org>
X-PGP-Key: http://www.inglorion.net/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For all who have asked about my efforts to make the RTL8180 driver work on 2.6, and others who are interested, here's an update.

I've gotten the driver to build against the 2.6 kernel. The closed source part references __generic_copy_{from,to}_user, which seem to have been replaced by __copy_{to,from}_user_ll (see arch/i386/lib/usercopy.c from the kernel sources). I have written a compatibility file that wraps the new functions inside the old names. With that, the module loads, but then causes a kernel oops due to a null pointer dereference in the initialization code.

The sources I use can be obtained from my computer; point your browser at http://hal.shire.sytes.net:5800/~inglorion/software/#rtl_8180_driver and download the tarball from there.

Happy hacking,

Robbert Haarman

---
"For every complex problem there is an answer that is clear, simple, and wrong."

	-- H.L. Mencken

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAQ3p3DgDISEp7l6ERAqGtAKCiy/C4AsqCA7Y3ziDlUMlc6itxKgCfVyWG
gtuAM19bhZoeVKO2TalJM+w=
=MgR3
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
