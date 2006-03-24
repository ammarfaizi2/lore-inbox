Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWCZXDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWCZXDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWCZXDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:03:23 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:47502 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932162AbWCZXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:03:19 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: 92c05fc1a32e5ccef5e0e8201f32dcdab041524c breaks x86_64 compile.
Date: Fri, 24 Mar 2006 21:42:01 +1000
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603241529.28811.ncunningham@cyclades.com> <20060324121418.c4c03e1d.khali@linux-fr.org>
In-Reply-To: <20060324121418.c4c03e1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3533276.mS4rPVcJeb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603242142.07773.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3533276.mS4rPVcJeb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 24 March 2006 21:14, Jean Delvare wrote:
> Hi Nigel, Andi, all,
>
> > It looks to me like the above commit from Andi causes a compilation
> > failure on x86_64, because it makes pci_mmcfg_init non static:
> >
> > arch/x86_64/pci/mmconfig.c:152: error: conflicting types for
> > =E2=80=98pci_mmcfg_init=E2=80=99 arch/i386/pci/pci.h:85: error: previou=
s declaration of
> > =E2=80=98pci_mmcfg_init=E2=80=99 was here
> > make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
> > make: *** [arch/x86_64/pci] Error 2
>
> I just hit the same compilation failure. Here's a fix which works for
> me.

Yes, that's what I came up with too. Sent it a little earlier.

Thanks for the confirmation that I did the right thing :)

Nigel

--nextPart3533276.mS4rPVcJeb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEI9sPN0y+n1M3mo0RAs1vAKDIsZdqUjGCkK84RDHKTlKygC/BQQCfZKgs
foB5qP1a885kInKUSWbZ2Yk=
=DSGU
-----END PGP SIGNATURE-----

--nextPart3533276.mS4rPVcJeb--
