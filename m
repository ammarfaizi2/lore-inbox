Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFCXdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFCXdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCXdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:33:16 -0400
Received: from [213.189.149.229] ([213.189.149.229]:13897 "HELO
	ei.schottelius.org") by vger.kernel.org with SMTP id S261174AbVFCX2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:28:37 -0400
Date: Sat, 4 Jun 2005 01:28:34 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: UM fails on PPC
Message-ID: <20050603232834.GT27717@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/FJxnyttrH06HRq2"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/FJxnyttrH06HRq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

make ARCH=3Dum fails on ppc, because
Kconfig_arch links to non existent file:

[1:23] ei:linux-2.6.11.11# uname -m
ppc

scripts/kconfig/conf -s arch/um/Kconfig
arch/um/Kconfig:71: can't open file "arch/um/Kconfig_arch"
make[2]: *** [silentoldconfig] Error 1
make[1]: *** [silentoldconfig] Error 2
make: *** [include/linux/autoconf.h] Error 2

[1:24] ei:linux-2.6.11.11# ls -l arch/um/Kconfig_arch
lrwxrwxrwx  1 root root 11 Jun  4 01:24 arch/um/Kconfig_arch -> Kconfig_ppc

[1:24] ei:linux-2.6.11.11# ls -l arch/um/Kconfig_ppc=20
ls: arch/um/Kconfig_ppc: No such file or directory

Is it simply missing or is UM generally not supported on PPC?

Nico

P.S.: I'll read the mailing list. If you reply to me, you need
      to confirm your reply.


--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--/FJxnyttrH06HRq2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQqDnobOTBMvCUbrlAQK+SQ/9E+EYeujnc9dahwqdRq9HxrpVVW6pGGL3
sNAdJtF+LXU7lODRu5Tkgl9BpxCUeAHqEijgBQE7vQDbzhYUGC3lL4smWFykJ20F
IYDsskmnP7PzHHpGMZumZ+tgI9KPaSbDieul7pPmJaZpwSjSk/jwB7zPKFJ/dXGi
/ljisMtXtTtDbSWE0HkTcrClWzdTL+IdCBj+FoK03SgyWhKIpQ/ekdWmOP/yvH7b
wqWBurYI0p6ECm+3VYsMzzziSi07RH6b1HLlnOJn0rwVxYGJxyFBYe4jRVUIJvvf
EzaXeKG6+R+OEyL3hpVm3Vvvf/BacYrr9LAtoXNURn+6EZKgdFPX4YuNPI5+heGR
VLcoJMelWb/XOWmeB3TFjpBBenSzWIL7YvTe+Obh0K81l7Ei+f5swl2C/Pc3PWfY
9+fdQF0NevOx/uJIbKdw5lhq1W66zjFfiWqelf6gcP3BbY6LZwLeSkV9cV7BXyS0
oaCC/x+m+pZ+MTVsuscVxStMjgbkHgEp5DpoB5fGuu4qdUwWy0ZrX6T6s2xmr6nQ
vng8MgGmRwiQOXM8w2bwownQR9pZmHsgDKF8zlgJQrSLLYLMXc4xjxHQA1Q4k3GT
XY843emR+P/bM+rXW1TzzS/UbjhnkeranDXqC0J9JsGwPsdHUeBz5VceeUcTD0Yv
Vyj153cyre8=
=Q5Ao
-----END PGP SIGNATURE-----

--/FJxnyttrH06HRq2--
