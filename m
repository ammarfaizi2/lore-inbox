Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265388AbSJXKs3>; Thu, 24 Oct 2002 06:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265389AbSJXKs3>; Thu, 24 Oct 2002 06:48:29 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:54479 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265388AbSJXKs2>;
	Thu, 24 Oct 2002 06:48:28 -0400
Date: Thu, 24 Oct 2002 12:54:40 +0200
From: bert hubert <ahu@ds9a.nl>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: small patch, but Linux Kernel Conf in 2.5.44 works great
Message-ID: <20021024105440.GA28188@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, zippel@linux-m68k.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slight warning patch, but Linux Kernel Conf is really cool. From a users'
perspective, I note that the 'help' function is very fast now, which used to
be embarrassingly slow.

Make oldconfig also works as planned.

I would indeed however vote to make the xconfig program available separately
as well. Many users may need a different compiler for xconfig than for the
kerel (dreaded C++ ABI issues).

Right now, it is some hassle to make sure that the right compiler is used
for xconfig and the kernel.

Regards,

bert hubert

Tiny patch to fix a warning:

--- linux-2.5.44/scripts/kconfig/kconfig_load.c~	Thu Oct 24 12:31:24 2002
+++ linux-2.5.44/scripts/kconfig/kconfig_load.c	Thu Oct 24 12:39:34 2002
@@ -1,5 +1,6 @@
 #include <dlfcn.h>
 #include <stdio.h>
+#include <stdlib.h>
 
 #include "lkc.h"
 


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
