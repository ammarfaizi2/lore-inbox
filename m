Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRA0Ent>; Fri, 26 Jan 2001 23:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130977AbRA0Enj>; Fri, 26 Jan 2001 23:43:39 -0500
Received: from vitelus.com ([64.81.36.147]:1292 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S129789AbRA0Enf>;
	Fri, 26 Jan 2001 23:43:35 -0500
Date: Fri, 26 Jan 2001 20:43:24 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: John Sheahan <john@reptechnic.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
Message-ID: <20010126204324.B10046@vitelus.com>
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au>; from john@reptechnic.com.au on Sat, Jan 27, 2001 at 03:34:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2001 at 03:34:26PM +1100, John Sheahan wrote:
> Hi
> my box has been running 2.4.1-pre10 for three days.
> This morning I noticed odd behavioue - ps and top wouuld freeze=20
> with no output.

I had the same problem with 2.4.1-pre10 and the zerocopy patchset.
I came home one day and xmms was frozen. Attempting to determine
whether it was stuck in an odd state, I ran ps aux. At a certain
point (presumably just when it started trying to print info about the
xmms process), ps froze up too. And any attempts to killall -9 these
processes made the killall freeze!

I'm not sure what made xmms freeze up in the first place. My first
though was a problem in the zerocopy patchset -- most of my mp3s are
played over NFS. However, XMMS was completely idle during the time I
was away from the computer, so I'm not sure what caused it. It seemed
clear, however, that the problem was contagious between processes.

I reverted back to 2.4.0-ac7 and have not had any more problems of this
nature.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6clHsdtqQf66JWJkRAqR7AKDPS7kFPvr+PL5CZPJEy0iN51ymmQCfZKGM
8kbLZ40LA+/dHPB5wCUXHDc=
=zMg5
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
