Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315274AbSELBQv>; Sat, 11 May 2002 21:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSELBQu>; Sat, 11 May 2002 21:16:50 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:8904 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315274AbSELBQt>;
	Sat, 11 May 2002 21:16:49 -0400
Date: Sun, 12 May 2002 03:16:44 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205120116.DAA26360@harpo.it.uu.se>
To: davej@suse.de, madkiss@madkiss.org
Subject: Re: [PATCH] Trivial bugfix in 3c509.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave & Martin,

I noticed you guys included Kasper Dupont's patch in your
2.5.15 patch kits:
>With 3c509 compiled in kernel calling ifup after lots of
>diskaccess causes an Oops.
>
>read_eeprom was incorrectly marked as __init. This patch
>applies against 2.4.19-pre8-ac1 and maybee also 2.4.19-pre8:

Note that 2.4.19-pre8-ac1 has a newer version of 3c509.c than
either 2.4.19-pre8 vanilla or 2.5.15, and it's only the newer
version that calls read_eeprom() from non-__init code.
This patch is not needed for 2.5.15.

(The only calls to read_eeprom() in 2.5.15 are from el3_probe(),
which is __init.)

/Mikael
