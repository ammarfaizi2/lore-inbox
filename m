Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTFLLq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTFLLqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:46:25 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:20097 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264809AbTFLLqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:46:23 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [2.5.70-mm8] NETDEV WATCHDOG: eth0: transmit timed out
Date: Thu, 12 Jun 2003 13:59:36 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030611013325.355a6184.akpm@digeo.com> <200306111725.49952.schlicht@uni-mannheim.de> <20030611115626.26ddac3a.akpm@digeo.com>
In-Reply-To: <20030611115626.26ddac3a.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ssG6+wTQAvmkiNc";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306121359.41608.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ssG6+wTQAvmkiNc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> > OK, I've found it...!
>
> Thanks.
>
> > After reverting the pci-init-ordering-fix everything works as expected
> > again...
>
> Damn.  That patch fixes other bugs.  i386 pci init ordering is busted.

Now, after further investigation, it seems reverting the pci-init-ordering-=
fix=20
is not necessary... I simply had to switch off ACPI (for example with the=20
'acpi=3Doff' kernel parameter).

I recognized it because the changed kernel had the problems again if i star=
ted=20
it with 'pci=3Dnoacpi', but not with 'acpi=3Doff'. So I tried the original =
=2Dmm8=20
kernel with this option and... IT WORKS!

So perhaps it is better to leave this patch in the -mm tree and fix ACPI=20
(which does not work for me anyway).

Best regards
   Thomas Schlichter

--Boundary-02=_ssG6+wTQAvmkiNc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+6GssYAiN+WRIZzQRAsmnAKC32ZghTMX5vdNHCo56yOrQYqh7PgCfYjgh
3D5z8Z5nDgY2eQMR6oK9C48=
=QO5+
-----END PGP SIGNATURE-----

--Boundary-02=_ssG6+wTQAvmkiNc--
