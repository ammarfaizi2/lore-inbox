Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTAWTxV>; Thu, 23 Jan 2003 14:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTAWTxV>; Thu, 23 Jan 2003 14:53:21 -0500
Received: from h80ad266c.async.vt.edu ([128.173.38.108]:17282 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266210AbTAWTxT>; Thu, 23 Jan 2003 14:53:19 -0500
Message-Id: <200301232002.h0NK2875012830@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: User & <breno_silva@beta.bandnet.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Expand VM 
In-Reply-To: Your message of "Thu, 23 Jan 2003 16:40:14 -0300."
             <20030123194014.M374@beta.bandnet.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <20030123155627.M95099@beta.bandnet.com.br> <200301231655.h0NGtc75010414@turing-police.cc.vt.edu>
            <20030123194014.M374@beta.bandnet.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-264112535P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Jan 2003 15:02:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-264112535P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jan 2003 16:40:14 -0300, User & said:
> Create a new VMA on Linux B for Linux A is easy , but i have a problem =
, the =

> address of VMA is returned on Linux B , so the VMA created on Linux B c=
an not
 =

> be used for process of linux A.

It's unclear whether you're just trying to use B for added swap space, or=

if you want B to actually run code.

If it's the former, all you have to do is allocate a lot of disk space on=
 B,
and NFS export it to A, and then have A mount it (you might need to
use a loopback mount of a file on the NFS partition and then 'swapon' the=

loopback - I dont think swapon will directly take an NFS file)

> The problem is "how can i return address of VMA created on LINUX B to L=
inux =

> A , and use this space ?".

If you're trying to get B to actually run code, it gets a lot more messy,=
 as
you have to worry about open file descriptors, race conditions, and many
other things.
-- =

				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-264112535P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+MEo/cC3lWbTT17ARAq1cAKDspBeZAwaGLpcF0YoHEKBFL0xToQCbBMh8
A4Q7l+K8FVwkHnTeQnGVMLI=
=jSLd
-----END PGP SIGNATURE-----

--==_Exmh_-264112535P--
