Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbRLEU4Q>; Wed, 5 Dec 2001 15:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLEU4J>; Wed, 5 Dec 2001 15:56:09 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:5652 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S284691AbRLEUyp>; Wed, 5 Dec 2001 15:54:45 -0500
Date: Wed, 5 Dec 2001 14:54:42 -0600
From: Tim Walberg <twalberg@mindspring.com>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
        Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removing an executable while it runs
Message-ID: <20011205145442.A12034@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Christopher Friesen <cfriesen@nortelnetworks.com>,
	Brian Gerst <bgerst@didntduck.org>,
	Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C0E4487.6000704@savoirfairelinux.com> <3C0E4803.3BBF045B@didntduck.org> <3C0E7CCD.F9553BBD@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0E7CCD.F9553BBD@nortelnetworks.com> from Christopher Friesen on 12/05/2001 14:00
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12/05/2001 15:00 -0500, Christopher Friesen wrote:
>>	Couldn't you use mlockall() to ensure that demand paging is not a factor=
?  Then
>>	you should be able to free up the disk space since the actual applicatio=
n is
>>	guaranteed to be in ram.
>>=09


mlockall() only locks those pages that are **currently** paged
in, or optionally those that will be paged in in the future.
Unless you have a way to make sure that all pages of the
binary are actually in memory before you call mlockall(),
this gains you nothing.



--=20
twalberg@mindspring.com

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBPA6Jj8PlnI9tqyVmEQLalgCgvcgZISgzjEU9qOg2xfG9hqXeixsAnjQG
95oKynVq/H0oi9g+bsnYnk3N
=TOen
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
