Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUCRGJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUCRGJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:09:46 -0500
Received: from dsl093-212-224.clb1.dsl.speakeasy.net ([66.93.212.224]:13504
	"HELO aircrash.lan.spoonguard.org") by vger.kernel.org with SMTP
	id S262415AbUCRGJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:09:45 -0500
Date: Thu, 18 Mar 2004 01:09:50 -0500
From: David Brown <dave@spoonguard.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "Page allocation failure" messages with sendfile() and cryptoloop
Message-ID: <20040318060950.GA2906@spoonguard.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline

Hi:

I'm using Apache 2 to serve some rather large files from an XFS
volume on Linux 2.6.1. The XFS volume sits on a cryptoloop device,
which is in turn backed by a raw device (a partition on an IDE disk).

Apache 2 uses sendfile() to send static content. I'm seeing messages
like this when trying to send files whose size exceeds the available
RAM+swap:

  httpd: page allocation failure. order:0, mode:0x1d2

Seemingly polynomial slowdowns are also apparent. I can send a 7MB file
instantly, and a 220MB file without too much delay. I gave up on the 600MB
file after 10 minutes of unresponsiveness.

The machine does stay alive through all of this.

Are there any issues with the cryptoloop driver and sendfile()? Should I
try 2.6.4, or would more information be helpful?

Thanks,

- Dave


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAWT0uc6ko5wl0+FQRAlWSAJ0a2pJkRbQ0ZTrMJK4P5+MLmFzVTgCcDg2B
jAeou55I1PGwQ6ojA25AxLU=
=7yuP
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
