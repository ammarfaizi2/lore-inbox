Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWEPGLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWEPGLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 02:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEPGLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 02:11:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:13724 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751511AbWEPGLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 02:11:11 -0400
X-Authenticated: #21330363
From: "Sven Schnelle" <svens@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: ifIndex allocation
Organization: private
Date: Tue, 16 May 2006 08:11:01 +0200
Message-ID: <86r72uh53e.fsf@deprecated.bitebene.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi List,

investigating a problem with an snmp software for linux, i was wondering
why the kernel allocates a new ifindex Number, even if the old one is still
available. For example, if i unload a network driver module, and reload
it, it has a different ifindex.

Looking at the function dev_new_index (line 2620 in net/core/dev.c)
there is a line 'static int ifindex'. Is there any special reason why
this variable is static, and the list is not traversed from the
beginning, so that the first free ifindex will be used?


Best regards,

Sven.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEaWz386MdxiXaIbERAhknAKCaZDLbDTNb+aFfkB184HT/d9G9LgCgx/er
AzWJylxlmYGs9omX+q2H3w4=
=6fV9
-----END PGP SIGNATURE-----
--=-=-=--
