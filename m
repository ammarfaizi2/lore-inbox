Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313068AbSDCG22>; Wed, 3 Apr 2002 01:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDCG2S>; Wed, 3 Apr 2002 01:28:18 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:13230 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313068AbSDCG2C>;
	Wed, 3 Apr 2002 01:28:02 -0500
Message-ID: <3CAAA0F2.2050207@candelatech.com>
Date: Tue, 02 Apr 2002 23:28:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: linux.bkbits.net compile failure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there is a problem compiling the modules:

ld -m elf_i386 -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o hosts.o highlevel.o csr.o nodemgr.o
gcc -D__KERNEL__ -I/home/greear/kernel/2.4/bk/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/bk/linux-2.4/include/linux/modversions.h  -DKBUILD_BASENAME=pcilynx  -c -o pcilynx.o pcilynx.c
pcilynx.c: In function `mem_open':
pcilynx.c:647: `num_of_cards' undeclared (first use in this function)
pcilynx.c:647: (Each undeclared identifier is reported only once
pcilynx.c:647: for each function it appears in.)
pcilynx.c:647: `cards' undeclared (first use in this function)
pcilynx.c: In function `aux_poll':
pcilynx.c:706: `cards' undeclared (first use in this function)
make[2]: *** [pcilynx.o] Error 1
make[2]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers'
make: *** [_mod_drivers] Error 2


Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


