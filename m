Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWDXVgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWDXVgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDXVgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:36:21 -0400
Received: from smtp04.auna.com ([62.81.186.14]:9189 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1751282AbWDXVgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:36:21 -0400
Date: Mon, 24 Apr 2006 23:36:18 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gary Poppitz <poppitzg@iomega.com>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060424233618.2e9a133a@werewolf.auna.net>
In-Reply-To: <1145911546.1635.54.camel@localhost.localdomain>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	<1145911546.1635.54.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.1.1cvs22 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_OCIKsNQ6jiBa5VqZrCd0AZu;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.210.119] Login:jamagallon@able.es Fecha:Mon, 24 Apr 2006 23:36:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_OCIKsNQ6jiBa5VqZrCd0AZu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Apr 2006 21:45:46 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
> makes without exceptions being used. It might be possible to move to a
> strict C++ subset in the style of Apple but there isn't much interest in
> this.
>

Probably there will be two fields where a subset of C++ would give a big
save to the kernel:
- All that 'hand-coded' object orientation ans inheritance makes tons of
  structs repeating function pointers and the like, and using tricky
  rules to be sure nobody creates a class without a pure virtual method
  (funtion pointer). Binary space.
- You are doing in source code what the compiler should do for you.

> There are other problems too, notably the binary ABI between the C and C
> ++ compiler might not match for all cases (in particular there are
> corner cases with zero sized objects and C++).
>

There is no point in interfaccing C and C++. But a full C++-subset kernel
would be equally fast and probably safer to write code for that this.

But things are like they are. Kernel is C.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.16-jam9 (gcc 4.1.1 20060330 (prerelease)) #1 SMP PREEMPT Tue

--Sig_OCIKsNQ6jiBa5VqZrCd0AZu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFETUTSRlIHNEGnKMMRAg9SAKCukJkNUNJ/8e3YqTVrX5r9DXdCogCcDixl
1P0lo+HYoD/vUY6ZjLc4UZ0=
=xnAH
-----END PGP SIGNATURE-----

--Sig_OCIKsNQ6jiBa5VqZrCd0AZu--
