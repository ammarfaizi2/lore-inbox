Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTDHSZw (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 14:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDHSZw (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 14:25:52 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:23059 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261493AbTDHSZt (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 14:25:49 -0400
Date: Tue, 8 Apr 2003 20:37:10 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5.67] gen_rtc compile error
Message-ID: <Pine.LNX.4.51L.0304082033140.20726@piorun.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to build my kernel I get:

  gcc -Wp,-MD,drivers/char/.genrtc.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=genrtc -DKBUILD_MODNAME=genrtc -c -o 
drivers/char/.tmp_genrtc.o drivers/char/genrtc.c
drivers/char/genrtc.c:100: warning: static declaration for `gen_rtc_interrupt' follows non-static
drivers/char/genrtc.c: In function `gen_rtc_timer':
drivers/char/genrtc.c:135: warning: comparison of distinct pointer types lacks a cast
drivers/char/genrtc.c: In function `gen_rtc_proc_output':
drivers/char/genrtc.c:453: void value not ignored as it ought to be
drivers/char/genrtc.c:498: `RTC_BATT_BAD' undeclared (first use in this function)
drivers/char/genrtc.c:498: (Each undeclared identifier is reported only once
drivers/char/genrtc.c:498: for each function it appears in.)
drivers/char/genrtc.c:448: warning: `flags' might be used uninitialized in this function
make[3]: *** [drivers/char/genrtc.o] Error 1
make[2]: *** [drivers/char] Error 2
make[1]: *** [drivers] Error 2
make: *** [modules] Error 2

My kernel configuration:
http://piorun.ds.pg.gda.pl/~blues/config-2.5.67.txt

-- 
pozdr.  Pawe³ Go³aszewski        
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
