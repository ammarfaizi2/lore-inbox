Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269155AbRHPXoi>; Thu, 16 Aug 2001 19:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRHPXo2>; Thu, 16 Aug 2001 19:44:28 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:24029 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269155AbRHPXoS>; Thu, 16 Aug 2001 19:44:18 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Aug 2001 09:44:26 -0700
Message-Id: <200108161644.JAA02547@adam.yggdrasil.com>
To: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: aic7xxx driver that does not need db library?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Currently, building Justin Gibbs's otherwise excellent
aic7xxx driver requires the Berkeley DB library, because the
aic7xxx assembler that is used in the build process uses db
basically just to implement associative arrays in memory.

	Unfortunately, I'm currently wrestling with db version
problems because gnome evolution requires the GPL'ed Sleepycat db 3.x,
so I want to keep db-1.85 around also, and this breaks the aicasm
build.  I am grateful to aicasm for exposing this problem in my
Sleepycat and Berkeley db configuration, but looking at the
aicasm sources makes me think that it would be easy enough to
make aicasm not to use db, and that would be worth eliminating
one more software dependency for building the Linux kernel.  It
also occurred to me that someone else may have already done this,
so I ought to ask.

	So, has anyone done this already?  If not, I guess I'll take a
whack at it.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
