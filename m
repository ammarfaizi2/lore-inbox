Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUKCNzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUKCNzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKCNzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:55:53 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:9196 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261605AbUKCNzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:55:41 -0500
Message-ID: <4188E35A.1020905@g-house.de>
Date: Wed, 03 Nov 2004 14:55:38 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: linux-net@vger.kernel.org, pedro_m@yahoo.com
Subject: Re: 5 compile errors for 2.4-BK
References: <41879488.10601@g-house.de> <20041102173337.GG4978@stusta.de>
In-Reply-To: <20041102173337.GG4978@stusta.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian Bunk schrieb:
> Did you manually change your gcc link or are you using gcc 3.3 ?

well, it's a debian system and /etc/alternatives exist. so /usr/bin/gcc
points to /etc/alternatives/gcc and this points to /usr/bin/gcc-3.4
and gcc-3.4 is really gcc-3.4.2:

evil@sheep:~$ gcc --version
gcc (GCC) 3.4.2 (Debian 3.4.2-3)

> The interesting thing is the exact error message.

that's why i posted the url with the exact errors, but i can do it here
too. taken from:
http://nerdbynature.de/bits/sheep/latest-kernel/make-2.4-i386-BK.log

neighbour.c: In function `neigh_seq_stop':
neighbour.c:1805: warning: unused variable `tbl'
neighbour.c: At top level:
neighbour.c:1901: error: `THIS_MODULE' undeclared here (not in a function)
neighbour.c:1901: error: initializer element is not constant
neighbour.c:1901: error: (near initialization for `neigh_stat_seq_fops.owner')
make[3]: [neighbour.o] Error 1 (ignored)

arp.c:1342: error: `THIS_MODULE' undeclared here (not in a function)
arp.c:1342: error: initializer element is not constant
arp.c:1342: error: (near initialization for `arp_seq_fops.owner')
make[3]: [arp.o] Error 1 (ignored)

> Your 5 errors are actually only two (similar) compile errors.

yes, 2 errors, the other ones were only deduced by them.

thanks,
Christian.
- --
BOFH excuse #437:

crop circles in the corn shell
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiONZ+A7rjkF8z0wRAtd4AJ9cO2nBMT8Q3Wx5KnlOFF0u/7D9MQCfe47a
NmEIEq3NXxHeEUt1vSHQbvs=
=osRi
-----END PGP SIGNATURE-----
