Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272181AbRIWGMb>; Sun, 23 Sep 2001 02:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272413AbRIWGMX>; Sun, 23 Sep 2001 02:12:23 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:63698 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S272181AbRIWGMQ>;
	Sun, 23 Sep 2001 02:12:16 -0400
Message-ID: <3BAD7D5A.B6D07E56@candelatech.com>
Date: Sat, 22 Sep 2001 23:12:42 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: pre15 modules compile problem: 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using RH 2.4.7-2 .config file (attached to a post I sent earlier tonight).

(I got the bzImage to compile by not compiling two IDE raid controllers,
looks like I'll have to dis-configure the ATM stuff now...)

gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h -g  -c -o firestream.o firestream.c
firestream.c: In function `firestream_init_one':
firestream.c:1916: label `err_out_free_fs_dev' used but not defined
make[2]: *** [firestream.o] Error 1
make[2]: Leaving directory `/home/greear/kernel/2.4/linux/drivers/atm'
make[1]: *** [_modsubdir_atm] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/linux/drivers'
make: *** [_mod_drivers] Error 2
[greear@grok linux]$ 


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
