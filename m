Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267591AbSKQU1S>; Sun, 17 Nov 2002 15:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267593AbSKQU1S>; Sun, 17 Nov 2002 15:27:18 -0500
Received: from guru.webcon.net ([66.11.168.140]:39829 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S267591AbSKQU1R>;
	Sun, 17 Nov 2002 15:27:17 -0500
Date: Sun, 17 Nov 2002 15:33:03 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.20-rc1-ac4 p4-clockmod.c cpu_has_ht undeclared
Message-ID: <Pine.LNX.4.44.0211171530420.12883-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems -ac4 is missing some part of a patch? "cpu_has_ht" doesn't show up
anywhere else in the entire source tree.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac4+fs199+acpi20021101/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=p4_clockmod
-c -o p4-clockmod.o p4-clockmod.c
p4-clockmod.c: In function pufreq_p4_setdc':
p4-clockmod.c:72: pu_has_ht' undeclared (first use in this function)
p4-clockmod.c:72: (Each undeclared identifier is reported only once
p4-clockmod.c:72: for each function it appears in.)
make[1]: *** [p4-clockmod.o] Error 1

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------

