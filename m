Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264712AbTFLCrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264713AbTFLCrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:47:37 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19612 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264712AbTFLCrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:47:35 -0400
Date: Wed, 11 Jun 2003 21:57:17 -0500
From: Boris <boris@boris.ca>
Subject: [2.4.21rc8] possible header problems[byteorder.h/swab.h]
To: linux-kernel@vger.kernel.org
Message-id: <002101c3308e$5580cea0$43444218@raiden>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4.21rc8 with gcc 3.3 and it seems that after the 2.4.20
kernel, I can't compile kde anymore. I have written a message to the kde
mailing list and they suggest its a kernel problem. Heres an example.

make[5]: Leaving directory `/tmp/kdemultimedia/mpeglib/lib/util'
> make[4]: Leaving directory `/tmp/kdemultimedia/mpeglib/lib/util'
> Making all in input
> make[4]: Entering directory `/tmp/kdemultimedia/mpeglib/lib/input'
> if /bin/sh ../../../libtool --silent --mode=compile --tag=CXX g++
> -DHAVE_CONFIG_H -I. -I. -I../../.. -I/opt/kde/include
> -I/usr/lib/qt/include -I/usr/X11R6/include   -DQT_THREAD_SUPPORT
> -D_REENTRANT  -Wnon-virtual-dtor -Wno-long-long -Wundef -Wall -pedantic -W
> -Wpointer-arith -Wwrite-strings -ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE
> -Wcast-align -Wconversion -Wchar-subscripts -DNDEBUG -DNO_DEBUG -O2
> -Wformat-security -Wmissing-format-attribute -fno-exceptions
> -fno-check-new -fno-common -DQT_CLEAN_NAMESPACE -DQT_NO_ASCII_CAST
> -DQT_NO_STL -DQT_NO_COMPAT -DQT_NO_TRANSLATION  -MT cdromAccess.lo -MD -MP
> -MF ".deps/cdromAccess.Tpo" \
>   -c -o cdromAccess.lo `test -f 'cdromAccess.cpp' || echo
>   './'`cdromAccess.cpp; \
> then mv -f ".deps/cdromAccess.Tpo" ".deps/cdromAccess.Plo"; \
> else rm -f ".deps/cdromAccess.Tpo"; exit 1; \
> fi
> In file included from /usr/include/linux/cdrom.h:14,
>                  from cdromAccess_Linux.cpp:17,
>                  from cdromAccess.cpp:30:
> /usr/include/asm/byteorder.h:38: error: syntax error before `(' token
> /usr/include/asm/byteorder.h:42: error: '__u64' is used as a type, but is
> not
>    defined as a type.
> /usr/include/asm/byteorder.h:43: error: parse error before `}' token
> /usr/include/asm/byteorder.h:44: error: syntax error before `.' token
> /usr/include/asm/byteorder.h:50: error: syntax error before `.' token
> /usr/include/asm/byteorder.h:51: error: syntax error before `.' token
> /usr/include/asm/byteorder.h:52: error: parse error before `:' token
> In file included from /usr/include/linux/byteorder/little_endian.h:11,
>                  from /usr/include/asm/byteorder.h:65,
>                  from /usr/include/linux/cdrom.h:14,
>                  from cdromAccess_Linux.cpp:17,
>                  from cdromAccess.cpp:30:
> /usr/include/linux/byteorder/swab.h:199: error: syntax error before `('
> token /usr/include/linux/byteorder/swab.h:209: error: syntax error before
> `(' token /usr/include/linux/byteorder/swab.h:213: error: `__u64' was not
> declared in this scope
> /usr/include/linux/byteorder/swab.h:213: error: `addr' was not declared in
> this scope
> /usr/include/linux/byteorder/swab.h:214: error: variable or field
> `__swab64s'
>    declared void
> /usr/include/linux/byteorder/swab.h:214: error: `__swab64s' declared as an
>    `inline' variable
> /usr/include/linux/byteorder/swab.h:214: error: syntax error before `{'
> token make[4]: *** [cdromAccess.lo] Error 1
> make[4]: Leaving directory `/tmp/kdemultimedia/mpeglib/lib/input'
> make[3]: *** [all-recursive] Error 1
> make[3]: Leaving directory `/tmp/kdemultimedia/mpeglib/lib'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/tmp/kdemultimedia/mpeglib'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/tmp/kdemultimedia'
> make: *** [all] Error 2



