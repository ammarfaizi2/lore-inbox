Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263530AbTC3KAs>; Sun, 30 Mar 2003 05:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263531AbTC3KAs>; Sun, 30 Mar 2003 05:00:48 -0500
Received: from mta02bw.bigpond.com ([144.135.24.138]:4332 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263530AbTC3KAs>; Sun, 30 Mar 2003 05:00:48 -0500
Message-ID: <3E86C396.60706@bigpond.com>
Date: Sun, 30 Mar 2003 20:14:46 +1000
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.3a) Gecko/20021212
X-Accept-Language: en-au, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5.66] compile failure with RTC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Worked OK with 2.5.64:

gcc -Wp,-MD,drivers/char/.genrtc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes
   -Wno-trigraphs   -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
   -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix
   include    -DKBUILD_BASENAME=genrtc -DKBUILD_MODNAME=genrtc -c -o drivers/char/genrtc.o 
drivers/char/genrtc.c
drivers/char/genrtc.c:100: warning: static declaration for `gen_rtc_interrupt' follows non-static
drivers/char/genrtc.c: In function `gen_rtc_timer':
drivers/char/genrtc.c:135: warning: comparison of distinct pointer types lacks a cast
drivers/char/genrtc.c: In function `gen_rtc_proc_output':
drivers/char/genrtc.c:453: void value not ignored as it ought to be
drivers/char/genrtc.c:498: `RTC_BATT_BAD' undeclared (first use in this function)
drivers/char/genrtc.c:498: (Each undeclared identifier is reported only once
drivers/char/genrtc.c:498: for each function it appears in.)
make[2]: *** [drivers/char/genrtc.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

