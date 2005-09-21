Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVIUNB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVIUNB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVIUNB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:01:27 -0400
Received: from iucha.net ([209.98.146.184]:19372 "EHLO mail2.iucha.net")
	by vger.kernel.org with ESMTP id S1750886AbVIUNB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:01:26 -0400
Date: Wed, 21 Sep 2005 08:01:21 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG: 2.6.14-rc2 sets the wrong time in NVRAM on PowerMac G5
Message-ID: <20050921130121.GB23362@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.9i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

At shutdown, kernel 2.6.14-rc2 saves the wrong value in the hardware
clock, since at next bootup I get 21 August 1987.

I have narrowed the range down to:
   2.6.14-rc1 is good
   2.6.14-rc1-git1 is bad.

Also, the 2.6.14-rcX does not power off the machine at shutdown.
2.6.13 did work fine.

   florin@zeus$ cat /proc/cpuinfo
   processor       : 0
   cpu             : PPC970FX, altivec supported
   clock           : 2700.000000MHz
   revision        : 3.1

   processor       : 1
   cpu             : PPC970FX, altivec supported
   clock           : 2700.000000MHz
   revision        : 3.1

   timebase        : 33333333
   machine         : PowerMac
   detected as     : 336 (PowerMac G5)
   pmac flags      : 00000000
   pmac-generation : NewWorld

   florin@zeus$ dmesg | grep "Linux version"
   Linux version 2.6.14-rc2 (root@zeus) (gcc version 4.0.2 20050808
   (prerelease) (Ubuntu 4.0.1-4ubuntu8)) #1 SMP Tue Sep 20 17:24:52
   CDT 2005

Please let me know if you need more info, or want me to try a patch.

Thank you,
florin

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMVmhND0rFCN2b1sRAq18AKCUGdlyhKltfk/fzMKtkeyxD3alNACdHuGj
Xokhm4LghcVQZWPTEc74L7I=
=KFAk
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
