Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSI0IVc>; Fri, 27 Sep 2002 04:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSI0IVc>; Fri, 27 Sep 2002 04:21:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28175 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261663AbSI0IVb>; Fri, 27 Sep 2002 04:21:31 -0400
Date: Fri, 27 Sep 2002 09:26:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Does kernel use system stdarg.h?
Message-ID: <20020927092647.A7485@flint.arm.linux.org.uk>
References: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209270804.g8R84cp08026@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Fri, Sep 27, 2002 at 10:58:52AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 10:58:52AM -0200, Denis Vlasenko wrote:
> make[3]: Entering directory `/usr/src/linux-2.5.36/kernel'
> gcc -E 
> -Wp,-MD,/usr/src/linux-2.5.36/include/linux/modules/kernel/.exec_domain.ver.d 
> -D__KERNEL__ -I/usr/src/linux-2.5.36/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=i486 -nostdinc -iwithprefix include 
>    -DKBUILD_BASENAME=exec_domain -D__GENKSYMS__  exec_domain.c | 
> /sbin/genksyms -p smp_ -k 2.5.36 > 
> /usr/src/linux-2.5.36/include/linux/modules/kernel/exec_domain.ver.tmp
> In file included from exec_domain.c:12:
> /usr/src/linux-2.5.36/include/linux/kernel.h:10:20: stdarg.h: No such file or 
> directory
> 
> There is no stdarg.h in kernel tree, should it be there?
> For now I just copied GCC one into linux/include...

It must be the GCC one.  If your GCC isn't finding it, then you've got a
broken GCC installation; "-iwithprefix include" tells GCC to look in its
private include directory for such things.

You could try adding -v to CFLAGS to see where it is searching for includes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

