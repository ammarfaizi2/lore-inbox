Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTLBReI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTLBReI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:34:08 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:23689 "EHLO
	catnet.kabel.utwente.nl") by vger.kernel.org with ESMTP
	id S262558AbTLBReB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:34:01 -0500
Date: Tue, 2 Dec 2003 18:33:59 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.4.23 masquerading broken?
Message-ID: <20031202173358.GK615@gaast.net>
References: <20031202165653.GJ615@gaast.net> <3FCCCB02.5070203@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Content-Disposition: inline
In-Reply-To: <3FCCCB02.5070203@trash.net>
X-Operating-System: Linux 2.4.23 on a i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patrick McHardy (kaber@trash.net) wrote:
> Can you check the ringbuffer for error messages ? What happens
> to the packets when masquerading fails ?
>=20
Hmm. Damn, forgot about the syslogs completely. :-(

Dec  2 16:42:30 tosca kernel: MASQUERADE: Route sent us somewhere else.
Dec  2 16:42:44 tosca last message repeated 11 times
Dec  2 16:42:47 tosca kernel: NET: 1 messages suppressed.
Dec  2 16:42:47 tosca kernel: MASQUERADE: Route sent us somewhere else.
Dec  2 16:42:51 tosca kernel: NET: 5 messages suppressed.
Dec  2 16:42:51 tosca kernel: MASQUERADE: Route sent us somewhere else.
Dec  2 16:42:57 tosca kernel: NET: 4 messages suppressed.
Dec  2 16:42:57 tosca kernel: MASQUERADE: Route sent us somewhere else.

And, well, it goes on like that. dmesg is full of messages like this.

The packages seem to get lost completely. At least I don't see them
going out on eth1 (where they should go to).


Wilmer van der Gaast.

--=20
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE/zM0GeYWXmuMwQFERApNuAJ9yhx3cAx0XMIXr19W8cbItK1kSXQCg05vt
tss1CRbFf6hgJaX0YJfYSY8=
=cFnJ
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--
