Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTIJElR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTIJElQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:41:16 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:50446 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S264546AbTIJElP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:41:15 -0400
Date: Wed, 10 Sep 2003 00:41:05 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF OSABI
Message-ID: <20030910044105.GA12758@linux-sh.org>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20030910010933.GK18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20030910010933.GK18654@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2003 at 02:09:33AM +0100, Matthew Wilcox wrote:
> --- arch/mips/kernel/irixelf.c	8 Sep 2003 21:41:38 -0000	1.3
> +++ arch/mips/kernel/irixelf.c	8 Sep 2003 22:00:20 -0000	1.4
> @@ -1088,6 +1088,7 @@ static int irix_core_dump(long signr, st
>  	elf.e_ident[EI_CLASS] = ELFCLASS32;
>  	elf.e_ident[EI_DATA] = ELFDATA2LSB;
>  	elf.e_ident[EI_VERSION] = EV_CURRENT;
> +	elf->e_ident[EI_OSABI] = ELF_OSABI;
>  	memset(elf.e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);

Someone was a bit too hasty here. Perhaps it might be a good idea to
change this to elf.e_ident instead.


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Xqth1K+teJFxZ9wRAu1RAJ4xaExEH8HHFnEHeEYQIsOsTkiF9wCggdjY
civq7EHXPwsiZltSrxu5Gf8=
=6cBM
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
