Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbTCWRn6>; Sun, 23 Mar 2003 12:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263133AbTCWRn6>; Sun, 23 Mar 2003 12:43:58 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:50566 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S263132AbTCWRn5>;
	Sun, 23 Mar 2003 12:43:57 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm4
References: <20030323020646.0dfcc17b.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 23 Mar 2003 18:55:00 +0100
In-Reply-To: <20030323020646.0dfcc17b.akpm@digeo.com>
Message-ID: <87he9uge8b.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> 
> [SNIP]
> 

Ouch:

  gcc -Wp,-MD,drivers/char/.genrtc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=genrtc -DKBUILD_MODNAME=genrtc -c -o drivers/char/.tmp_genrtc.o drivers/char/genrtc.c
drivers/char/genrtc.c:100: warning: static declaration for `gen_rtc_interrupt' follows non-static
drivers/char/genrtc.c: In function `gen_rtc_timer':
drivers/char/genrtc.c:135: warning: comparison of distinct pointer types lacks a cast
drivers/char/genrtc.c: In function `gen_rtc_open':
drivers/char/genrtc.c:358: warning: `MOD_INC_USE_COUNT' is deprecated (declared at include/linux/module.h:431)
drivers/char/genrtc.c: In function `gen_rtc_release':
drivers/char/genrtc.c:377: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at include/linux/module.h:443)
drivers/char/genrtc.c: In function `gen_rtc_proc_output':
drivers/char/genrtc.c:453: void value not ignored as it ought to be
drivers/char/genrtc.c:498: `RTC_BATT_BAD' undeclared (first use in this function)
drivers/char/genrtc.c:498: (Each undeclared identifier is reported only once
drivers/char/genrtc.c:498: for each function it appears in.)
make[2]: *** [drivers/char/genrtc.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
