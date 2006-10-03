Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbWJCTSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbWJCTSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWJCTSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 15:18:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58808 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030497AbWJCTSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 15:18:37 -0400
Message-ID: <4522B7CD.4040206@redhat.com>
Date: Tue, 03 Oct 2006 12:19:41 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org>  <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <45229C8E.6080503@redhat.com> <4522A691.7070700@aknet.ru>
In-Reply-To: <4522A691.7070700@aknet.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4BE49D105BDCF540988A9354"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BE49D105BDCF540988A9354
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Stas Sergeev wrote:
> My position is simple: the ld.so problem needs a better
> solution than the current one. The current one, for example,
> still allows to use ld.so directly to execute the files for
> which you do not have an exec permission. And that's not an
> only problem...

You really don't get it, do you.  The way ld.so works can be implemented
in many other forms with other programs.  With some time and energy you
likely can write a perl or python script to do it.  "ld.so" is a place
holder for everything userlevel that wants to map executables.


> And allow an attacker to store his files on that partition,
> and then execute them.

They can do it anyway.


> I have already proposed another solution for ld.so problem
> 3 times.

And for obvious reasons I ignored it.

noexec mounts the way _you_ want them are completely, utterly useless.
nonexec mounts as they are today plus an upcoming mprotect patch give
fine grained control.  You have to use additional mechanism like SELinux
to fill in all the holes but that's OK.  nonexec mounts give a great
deal more of flexibility.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig4BE49D105BDCF540988A9354
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFIrfN2ijCOnn/RHQRAmQ7AJwNTVMloWRCtzCvCLFMeVDKhW5fUgCfaY8C
WYiHw/p4WfLNEQSfAOyv4N8=
=ZLD4
-----END PGP SIGNATURE-----

--------------enig4BE49D105BDCF540988A9354--
