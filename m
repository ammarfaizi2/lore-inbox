Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSLOB44>; Sat, 14 Dec 2002 20:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbSLOB44>; Sat, 14 Dec 2002 20:56:56 -0500
Received: from adsl-64-161-31-90.dsl.sntc01.pacbell.net ([64.161.31.90]:59307
	"EHLO doma.ballum") by vger.kernel.org with ESMTP
	id <S266128AbSLOB4z>; Sat, 14 Dec 2002 20:56:55 -0500
From: tho@doma.ballum.wikaba.com
Reply-To: gthomsen@sbcglobal.net
To: dri-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.{19,20} fails to resume if radeon.o is loaded
Date: Sat, 14 Dec 2002 18:04:06 -0800
Message-Id: <E18NO8U-0005j1-00@doma.ballum>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after about a dozen reboots and half a dozen fscks, I finally was
able to pinpoint the reason of why my laptop (ThinkPad X22 (2662XXK))
wasn't able to resume after suspend.

The DRM module 'radeon.o' somehow prevents a successful resume (but
not the suspend). Only after I made that module unavailable to the
modutils, my laptop now successfully completes suspend/resume cycles.

I noticed also that the radeon.o module sometimes refuses to
be removed claiming that some resources were still busy (while
I wasn't aware of using DRM).

Software:
vanilla Linux Kernel + FreeSWAN patch	2.4.19 as well as 2.4.20
Debian 3.0
	modutils	2.4.21
	binutils	2.12.90.0.1 20020307
	gcc		2.95.4

Hardware:
IBM ThinkPad X22 (2662XXK)
	ATI Radeon Mobility M6 LY

Please let me know, if I can help solving this issue by providing
more information or otherwise. I'm actually OK with how things
are right now (I don't use DRM), but this should be documented.
Maybe the kernel build system should prevent one from choosing
to build the radeon DRM as module, if CONFIG_APM is set?

Guenther
