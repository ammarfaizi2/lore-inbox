Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWCTUzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWCTUzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWCTUzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:55:47 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:17315 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030278AbWCTUzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:55:47 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Merge strategy for klibc
Date: Mon, 20 Mar 2006 21:54:26 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
References: <441F0859.2010703@zytor.com>
In-Reply-To: <441F0859.2010703@zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart114319175.O9GfXWIWJB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603202154.36511.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart114319175.O9GfXWIWJB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

first thanks for your good work on that!

On Monday, 20. March 2006 20:54, H. Peter Anvin wrote:
> The current git tree includes a number of utilities, like dash (sh),=20
> which aren't used by the default kinit configuration.

But its quite useful to be dropped into a shell, if anything goes wrong.
e.g. ubuntu assumes an modular kernel, which I don't like to have
and I got dropped into the shell quite often until all scripts worked as=20
expected.

> Additionally, =20
> right now kinit is built monolitically, in other words there isn't a=20
> CONFIG_ option to turn off nfsmount, for example.

Yes, since after development of your init setup, you want to shrink it
as much as possible :-)

But all of this stuff is janitorial and can be done after merging the basic
ideas and completing the setup code move to user space.

Another idea is to still allow the current archive setups for initramfs,
because a static /dev might be best for embedded stuff where
you basically pre-compose a system image and download that to flash.

> 3. Path: it probably would make sense to push this into -mm first?

The usr/ part should go in ASAP, but please rip out the setup stuff=20
only after a grace period announced in Documentation/feature-removal.txt
or sth. like that.


Regards

Ingo Oeser

--nextPart114319175.O9GfXWIWJB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEHxaMU56oYWuOrkARAomdAKCy5VZDhEAcBqQnV3kliCfHVizd2QCcCzEu
Dls5/JuX+QLwgssn81nrKSU=
=WKdJ
-----END PGP SIGNATURE-----

--nextPart114319175.O9GfXWIWJB--
