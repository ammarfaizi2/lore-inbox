Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264739AbUDWHeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264739AbUDWHeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 03:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbUDWHeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 03:34:13 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:45584 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S264739AbUDWHeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 03:34:08 -0400
Subject: Re: ACPI suspend to RAM weirdness
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: jason@stdbev.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6ced92039bd020302f1a48705418ddbb@stdbev.com>
References: <6ced92039bd020302f1a48705418ddbb@stdbev.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jz25k06NmRRZaiOD86b4"
Organization: iNES Group
Message-Id: <1082705644.1560.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Fri, 23 Apr 2004 10:34:05 +0300
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jz25k06NmRRZaiOD86b4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-22 at 11:24 -0500, Jason Munro wrote:
> Hello all,
>    I can sucessfully suspend with 'echo 3 > /proc/acpi/sleep' on my Toshi=
ba
> Satellite 1410-S173. It also wakes up fine, except after waking it jumps =
to
> init 0 and shuts down. It's been this way with every kernel I have tried
> since 2.6.4. I know it worked with 2.6.1 but I'm not sure exactly at what
> point between that and 2.6.4 it changed, or even if this is a userspace o=
r
> kernel issue. Yesterday I tried with 2.6.6-rc2 and rc2-mm1 and it still
> behaves the same.
>=20
> Any suggestions?


Kill acpid before suspending.
For some reason ACPI does not "clear" the power button event generated
when you press it to return from suspend :)

Same problem here with an Toshiba Sattelite Pro 6100.

There is some tracking done on this bug at:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D118353

--=20
Cioby


--=-jz25k06NmRRZaiOD86b4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiMbsQisRnSkd59cRAtDjAJ4879O39v03+LhgRzD8NLw46I1M+QCffCsz
bFG8ZkvlUiNj/6nOlAbJOKg=
=kLjL
-----END PGP SIGNATURE-----

--=-jz25k06NmRRZaiOD86b4--

