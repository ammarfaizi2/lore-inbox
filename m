Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWCZXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWCZXDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWCZXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:03:20 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:48014 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932158AbWCZXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:03:19 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Andi Kleen <ak@suse.de>
Subject: Re: 92c05fc1a32e5ccef5e0e8201f32dcdab041524c breaks x86_64 compile.
Date: Fri, 24 Mar 2006 22:00:06 +1000
User-Agent: KMail/1.9.1
Cc: Jean Delvare <khali@linux-fr.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603241529.28811.ncunningham@cyclades.com> <20060324121418.c4c03e1d.khali@linux-fr.org> <200603241236.20990.ak@suse.de>
In-Reply-To: <200603241236.20990.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1721398.6LgHTzOQyJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603242200.11244.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1721398.6LgHTzOQyJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andi.

On Friday 24 March 2006 21:36, Andi Kleen wrote:
> On Friday 24 March 2006 12:14, Jean Delvare wrote:
> > Hi Nigel, Andi, all,
> >
> > > It looks to me like the above commit from Andi causes a compilation
> > > failure on x86_64, because it makes pci_mmcfg_init non static:
> > >
> > > arch/x86_64/pci/mmconfig.c:152: error: conflicting types for
> > > =E2=80=98pci_mmcfg_init=E2=80=99 arch/i386/pci/pci.h:85: error: previ=
ous declaration of
> > > =E2=80=98pci_mmcfg_init=E2=80=99 was here
> > > make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
> > > make: *** [arch/x86_64/pci] Error 2
> >
> > I just hit the same compilation failure. Here's a fix which works for
> > me.
>
> This was my mistake. I fixed the problem in the wrong patch. And then
> Greg submitted only the one patch. I think Andrew fixed it up by
> submitting the other (unrelated) patch which fixes this too.

Thanks for the reply. It's not in Linus' tree yet, so I think the Andrew mi=
ght=20
still need some encouragement to merge it :)

Regards,

Nigel

--nextPart1721398.6LgHTzOQyJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEI99LN0y+n1M3mo0RAmx7AKC0H5IVr7nVUMTQQ09sbgCeUuEN5ACdHFNS
vyCNPWCS1lmP98Ax6lQ0sB8=
=hkLz
-----END PGP SIGNATURE-----

--nextPart1721398.6LgHTzOQyJ--
