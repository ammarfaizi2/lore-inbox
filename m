Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTEWAAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTEWAAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:00:51 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:37004 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263444AbTEWAAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:00:49 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Error during compile of 2.5.69-mm8
Date: Fri, 23 May 2003 02:13:34 +0200
User-Agent: KMail/1.5.9
Cc: akpm@digeo.com, mfc@krycek.org, linux-kernel@vger.kernel.org
References: <200305230128.06412.schlicht@uni-mannheim.de> <200305230147.00730.schlicht@uni-mannheim.de> <20030522.164845.48515977.davem@redhat.com>
In-Reply-To: <20030522.164845.48515977.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_zeWz+gjdFmySjp9";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305230213.39460.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_zeWz+gjdFmySjp9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On May 23, David S. Miller wrote:
>    From: Thomas Schlichter <schlicht@uni-mannheim.de>
>    Date: Fri, 23 May 2003 01:47:00 +0200
>
>    There was a discussion about SET_MODULE_OWNER here on the list, once.
>    You can find it here:
>
> I know about it and in fact Rusty is the one that told me
> to do what I did with SET_MODULE_OWNER.
>
> FACT: SET_MODULE_OWNER() tracks how to set the module reference
>       for a struct netdevice.
>
> It always lived in netdevice.h and always served exactly this purpose.

As far as I can see it lived in modules.h... (Even in 2.4.10 if the sources=
=20
here on my disk don't lie)

So nothing (not even the name) indicated its membership to netdevice for a=
=20
very long time!

> So when I deleted ->owner from struct netdevice, SET_MODULE_OWNER
> became a nop.

=46or netdevice you are right!

> Therefore, it was a complete error for anyone else to start using this
> macro for other structures.

So nobody should better use THIS_MODULE?! Well it currently is defined in=20
module.h, but perhaps it was first defined in isdn.h and may be removed by=
=20
its maintainer when he thinks he does not need it anymore...

=46or ME and many other driver developers SET_MODULE_OWNER does not belong =
to=20
netdevice, it belongs to the module infrastructure!

Best regards
   Thomas Schlichter

--Boundary-02=_zeWz+gjdFmySjp9
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+zWezYAiN+WRIZzQRAl9CAKDf8LroLCSPSfgSV+CkGeQfT4y/3wCfY5HC
P3hM0/ldmZlaSrv9sd3dsto=
=xA32
-----END PGP SIGNATURE-----

--Boundary-02=_zeWz+gjdFmySjp9--
