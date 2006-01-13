Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422709AbWAMPGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWAMPGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWAMPGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:06:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422709AbWAMPGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:06:31 -0500
Subject: Re: 2.6.15-rt4 failure with LATENCY_TRACE on x86_64
From: Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1137122280.7338.6.camel@localhost.localdomain>
References: <1137103652.11354.40.camel@localhost.localdomain>
	 <1137122280.7338.6.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GMe4KpA1LsPrVGldLIjt"
Date: Fri, 13 Jan 2006 09:06:01 -0600
Message-Id: <1137164761.3332.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GMe4KpA1LsPrVGldLIjt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-01-12 at 22:18 -0500, Steven Rostedt wrote:
> OK, I'm actually sending you this email on a x86_64 running
> 2.6.15-rt4-sr2, with latency tracing on.  But unfortunately, I have a
> AMD X2 that each core has it's own tsc counter that is not in sync, and
> since the latency tracer uses tsc, I get garbage.  But beware, the tsc
> does slow down when the cpu idles, so it gives bad results even for non
> x2 systems.
>=20
Hmm, I didn't realize that (I'm running on a uni-processor system). I
just pulled your rt4-sr2 patch and will apply/rebuild/test.=20

> I finally was able to boot this with using the PM timer, but the
> beginning of my dmesg is still filled with:
>=20
> read_tsc: ACK! TSC went backward! Unsynced TSCs?
>=20
> Have you tried booting with idle=3Dpoll? I wonder if that would help?

No, I thought that was strictly an SMP issue. I'll try it as well.

Thanks,
Clark

--=20
Clark Williams <williams@redhat.com>

--=-GMe4KpA1LsPrVGldLIjt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx8HZHyuj/+TTEp0RAhUkAJ4qBsfVn64RdSHILo+jNmxnPpIqcwCg28Bv
+cAZey9Xy+H14I8kxTRoB9M=
=J3uc
-----END PGP SIGNATURE-----

--=-GMe4KpA1LsPrVGldLIjt--

