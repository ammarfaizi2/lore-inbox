Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSKGQOI>; Thu, 7 Nov 2002 11:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSKGQOI>; Thu, 7 Nov 2002 11:14:08 -0500
Received: from cerberus.bluetree.ie ([62.17.24.129]:36618 "EHLO
	cerberus.bluetree.ie") by vger.kernel.org with ESMTP
	id <S261407AbSKGQOH>; Thu, 7 Nov 2002 11:14:07 -0500
X-Virus-Checked: Checked on cerberus.bluetree.ie at Thu Nov 7 16:20:38 GMT 2002
From: "Kenn Humborg" <kenn@bluetree.ie>
To: "Petr Baudis" <pasky@ucw.cz>, "Peter Samuelson" <peter@cadcamlab.org>
Cc: "Roman Zippel" <zippel@linux-m68k.org>,
       "kbuild-devel" <kbuild-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [kbuild-devel] Re: [PATCH] [kbuild] Possibility to sanely link against off-directory .so
Date: Thu, 7 Nov 2002 16:20:34 -0000
Message-ID: <NBBBIGEGHIGMPCNKHCECMENDEAAA.kenn@bluetree.ie>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20021107152454.GH5219@pasky.ji.cz>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dear diary, on Thu, Nov 07, 2002 at 02:22:45PM CET, I got a letter,
> where Peter Samuelson <peter@cadcamlab.org> told me, that...
> > Remember, the whole point of HOSTCC is to support a build environment
> > different from the compile target - arbitrarily different, even.
> 
> I'm a bit lost here - the kernel uses tons of gcc extensions - 
> how is another
> compiler supposed to understand them? And if it is specifically 
> extended to
> understand them, isn't it likely that it'll understand the 
> -shared switch in
> gcc-like way as well?
> 
> Or better, what other compiler is known to build a kernel than 
> gcc? At least
> anything that doesn't define __GNUC__ should IMHO fail inside of 
> init/main.c.
> And how likely is situation when someone want to configure a kernel with
> non-gcc compiler and actually build it with gcc?

When you're cross-compiling a kernel.

> I thought that the point of HOSTCC is to allow to use a 
> non-standart version
> of gcc for kernel build.

Nope.  It's mainly for cross-compilation.  You want to compile the
kernel itself for your targer architecture, but the compilation tools
need to run on the build machine so need a different compiler.

The gcc/kgcc thing is only a convenient side effect.

Later,
Kenn

