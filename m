Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbUFDTwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUFDTwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUFDTwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:52:14 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39813 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265957AbUFDTwJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:52:09 -0400
Message-Id: <200406041950.i54JocXW026316@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6 
In-Reply-To: Your message of "Fri, 04 Jun 2004 22:33:41 +0300."
             <200406042233.41441.vda@port.imtp.ilyichevsk.odessa.ua> 
From: Valdis.Kletnieks@vt.edu
References: <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl> <200406041837.i54IbfYE023527@turing-police.cc.vt.edu>
            <200406042233.41441.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1240627216P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Jun 2004 15:50:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1240627216P
Content-Type: text/plain; charset=us-ascii

On Fri, 04 Jun 2004 22:33:41 +0300, Denis Vlasenko said:

> Using shell scripts instead of 'standard' init etc is
> way more configurable. As an example, my current setup
> at home:
> 
> My kernel params are:

Yes. Those are *YOUR* config setup parameters, that happen to work with *your*
specific configuration when everything is operational. Some problems:

1) Not all the world uses initrd....

2) I hope your /script/mount_root will Do The Right Thing if the mount fails
because it needs an fsck, for example.  Answering those 'y' and 'n' prompts can
be a problem if your keyboard isn't working yet..

3) Bonus points if you can explain how to, *without* a working keyboard,  modify
that /linuxrc on your initrd to deal with the situation where your keyboard
setup is wrong (think "booting with borrowed keyboard because your usual one
just suffered a carbonated caffeine overdose")...

There's a *BASIC* bootstrapping problem here - if you move "initialize and
handle the keyboard" into userspace, you then *require* that a significantly
larger chunk of userspace be operational in order to be able to even type at
the machine.  If you're trying to recover a *broken* userspace, it gets a lot
harder.

And the embedded people who use "init=/onlyprogramthateverruns" are going
to have a significant collective cow about this....



--==_Exmh_1240627216P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAwNKOcC3lWbTT17ARAi7yAKDAw6B8aRGouEI1CATgpTVfp3iY5wCaAkYB
lq2EYD1WiZQEc7dOyPv/qqg=
=Lo0p
-----END PGP SIGNATURE-----

--==_Exmh_1240627216P--
