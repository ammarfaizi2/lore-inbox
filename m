Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSH1RFB>; Wed, 28 Aug 2002 13:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSH1RFB>; Wed, 28 Aug 2002 13:05:01 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31014 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S313070AbSH1RFB>; Wed, 28 Aug 2002 13:05:01 -0400
Date: Wed, 28 Aug 2002 18:09:09 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Pavel =?iso-8859-1?Q?Jan=EDk?= <Pavel@Janik.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport_serial and serial driver?
Message-ID: <20020828170909.GG959@redhat.com>
References: <m3it1vapw5.fsf@Janik.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jSQVS1cnOkN9brn"
Content-Disposition: inline
In-Reply-To: <m3it1vapw5.fsf@Janik.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+jSQVS1cnOkN9brn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2002 at 06:50:50PM +0200, Pavel Jan=EDk wrote:

> I use non-modular kernel with parport_serial driver built in (NetMos-based
> cards, 2.4.latest-vanilla patched for NetMos PCI IDs). The problem is that
> parport_serial is initialized before serial driver and thus both serial
> ports on that card are detected as ttyS00. This patch helped me:

Doesn't that then break ppdev?  I think the correct solution was
posted here not long ago---to add a call to the serial driver's init
function in parport_serial (with a protection against it being run
multiple times).

Tim.
*/

--+jSQVS1cnOkN9brn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9bQO0yaXy9qA00+cRAloQAKCTUdFaKc3C//W4e5w6xxltDDE3FQCfWpC0
jHIx6AwWqXkbs179yxpicU0=
=ncLS
-----END PGP SIGNATURE-----

--+jSQVS1cnOkN9brn--
