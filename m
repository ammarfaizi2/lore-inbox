Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312270AbSCRJka>; Mon, 18 Mar 2002 04:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312271AbSCRJkT>; Mon, 18 Mar 2002 04:40:19 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:27154 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312270AbSCRJkL>; Mon, 18 Mar 2002 04:40:11 -0500
Message-Id: <200203180938.g2I9c1q27846@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
Subject: [-ENOCOMPILE] ataraid as module in linux-2.5.7-pre2
Date: Mon, 18 Mar 2002 11:37:33 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Martin Dalecki <martin@dalecki.de>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/.share/usr/src/linux-2.5.7-pre2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i386 -DMODULE -DMODVERSIONS -include 
/.share/usr/src/linux-2.5.7-pre2/include/linux/modversions.h  
-DKBUILD_BASENAME=ataraid  -DEXPORT_SYMTAB -c ataraid.c

ataraid.c: In function `ataraid_make_request':
ataraid.c:105: structure has no member named `b_rdev'
ataraid.c:103: warning: `minor' might be used uninitialized in this function
ataraid.c: In function `ataraid_split_request':
ataraid.c:182: structure has no member named `b_rsector'
ataraid.c:193: warning: passing arg 1 of `generic_make_request_Rsmp_dd2e0d32' 
makes pointer from integer without a cast
ataraid.c:193: too many arguments to function 
`generic_make_request_Rsmp_dd2e0d32'
ataraid.c:194: warning: passing arg 1 of `generic_make_request_Rsmp_dd2e0d32' 
makes pointer from integer without a cast
ataraid.c:194: too many arguments to function 
`generic_make_request_Rsmp_dd2e0d32'
ataraid.c: In function `ataraid_init':
ataraid.c:249: `hardsect_size' undeclared (first use in this function)
ataraid.c:249: (Each undeclared identifier is reported only once
ataraid.c:249: for each function it appears in.)
ataraid.c:280: warning: passing arg 2 of 
`blk_queue_make_request_Rsmp_e6d39e8a' from incompatible pointer 
typeataraid.c: In function `ataraid_exit':
ataraid.c:289: `hardsect_size' undeclared (first use in this function)
make[2]: *** [ataraid.o] Error 1
make[2]: Leaving directory `/.share/usr/src/linux-2.5.7-pre2/drivers/ide'
make[1]: *** [_modsubdir_ide] Error 2
make[1]: Leaving directory `/.share/usr/src/linux-2.5.7-pre2/drivers'
make: *** [_mod_drivers] Error 2
