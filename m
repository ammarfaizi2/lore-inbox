Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUDEVVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUDEVVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:21:07 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:25815 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263284AbUDEVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:19:22 -0400
Message-ID: <4071CD50.2000402@g-house.de>
Date: Mon, 05 Apr 2004 23:19:12 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Sven Hartge <hartge@ds9.gnuu.de>, linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
References: <20040329151515.GD2895@smtp.west.cox.net> <Pine.GSO.4.44.0403301430180.12030-100000@math.ut.ee> <E1B8OEW-0006Jb-BX@ds9.argh.org> <40704743.3000909@g-house.de> <20040405155022.GL31152@smtp.west.cox.net>
In-Reply-To: <20040405155022.GL31152@smtp.west.cox.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[ if someone is bored from me cc'ing too many - plz cry! ]

Tom Rini wrote:
| OK, hmm.  I've got some better ideas then.  It sounds like the code to
| have puts show up on VGA isn't selected/compiled in.  Or, there's still
| some other problem wrt the OF transition code.  Just having a serial
| console selected still doesn't give output however, right?

I'll give it a try with 2.6 this week.

|
|>another issue here: i was finally able to cross-compile 2.5.x / 2.6.x
|>kernels (on x86). i tried to compile kernels from 2.5.21 on with
|>"allnoconfig" (was introduced in 2.5.21). only 2.5.30 can be built, all
|>other attempts to build "zImage" fail...(still compiling 2.5.6x)...
|>(full logs of builds available...)
|
| The simple answer is, don't use allnoconfig :).  Do a 'make
| common_defconfig' and then from there turn off stuff you don't need.

um, yes. but the target "common_defconfig" was disabled somewhere in
2.5, so my shini script broke. i wanted to do common_defconfig first,
then always keep my .config and do "oldconfig" after patching, but
somehow my script broke, so i went with "allnoconfig"...but ok, i'll try
again.

if anyone is interested: http://nerdbynature.de/bits/sheep/build/
all the logfiles produced when patchin/compiling 2.5.21 up to 2.5.75.


right here the latest 2.4-benh and 2.6-benh kernels (via rsync), also
compiled via crosscompile: http://nerdbynature.de/bits/sheep/latest-kernel/

thanks,
Christian.
- --
BOFH excuse #212:

Of course it doesn't work. We've performed a software upgrade.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAcc1Q+A7rjkF8z0wRAtxBAKCrbpGe3/HlW8UMLAdFKHCnWiyB/QCfV4FC
hVoNM7pW01ntTdFBETVxT44=
=jCF2
-----END PGP SIGNATURE-----
