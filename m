Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268166AbTBNDVx>; Thu, 13 Feb 2003 22:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268168AbTBNDVx>; Thu, 13 Feb 2003 22:21:53 -0500
Received: from BELLINI.MIT.EDU ([18.62.3.197]:14868 "EHLO bellini.mit.edu")
	by vger.kernel.org with ESMTP id <S268166AbTBNDVw>;
	Thu, 13 Feb 2003 22:21:52 -0500
Message-ID: <3E4C6314.4070105@bellini.mit.edu>
Date: Thu, 13 Feb 2003 22:31:32 -0500
From: ghugh Song <ghugh@bellini.mit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4-ac4 make xconfig fails
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I get on SuSE-8.1 box:

# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.21-pre4-ac4/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
tkparse.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o 
tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/char/drm/Config.in: 11: can't handle 
dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre4-ac4/scripts'
make: *** [xconfig] Error 2



Apparently, some people successfully went throught this procedure.

Best regards,

G. Hugh Song


