Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbTC0TFc>; Thu, 27 Mar 2003 14:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261359AbTC0TFc>; Thu, 27 Mar 2003 14:05:32 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:22712 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261358AbTC0TF3>; Thu, 27 Mar 2003 14:05:29 -0500
Message-ID: <3E834DDF.20001@oracle.com>
Date: Thu, 27 Mar 2003 20:15:43 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.66 genrtc.c broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this has been already posted - I've been unsubscribed
  from l-k in the last days...

gcc -Wp,-MD,drivers/char/.genrtc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=genrtc -DKBUILD_MODNAME=genrtc -c -o drivers/char/genrtc.o drivers/char/genrtc.c
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

It seems the definition of RTC_BATT_BAD isn't found.

--alessandro

  "Life is for the living, you've got to be willing
    A song ain't a song until someone starts singing"
       (Wallflowers, "Too Late To Quit")

