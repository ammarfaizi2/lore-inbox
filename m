Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSBKAoH>; Sun, 10 Feb 2002 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSBKAn6>; Sun, 10 Feb 2002 19:43:58 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:38405 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S285666AbSBKAnh>; Sun, 10 Feb 2002 19:43:37 -0500
Subject: 2.5.4-pre5 -- Many comple errors in multipath.c
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 10 Feb 2002 16:40:25 -0800
Message-Id: <1013388025.30865.19.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID5 is not set
CONFIG_MD_MULTIPATH=m
CONFIG_BLK_DEV_LVM=m

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE 
-DKBUILD_BASENAME=multipath  -c -o multipath.o multipath.c
In file included from multipath.c:25:
/usr/src/linux/include/linux/raid/multipath.h:28: parse error before
`md_spinlock_t'
/usr/src/linux/include/linux/raid/multipath.h:28: warning: no semicolon
at end of struct or union
/usr/src/linux/include/linux/raid/multipath.h:39: parse error before
`wait_buffer'
/usr/src/linux/include/linux/raid/multipath.h:39: warning: type defaults
to `int' in declaration of `wait_buffer'
/usr/src/linux/include/linux/raid/multipath.h:39: warning: data
definition has no type or storage class
multipath.c:52: parse error before `retry_list_lock'
multipath.c:52: warning: type defaults to `int' in declaration of
`retry_list_lock'
multipath.c:52: `MD_SPIN_LOCK_UNLOCKED' undeclared here (not in a
function)
multipath.c:52: warning: data definition has no type or storage class
multipath.c: In function `multipath_alloc_mpbh':
multipath.c:64: warning: implicit declaration of function
`md_spin_lock_irq'
multipath.c:64: dereferencing pointer to incomplete type
...
multipath.c:73: warning: implicit declaration of function
`md_spin_unlock_irq'
multipath.c:73: dereferencing pointer to incomplete type
...
multipath.c: In function `multipath_free_mpbh':
multipath.c:97: dereferencing pointer to incomplete type
...
multipath.c: In function `multipath_grow_mpbh':
multipath.c:119: dereferencing pointer to incomplete type
multipath.c: In function `multipath_shrink_mpbh':
...
multipath.c: In function `multipath_map':
multipath.c:151: dereferencing pointer to incomplete type
...
multipath.c: In function `multipath_reschedule_retry':
multipath.c:167: warning: implicit declaration of function
`md_spin_lock_irqsave'
multipath.c:173: warning: implicit declaration of function
`md_spin_unlock_irqrestore'
multipath.c:174: dereferencing pointer to incomplete type
multipath.c:163: warning: `flags' might be used uninitialized in this
function
multipath.c: In function `multipath_read_balance':
multipath.c:235: dereferencing pointer to incomplete type
...
multipath.c: In function `multipath_make_request':
multipath.c:271: dereferencing pointer to incomplete type
multipath.c:275: structure has no member named `b_rsector'
multipath.c:278: structure has no member named `b_rdev'
multipath.c:282: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
multipath.c:282: too many arguments to function `generic_make_request'
multipath.c:248: warning: `multipath' might be used uninitialized in
this function
multipath.c: In function `multipath_status':
multipath.c:291: dereferencing pointer to incomplete type
...
multipath.c: In function `mark_disk_bad':
multipath.c:313: dereferencing pointer to incomplete type
...
multipath.c: In function `multipath_error':
multipath.c:336: dereferencing pointer to incomplete type
...
multipath.c: In function `print_multipath_conf':
multipath.c:409: dereferencing pointer to incomplete type
...
multipath.c:402: warning: `tmp' might be used uninitialized in this
function
multipath.c: In function `multipath_diskop':
multipath.c:434: dereferencing pointer to incomplete type
...
multipath.c:426: warning: `i' might be used uninitialized in this
function
multipath.c:428: warning: `tmp' might be used uninitialized in this
function
multipath.c:428: warning: `sdisk' might be used uninitialized in this
function
multipath.c:428: warning: `fdisk' might be used uninitialized in this
function
multipath.c:428: warning: `adisk' might be used uninitialized in this
function
multipath.c: In function `multipathd':
multipath.c:721: structure has no member named `b_rdev'
multipath.c:722: structure has no member named `b_rsector'
multipath.c:723: warning: passing arg 1 of `generic_make_request' makes
pointer from integer without a cast
multipath.c:723: too many arguments to function `generic_make_request'
multipath.c:692: warning: `flags' might be used uninitialized in this
function
multipath.c: In function `__check_consistency':
multipath.c:748: dereferencing pointer to incomplete type
multipath.c:751: dereferencing pointer to incomplete type
multipath.c: In function `multipath_run':
multipath.c:855: sizeof applied to an incomplete type
multipath.c:861: dereferencing pointer to incomplete type
...
multipath.c:863: warning: assignment from incompatible pointer type
multipath.c:863: dereferencing pointer to incomplete type
multipath.c:863: dereferencing pointer to incomplete type
multipath.c:863: warning: left-hand operand of comma expression has no
effect
multipath.c:884: dereferencing pointer to incomplete type
...
multipath.c:955: `MD_SPIN_LOCK_UNLOCKED' undeclared (first use in this
function)multipath.c:955: (Each undeclared identifier is reported only
once
multipath.c:955: for each function it appears in.)
multipath.c:957: dereferencing pointer to incomplete type
...
multipath.c:836: warning: `disk' might be used uninitialized in this
function
multipath.c:836: warning: `disk2' might be used uninitialized in this
function
multipath.c: In function `multipath_stop':
multipath.c:1044: dereferencing pointer to incomplete type
multipath.c: At top level:
multipath.c:1055: warning: initialization from incompatible pointer type
multipath.c:1063: parse error before `multipath_init'
multipath.c:1064: warning: return type defaults to `int'

