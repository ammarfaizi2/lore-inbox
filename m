Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSKNTHB>; Thu, 14 Nov 2002 14:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSKNTHA>; Thu, 14 Nov 2002 14:07:00 -0500
Received: from vir1.relay.fluke.com ([129.196.184.25]:23671 "EHLO
	vir1.relay.fluke.com") by vger.kernel.org with ESMTP
	id <S262363AbSKNTGk>; Thu, 14 Nov 2002 14:06:40 -0500
Date: Thu, 14 Nov 2002 11:13:35 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
X-X-Sender: <dcd@dd.tc.fluke.com>
To: Danny ter Haar <dth@ncc1701.cistron.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-rc1-ac2
In-Reply-To: <ar0jt6$fas$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.33.0211141111400.252-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Nov 2002 19:13:34.0363 (UTC) FILETIME=[ED50E6B0:01C28C11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Nov 2002 at 16:44 -0000, Danny ter Haar <dth@ncc1701.cistron.net...:

> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-rc1-ac2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rmap  -c -o rmap.o rmap.c
> In file included from rmap.c:31:
> /usr/src/linux-2.4.20-rc1-ac2/include/asm/smplock.h:17: warning: `kernel_locked' redefined
 ....
> make[3]: *** [rmap.o] Error 1

I turned off the include of smplock, and the file rmap.c compiles.

#if 0
#include <asm/smplock.h>
#endif

What was <asm/smplock.h> providing to rmap.c?

