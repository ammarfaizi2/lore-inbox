Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289889AbSBKRlQ>; Mon, 11 Feb 2002 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSBKRix>; Mon, 11 Feb 2002 12:38:53 -0500
Received: from edge.dls.net ([209.242.10.148]:52798 "EHLO anvil.dls.net")
	by vger.kernel.org with ESMTP id <S289865AbSBKRid>;
	Mon, 11 Feb 2002 12:38:33 -0500
Date: Mon, 11 Feb 2002 11:39:02 -0600
From: Arkadiy Chapkis - Arc <achapkis@mail.dls.net>
To: LINUX-KERNEL@vger.kernel.org
Message-ID: <00A09679.2A996F5D.164@mail.dls.net>
Subject: thread_info implementation
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    Can't compile kernel 2.5.4

[2.] Full description of the problem/report:   After configuring and starting
compilation, there are messages:

In file included from
/usr/local/src/test/linux-2.5.4/include/linux/spinlock.h:7,
                 from
/usr/local/src/test/linux-2.5.4/include/linux/module.h:11,
                 from loop.c:55:
/usr/local/src/test/linux-2.5.4/include/linux/thread_info.h:10:29:
asm/thread_info.h: No such file or directory

[4.] Kernel version (from /proc/version):   Current is 2.4.16, downloaded is
2.5.4

# cat /proc/version
Linux version 2.4.16 (root@yakov.dls.net) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-99))

[7.] Environment   AlphaStation 200 4/233

[7.2.] Processor information (from /proc/cpuinfo):

# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV4
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : Avanti
system variation        : 0
system revision         : 0
system serial number    : MILO-2.0.35-c5.
cycle frequency [Hz]    : 233313780
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 458.36
kernel unaligned acc    : 90143620 (pc=fffffc00004db7b0,va=fffffc000056830a)
user unaligned acc      : 90 (pc=1200bb3f0,va=12028b87a)
platform string         : N/A
cpus detected           : 0

[X.] Other notes, patches, fixes, workarounds:  Apperently the thread_info
implementation for sparc platform broke alpha platform as there is no
asm/thread_info.h file.

  Thanks you,



                                      Arc C.
                                      achapkis@dls.net
                                      achapkis@shark.dls.net
