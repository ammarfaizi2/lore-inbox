Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSBNBgL>; Wed, 13 Feb 2002 20:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289317AbSBNBf7>; Wed, 13 Feb 2002 20:35:59 -0500
Received: from bovendelft.xs4all.nl ([213.84.14.117]:18568 "HELO
	bovendelft.xs4all.nl") by vger.kernel.org with SMTP
	id <S289324AbSBNBfg>; Wed, 13 Feb 2002 20:35:36 -0500
Message-ID: <33319.192.168.200.20.1013650512.squirrel@bovendelft.xs4all.nl>
Date: Thu, 14 Feb 2002 02:35:12 +0100 (CET)
Subject: Re: linux-2.5.5-pre1
From: "-= M.J. Prinsen =-" <various@bovendelft.xs4all.nl>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16bAWz-0002Qx-00@starship.berlin>
In-Reply-To: <E16bAWz-0002Qx-00@starship.berlin>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <torvalds@transmeta.com>
Reply-To: various@bovendelft.xs4all.nl
X-Mailer: SquirrelMail (version 1.2.5 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling v2.5.5-pre1 I get the following error.
I want to compile this kernel and boot my computer from a raid-0 array
(Highpoint HPT370)
Idea's?

---------

gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-DKBUILD_BASENAME=ataraid  -DEXPORT_SYMTAB -c ataraid.c
ataraid.c: In function `ataraid_ioctl':
ataraid.c:73: invalid operands to binary &
ataraid.c:72: warning: `minor' might be used uninitialized in this function
ataraid.c: In function `ataraid_open':
ataraid.c:83: invalid operands to binary &
ataraid.c:82: warning: `minor' might be used uninitialized in this function
ataraid.c: In function `ataraid_release':
ataraid.c:94: invalid operands to binary &
ataraid.c:93: warning: `minor' might be used uninitialized in this function
ataraid.c: In function `ataraid_make_request':
ataraid.c:105: structure has no member named `b_rdev'
ataraid.c:103: warning: `minor' might be used uninitialized in this function
ataraid.c: In function `ataraid_split_request':
ataraid.c:182: structure has no member named `b_rsector'
ataraid.c:193: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
ataraid.c:193: too many arguments to function `generic_make_request'
ataraid.c:194: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
ataraid.c:194: too many arguments to function `generic_make_request'
ataraid.c: In function `ataraid_register_disk':
ataraid.c:233: incompatible type for argument 2 of `register_disk'
ataraid.c: In function `ataraid_init':
ataraid.c:249: `hardsect_size' undeclared (first use in this function)
ataraid.c:249: (Each undeclared identifier is reported only once
ataraid.c:249: for each function it appears in.)
ataraid.c:280: warning: passing arg 2 of `blk_queue_make_request' from
incompatible pointer type
ataraid.c: In function `ataraid_exit':
ataraid.c:289: `hardsect_size' undeclared (first use in this function)
make[3]: *** [ataraid.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
make: *** [_dir_drivers] Error 2

-------

     M.J. Prinsen
     http://bovendelft.xs4all.nl


