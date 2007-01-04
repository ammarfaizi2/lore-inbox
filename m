Return-Path: <linux-kernel-owner+w=401wt.eu-S932321AbXADIM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbXADIM1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 03:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbXADIM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 03:12:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbXADIM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 03:12:26 -0500
Message-ID: <459CB603.9010208@redhat.com>
Date: Thu, 04 Jan 2007 00:08:35 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pierre Peiffer <pierre.peiffer@bull.net>
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       =?UTF-8?B?U8OpYmFzdGllbiBE?= =?UTF-8?B?dWd1w6k=?= 
	<sebastien.dugue@bull.net>,
       Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 2.6.19.1-rt15][RFC] - futex_requeue_pi implementation
 (requeue from futex1 to PI-futex2)
References: <459BA267.1020706@bull.net> <20070103123536.GA9088@elte.hu> <459BBF15.5070505@bull.net> <20070103155609.GB11066@elte.hu> <459CB3E6.9080906@bull.net>
In-Reply-To: <459CB3E6.9080906@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C9AACEC80138563F74F3ED7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C9AACEC80138563F74F3ED7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pierre Peiffer wrote:
> But, just for information, what is the sys_futex64 for, exactly ? Is
> there a plan to have in the future a 64-bit PID ?

This has nothing to do with PIDs.  We need 64-bit values for more
complex bit fields which can then be stored in the futex.  One example
is a new, much faster rwlock implementation.  These are not practical
without 64-bit futexes.  This is why I asked Ingo to add the code.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig3C9AACEC80138563F74F3ED7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFnLYD2ijCOnn/RHQRAoLpAJ9+TDxRI8UatSXtoOiN3J1+p2Hk3wCfXRpd
HoIlAG+eEF67spnpBDBUAUk=
=iU/4
-----END PGP SIGNATURE-----

--------------enig3C9AACEC80138563F74F3ED7--
