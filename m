Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUGLG67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUGLG67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266744AbUGLG67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:58:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35515 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266741AbUGLG64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:58:56 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040711210624.GC3933@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com>
	 <200407101657.06314.phillips@redhat.com>
	 <1089501890.19787.33.camel@persist.az.mvista.com>
	 <200407111544.25590.phillips@istop.com>
	 <20040711210624.GC3933@marowsky-bree.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-azJ49vyQPUwZhzBbmuk3"
Organization: Red Hat UK
Message-Id: <1089615523.2806.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 08:58:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-azJ49vyQPUwZhzBbmuk3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> This however is not true; clusters have managed just fine running in
> user-space (realtime priority, mlocked into (pre-allocated) memory
> etc).

(ignoring the entire context and argument)

Running realtime and mlocked (prealloced) is most certainly not
sufficient for causes like this; any system call that internally
allocates memory (even if it's just for allocating the kernel side of
the filename you handle to open) can lead to this RT, mlocked process to
cause VM writeout elsewhere.=20

While I can't say how this affects your argument, everyone should be
really careful with the "just mlock it" argument because it just doesn't
help the worst case in scenarios like this. (It most obviously helps the
average case so for soft-realtime use it's a good approach)

--=-azJ49vyQPUwZhzBbmuk3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8jajxULwo51rQBIRApBbAJ4/Ko1zIE0rfLF3DgX6WBVnapaZRgCgpbAu
N4oq1C8BhfGoGPhAkb0TVME=
=jr7S
-----END PGP SIGNATURE-----

--=-azJ49vyQPUwZhzBbmuk3--

