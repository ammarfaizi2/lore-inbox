Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261592AbRERWl4>; Fri, 18 May 2001 18:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbRERWlq>; Fri, 18 May 2001 18:41:46 -0400
Received: from [63.109.146.2] ([63.109.146.2]:3067 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S261592AbRERWlc>;
	Fri, 18 May 2001 18:41:32 -0400
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1BC5@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Unresolved symbol compiling a standalone module?
Date: Fri, 18 May 2001 15:41:20 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm compiling a standalone kernel module outside the kernel tree.  
The compile completes fine, but when I try to insmod it, I get:

unresolved symbol printk_R1b7d4074
unresolved symbol __const_udelay_Reae3dfd6

This is very strange, because a quick grep of some of the regular,
loaded modules, like /lib/modules/2.2.19/net/eepro100.o, shows that 
they contain those exact symbols!  So why are they "unresolved" in
mine?

CONFIG_MODVERSIONS = 1, kernel is 2.2.19 + reiserfs, and I have
checked my standalone module's makefile to ensure that it uses 
_exactly_ the same gcc options as the normal kernel modules.

My /usr/include/linux directory is a symbolic link to 
/usr/src/linux/include, and /usr/src/linux is the kernel I'm running.

What am I doing wrong?  

Torrey Hoffman
torrey.hoffman@myrio.com
