Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVBNKai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVBNKai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVBNKah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:30:37 -0500
Received: from black.click.cz ([62.141.0.10]:45761 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261383AbVBNKaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:30:11 -0500
From: Michal Rokos <michal@rokos.info>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Date: Mon, 14 Feb 2005 11:29:50 +0100
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502141129.51037.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was unable to compile hotplug-ng against klibc until this patch went
in:

--- /dev/null   2005-02-14 09:23:10.000000000 +0100
+++ hotplug-ng/klibc/include/features.h 2005-02-11 16:18:35.000000000
+0100
@@ -0,0 +1,5 @@
+#ifndef        _FEATURES_H
+#define        _FEATURES_H     1
+
+#endif /* features.h  */
+

My system is debian (sid);
gcc version 3.3.5 (Debian 1:3.3.5-8)
libc6-2.3.2.ds1-20

The same goes for udev + klibc.

Or is there other trick?

Michal

PS: Error message was:
Precompiling hotplug.c:                                               [ERROR]
gcc -pipe -DLOG -Os -fomit-frame-pointer -D_GNU_SOURCE -Wall -nostdinc 
-mregpar
m=3 -DREGPARM=3 -march=i386 -Os -g -falign-functions=0 -falign-jumps=0 
-falign-
loops=0 -D__KLIBC__ -fno-builtin-printf 
-I/home/michal/WORK/devel/bk/hotplug-ng
/klibc_fixups 
-include /home/michal/WORK/devel/bk/hotplug-ng/klibc_fixups/klibc
_fixups.h -I/home/michal/WORK/devel/bk/hotplug-ng/klibc/include 
-I/home/michal/
WORK/devel/bk/hotplug-ng/klibc/include/arch/i386 
-I/home/michal/WORK/devel/bk/h
otplug-ng/klibc/include/bits32 -I/usr/lib/gcc-lib/i486-linux/3.3.5/include 
-I/l
ib/modules/2.6.11-rc4-mr/build/include 
-I/home/michal/WORK/devel/bk/hotplug-ng/
libsysfs/sysfs -I/home/michal/WORK/devel/bk/hotplug-ng/libsysfs -c -o 
hotplug.o
 hotplug.c
In file included 
from /lib/modules/2.6.11-rc4-mr/build/include/linux/posix_type
s.h:47,
                 from /home/michal/WORK/devel/bk/hotplug-ng/klibc/include/sys/t
ypes.h:15,
                 from /home/michal/WORK/devel/bk/hotplug-ng/klibc/include/unist
d.h:11,
                 from /home/michal/WORK/devel/bk/hotplug-ng/klibc_fixups/klibc_
fixups.h:7,
                 from <command line>:8:
/usr/lib/gcc-lib/i486-linux/3.3.5/include/asm/posix_types.h:13:22: features.h:
No such file or directory
make: *** [hotplug.o] Error 1
