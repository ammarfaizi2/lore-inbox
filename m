Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278985AbRJ2Egg>; Sun, 28 Oct 2001 23:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278987AbRJ2Eg0>; Sun, 28 Oct 2001 23:36:26 -0500
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:57860 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S278985AbRJ2EgQ>;
	Sun, 28 Oct 2001 23:36:16 -0500
Date: Sun, 28 Oct 2001 22:36:51 -0600
From: Taral <taral@taral.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/net/ip_conntrack problems
Message-ID: <20011028223651.B17685@taral.net>
In-Reply-To: <20011028220854.A17685@taral.net> <3974.1004329672@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <3974.1004329672@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2001 at 03:27:52PM +1100, Keith Owens wrote:
> Some /proc output is blocked, it will only return complete lines.  If
> your buffer is not big enough to hold the next line then you don't get
> anything at all.  Try cat /proc/net/ip_conntrack | wc.

So why are 2 lines missing when I change the blocking factor from 256 to
512? Even cat reads in 16k blocks... Also:

% dd if=3D/proc/net/ip_conntrack bs=3D512 | perl -ne 'print length()."\n"'
0+2 records in
0+2 records out
153
138
169
151
167
139

No line is longer than 256 chars, so why are 2 lines missing when I read
in 256 byte blocks?

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvc3OMACgkQoQQF8xCPwJQFpQCfQ/8CthOt8IsQWYU1QdFKn0Mt
VqYAn1X5ey4Jf0a78ZbLmyEHdAc4xv6h
=pV+O
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
