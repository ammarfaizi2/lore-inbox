Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSKUWFi>; Thu, 21 Nov 2002 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSKUWFi>; Thu, 21 Nov 2002 17:05:38 -0500
Received: from CPE-203-51-30-76.nsw.bigpond.net.au ([203.51.30.76]:52470 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S264931AbSKUWFh>; Thu, 21 Nov 2002 17:05:37 -0500
Message-ID: <3DDD5A57.D7A73792@eyal.emu.id.au>
Date: Fri, 22 Nov 2002 09:12:39 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-rc2-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20rc2aa1 - compile failures
References: <20021121110348.GC1259@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=DAC960  -DEXPORT_SYMTAB
-c DAC960.c
DAC960.c: In function `DAC960_ProcessCompletedBuffer':
DAC960.c:3029: warning: passing arg 1 of `blk_finished_io' makes pointer
from integer without a cast
DAC960.c:3029: too few arguments to function `blk_finished_io'
make[2]: *** [DAC960.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/block'

The new first arg that was added to blk_finished_io(req, ) is not
supplied in this module (it was fixed in other modules).


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=core  -c -o core.o
core.c
core.c: In function `bnep_session':
core.c:461: structure has no member named `nice'
make[3]: *** [core.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/net/bluetooth/bnep'

This is the same as in rc1aa1.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
