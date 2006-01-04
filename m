Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWADRTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWADRTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWADRTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:19:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62893 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964812AbWADRTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:19:21 -0500
Message-ID: <43BC030A.1060208@redhat.com>
Date: Wed, 04 Jan 2006 09:16:58 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       "Viro, Al" <viro@ftp.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Limit sendfile() to 2^31-PAGE_CACHE_SIZE bytes without
 error
References: <43BB348F.3070108@zytor.com> <200601040451.20411.ak@suse.de> <Pine.LNX.4.64.0601032051300.3668@g5.osdl.org> <43BB5646.2040504@zytor.com> <43BB5E22.2010306@zytor.com> <Pine.LNX.4.64.0601040900311.3668@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601040900311.3668@g5.osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC37A0E20D4F3C26BFBC5AE4B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC37A0E20D4F3C26BFBC5AE4B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Ok, this patch looks ok, if it's confirmed to unbreak apache.

Yes, sounds reasonable.  But I don't think that, as Peter suggested in
another mail, that glibc should automatically wrap the syscall to
provide support for  larger sizes.  The caller probably should know when
a transfer was cut short.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigC37A0E20D4F3C26BFBC5AE4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDvAMK2ijCOnn/RHQRAmj4AJ95H3gaMTSP2wee86JzyeLzYfTFAwCeJ8FN
kvvDZCEa4WGxdnNWo98AeZw=
=GOSx
-----END PGP SIGNATURE-----

--------------enigC37A0E20D4F3C26BFBC5AE4B--
