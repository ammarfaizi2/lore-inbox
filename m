Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbSJKO6j>; Fri, 11 Oct 2002 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSJKO6j>; Fri, 11 Oct 2002 10:58:39 -0400
Received: from d181.dhcp212-198-6.noos.fr ([212.198.6.181]:21252 "EHLO
	d133.dhcp212-198-6.noos.fr") by vger.kernel.org with ESMTP
	id <S262478AbSJKO6i>; Fri, 11 Oct 2002 10:58:38 -0400
Date: Fri, 11 Oct 2002 17:05:05 +0200
From: Thierry Mallard <thierry.mallard@vawis.net>
To: linux-kernel@vger.kernel.org
Subject: schedule_task still available in 2.5.41 ? (working on nvidia kernel module driver, but maybe not related)
Message-ID: <20021011150505.GA1684@d133.dhcp212-198-6.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While trying to work on the NVidia kernel module patch found on this
list for 2.5.40, a little changes later everything seems fine except the
following point :

-=-=-=-=-
[shaman@d133 NVIDIA_kernel-1.0-3123.shaman]$ make
echo \#define NV_COMPILER \"`cc -v 2>&1 | tail -1`\" > nv_compiler.h
cc -c -Wall -Wimplicit -Wreturn-type -Wswitch -Wformat -Wchar-subscripts
-Wparentheses -Wpointer-arith -Wcast-qual -Wno-multichar  -O -MD
-D__KERNEL__ -DMODULE -D_LOOSE_KERNEL_NAMES -DNTRM -D_GNU_SOURCE
-DRM_HEAPMGR -D_LOOSE_KERNEL_NAMES -D__KERNEL__ -DMODULE
-DNV_MAJOR_VERSION=1 -DNV_MINOR_VERSION=0 -DNV_PATCHLEVEL=3123
-DNV_UNIX   -DNV_LINUX   -DNVCPU_X86       -I.
-I/lib/modules/2.5.41/build/include -Wno-cast-qual nv.c
In file included from nv.c:14:
nv-linux.h:40:4: warning: #warning This driver does not _officially_
support 2.5.x development kernels!
nv.c: In function `nv_kern_isr':
nv.c:1679: warning: implicit declaration of function `schedule_task'
-=-=-=-

So I first though that an include file was missing, but I can't find a
.h in linux sources to would do :

[shaman@d133 linux-2.5.41]$ grep schedule_task -ril * 
( lots of .c files )
include/linux/module.h

It seems that module.h only talks about schedule_task as an example
(in comments lines).


I'm a little at lost, as it seems many drivers do use schedule_task. A
search on this list's archive doesn't get me anything interesting from
this point of view.

Any hints ?

With best regards,

-- 
Thierry Mallard
http://Vawis.net


