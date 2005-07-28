Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVG1Oxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVG1Oxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVG1OvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:51:22 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:42964 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261520AbVG1Osp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:48:45 -0400
Date: Fri, 29 Jul 2005 00:48:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] compat_sys_read/write
Message-Id: <20050729004838.116e8361.sfr@canb.auug.org.au>
In-Reply-To: <20050728141653.GA22173@infradead.org>
References: <20050728234341.3303d5fe.sfr@canb.auug.org.au>
	<20050728141653.GA22173@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__29_Jul_2005_00_48_38_+1000_zXQ_Z3Ek5Xazbo0E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__29_Jul_2005_00_48_38_+1000_zXQ_Z3Ek5Xazbo0E
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Jul 2005 15:16:53 +0100 Christoph Hellwig <hch@infradead.org> wr=
ote:
>
> This looks totally horrible, especially as we'd need readv/writev and
> pread/pwrite aswell.  I don't think anyone but Andi actually liked this
> approach when discussed earlier.

readv/writev were done ages ago (since they are necessary for other
reasons).  pread/pwrite I can look at later - but I don't think they would
be used to read/write events from evedv and we do *NOT* want to encourage
people to use read/write on structures (especially ones that need compat_
munging.

I know this is horrible but evdev needs fixing somehow - and I argued for
the other alternative.

And where were you a week ago when I asked if I should post this patch?=20
And why didn't you guys corner Andi at OLS? :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__29_Jul_2005_00_48_38_+1000_zXQ_Z3Ek5Xazbo0E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6PBLFdBgD/zoJvwRAnUYAJwI4PpP9sPzN+RfhBz1dhmpZLVRtACfRXtC
FchZabISvEPgi94kz3RfkBA=
=Zy0b
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Jul_2005_00_48_38_+1000_zXQ_Z3Ek5Xazbo0E--
