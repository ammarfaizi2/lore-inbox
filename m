Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSBKHPx>; Mon, 11 Feb 2002 02:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSBKHPo>; Mon, 11 Feb 2002 02:15:44 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:44300 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287425AbSBKHP1>; Mon, 11 Feb 2002 02:15:27 -0500
Subject: 2.4.5 -- Hundreds of compile errors in lib/zlib_deflate/deflate.c
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 23:12:12 -0800
Message-Id: <1013411533.30864.56.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this is a bug in the configuration scripts or data.
I ran "make oldconfig" over an older .config file.  If there
is a logic error here, oldconfig did not catch it.  Also, 
I think I probably enabled these options accidentally when 
running "make oldconfig" for 2.4.5-pre6. 

# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE -I
/usr/src/linux/lib/zlib_deflate  -c -o deflate.o deflate.c
deflate.c:52:25: linux/zutil.h: No such file or directory
In file included from deflate.c:53:
defutil.h:42: parse error before `ush'
defutil.h:42: warning: no semicolon at end of struct or union
defutil.h:42: warning: no semicolon at end of struct or union
defutil.h:43: warning: type defaults to `int' in declaration of `code'
defutil.h:43: warning: data definition has no type or storage class
defutil.h:44: warning: type defaults to `int' in declaration of `fc'
defutil.h:44: warning: data definition has no type or storage class
defutil.h:46: parse error before `ush'
defutil.h:46: warning: no semicolon at end of struct or union
defutil.h:47: warning: type defaults to `int' in declaration of `len'
defutil.h:47: warning: data definition has no type or storage class
defutil.h:48: warning: type defaults to `int' in declaration of `dl'
defutil.h:48: warning: data definition has no type or storage class
defutil.h:49: parse error before `}'
defutil.h:49: warning: type defaults to `int' in declaration of
`ct_data'
defutil.h:49: warning: data definition has no type or storage class
defutil.h:59: parse error before `ct_data'
defutil.h:59: warning: no semicolon at end of struct or union
defutil.h:62: parse error before `}'
defutil.h:62: warning: type defaults to `int' in declaration of
`tree_desc'
defutil.h:62: warning: data definition has no type or storage class
defutil.h:64: parse error before `Pos'
defutil.h:64: warning: type defaults to `int' in declaration of `Pos'
defutil.h:64: warning: data definition has no type or storage class
defutil.h:65: parse error before `FAR'
defutil.h:65: warning: type defaults to `int' in declaration of `Posf'
defutil.h:65: warning: data definition has no type or storage class
defutil.h:73: parse error before `z_streamp'
defutil.h:73: warning: no semicolon at end of struct or union
defutil.h:75: parse error before `*'
defutil.h:75: warning: type defaults to `int' in declaration of
`pending_buf'
defutil.h:75: warning: data definition has no type or storage class
defutil.h:76: parse error before `pending_buf_size'
defutil.h:76: warning: type defaults to `int' in declaration of
`pending_buf_size'
defutil.h:76: warning: data definition has no type or storage class
defutil.h:77: parse error before `*'
defutil.h:77: warning: type defaults to `int' in declaration of
`pending_out'
defutil.h:77: warning: data definition has no type or storage class
defutil.h:80: parse error before `data_type'
defutil.h:80: warning: type defaults to `int' in declaration of
`data_type'
defutil.h:80: warning: data definition has no type or storage class
defutil.h:81: parse error before `method'
defutil.h:81: warning: type defaults to `int' in declaration of `method'
defutil.h:81: warning: data definition has no type or storage class
defutil.h:86: parse error before `w_size'
defutil.h:86: warning: type defaults to `int' in declaration of `w_size'
defutil.h:86: warning: data definition has no type or storage class
defutil.h:87: parse error before `w_bits'
defutil.h:87: warning: type defaults to `int' in declaration of `w_bits'
defutil.h:87: warning: data definition has no type or storage class
defutil.h:88: parse error before `w_mask'
defutil.h:88: warning: type defaults to `int' in declaration of `w_mask'
defutil.h:88: warning: data definition has no type or storage class
defutil.h:90: parse error before `*'
defutil.h:90: warning: type defaults to `int' in declaration of `window'
defutil.h:90: warning: data definition has no type or storage class
defutil.h:100: parse error before `window_size'
defutil.h:100: warning: type defaults to `int' in declaration of
`window_size'
defutil.h:100: warning: data definition has no type or storage class
defutil.h:105: parse error before `*'
defutil.h:105: warning: type defaults to `int' in declaration of `prev'
defutil.h:105: warning: data definition has no type or storage class
defutil.h:111: parse error before `*'
defutil.h:111: warning: type defaults to `int' in declaration of `head'
defutil.h:111: warning: data definition has no type or storage class
defutil.h:113: parse error before `ins_h'
defutil.h:113: warning: type defaults to `int' in declaration of `ins_h'
defutil.h:113: warning: data definition has no type or storage class


