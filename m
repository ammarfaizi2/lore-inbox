Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSE0JPV>; Mon, 27 May 2002 05:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314906AbSE0JPT>; Mon, 27 May 2002 05:15:19 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:17415 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S314829AbSE0JPO> convert rfc822-to-8bit;
	Mon, 27 May 2002 05:15:14 -0400
Date: Mon, 27 May 2002 11:15:09 +0200 (CEST)
From: Clemens Schwaighofer <cs@pixelwings.com>
X-X-Sender: gullevek@lynx.piwi.intern
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.18-dj1 with gcc 3.1 ...
Message-ID: <Pine.LNX.4.44.0205271112500.23516-100000@lynx.piwi.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried to compile 2.5.18-dj1 with gcc 3.1 and it failed with NTFS as 
module:

gcc -D__KERNEL__ -I/usr/src/kernel/2.5.18-dj1/linux-2.5.18/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-DMODULE -DMODVERSIONS -include 
/usr/src/kernel/2.5.18-dj1/linux-2.5.18/include/linux/modversions.h 
-DNTFS_VERSION=\"2.0.7\" -DDEBUG  -DKBUILD_BASENAME=aops  -c -o aops.o 
aops.c
In file included from attrib.h:31,
                 from debug.h:31,
                 from ntfs.h:40,
                 from aops.c:30:
layout.h:299: unnamed fields of type other than struct or union are not 
allowed
layout.h:1450: unnamed fields of type other than struct or union are not 
allowed
layout.h:1466: unnamed fields of type other than struct or union are not 
allowed
layout.h:1715: unnamed fields of type other than struct or union are not 
allowed
layout.h:1892: unnamed fields of type other than struct or union are not 
allowed
layout.h:2052: unnamed fields of type other than struct or union are not 
allowed
layout.h:2064: unnamed fields of type other than struct or union are not 
allowed
make[2]: *** [aops.o] Error 1
make[2]: Leaving directory 
`/usr/src/kernel/2.5.18-dj1/linux-2.5.18/fs/ntfs'
make[1]: *** [_modsubdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/kernel/2.5.18-dj1/linux-2.5.18/fs'
make: *** [_mod_fs] Error 2

rest of the system is redhat 7.3 out of the box only gcc 3.1 was installed 
from rawhide rpms

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com

