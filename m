Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSIZW5z>; Thu, 26 Sep 2002 18:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSIZW5z>; Thu, 26 Sep 2002 18:57:55 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:32783 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S261560AbSIZW5x>;
	Thu, 26 Sep 2002 18:57:53 -0400
Subject: Re: using memset in a module
From: Shaya Potter <spotter@cs.columbia.edu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0209261550410.32681-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0209261550410.32681-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1033081345.3371.35.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 26 Sep 2002 19:02:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 18:51, Randy.Dunlap wrote:
> On 26 Sep 2002, Shaya Potter wrote:
> 
> | I have a problem using memset in a module.
> |
> | I've tried including <linux/string.h> or <asm/string.h> but whenever I
> | compile with gcc 2.95, the resulting object has memset being an
> | undefined symbol.  When I compile with gcc-3.2 it works right as is
> | inline in the code and there's no symbol.
> |
> | has anyone seen this b4?  Is this a gcc bug? a kernel header bug? a bug
> | in my coding (i.e. does one have to do anything else besides include
> | <linux or asm/string.h> or have special gcc cmd line options that are
> | different from whats normally needed for a module).
> |
> | if it matters, I'm using the debian gcc's
> |
> | spotter@zaphod:~/cvs/zap/virtualization$ gcc -v
> | Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
> | gcc version 2.95.4 20011002 (Debian prerelease)
> |
> | and (cutting the cruft)
> | gcc version 3.2.1 20020924 (Debian prerelease)
> 
> What gcc options are you using?
> You need -O2 at least.
>           ^ upper-case letter O


yes, using it.

gcc -Wall -DMODULE -DMODVERSIONS -D__KERNEL__ -DLINUX -DEXPORT_SYMTAB
-I/usr/src/linux/include/ -I`pwd`/../migration
-I`pwd`/..//virtualization -O2 -fomit-frame-pointer -pipe
-fno-strength-reduce -malign-loops=2 -malign-jumps=2 -malign-functions=2
-o fs1.o -c virtualizers/fs1.c


