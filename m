Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTEVXPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTEVXPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:15:13 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:1922 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263448AbTEVXPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:15:11 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "David S. Miller" <davem@redhat.com>, akpm@digeo.com
Subject: Re: Error during compile of 2.5.69-mm8
Date: Fri, 23 May 2003 01:28:06 +0200
User-Agent: KMail/1.5.9
Cc: mfc@krycek.org, linux-kernel@vger.kernel.org
References: <1053611668.4649.1.camel@krycek> <20030522160218.57b828db.akpm@digeo.com> <20030522.160531.59667592.davem@redhat.com>
In-Reply-To: <20030522.160531.59667592.davem@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_G0Vz+n87a/VArN2";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305230128.06412.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_G0Vz+n87a/VArN2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

On May 23, David S. Miller wrote:
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Thu, 22 May 2003 16:02:18 -0700
>
>    Looks like David converted this macro into a no-op, then moved it into
>    netdevice.h.
>
>    Problem is, some non-network drivers were using it too.
>
> They shouldn't, it's backwards compatability crap for net drivers
> only.  Use explicit ->owner references elsewhere.

Well, as mentioned in my other mail there ARE many occurrences of=20
SET_MODULE_OWNER, for example in the ISDN subtree (just give 'grep' a try).=
=2E.

>    Maybe we should put it back the way it was and go edit all the
> netdrivers?
>
> Absolutely not.

Oops, that's what the patch in my other mail does...

> Yoshfuji posted a patch on linux-kernel to fix this already.

Sorry, I must have missed this patch - that would have made my work obsolet=
e -=20
but I'd like to see how that supports all the other SET_MODULE_OWNER calls=
=20
from all the other places...

Best regards
   Thomas Schlichter

--Boundary-02=_G0Vz+n87a/VArN2
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+zV0GYAiN+WRIZzQRAsSNAJsEphdyMR9iGKG/tqcLUV5imimHrQCdE2Up
hH7ijIO+JbBc4pUI9RKSQbI=
=cAXo
-----END PGP SIGNATURE-----

--Boundary-02=_G0Vz+n87a/VArN2--
