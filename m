Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293543AbSBZImI>; Tue, 26 Feb 2002 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293545AbSBZIl6>; Tue, 26 Feb 2002 03:41:58 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:56200 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S293543AbSBZIlm> convert rfc822-to-8bit; Tue, 26 Feb 2002 03:41:42 -0500
Date: Tue, 26 Feb 2002 09:41:36 +0100
Message-Id: <200202260841.g1Q8fWv03208@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <ch.nolte@web.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: drivers/block/rd.c compile error
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys!

I think I`ve found a problem with the Linux-Sources 2.5.5. I have compiled
the code on two different systems, this is what happened:


gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.5.5/include/linux/modversions.h  -DKBUILD_BASENAME=rd  -c -o rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[2]: *** [rd.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5/drivers'
make: *** [_mod_drivers] Error 2

I did:

# cat drivers/block/rd.c -n |grep bi_end_io
   271          sbh->bi_end_io(sbh, len >> 9);

seems to be an illegal function call, but yet I don`t know
how to fix this one...

I hope this could be of help for you.

bye

	Christian Nolte
______________________________________________________________________________
100 MB gute Gründe! Jetzt anmelden und FreeMail-Speicher erweitern für
Sprach-, Fax- und Mailnachrichten unter http://club.web.de/?mc=021103

