Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWEAUCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWEAUCx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWEAUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:02:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57233 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932214AbWEAUCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:02:52 -0400
Date: Mon, 1 May 2006 22:02:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jiri Slaby <jirislaby@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc2-mm1 compiling problems
In-Reply-To: <44515CCF.7040100@gmail.com>
Message-ID: <Pine.LNX.4.64.0605012131240.32445@scrub.home>
References: <44515A27.1060703@gmail.com> <44515CCF.7040100@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Apr 2006, Jiri Slaby wrote:

> Jiri Slaby napsal(a):
> > Hello,
> > 
> > I have problems with compiling 2.6.17-rc2-mm1 and 2.6.17-rc1-mm3:
> > $ make O=../my V=1
> > make -C /l/latest/my \
> > KBUILD_SRC=/l/latest/xxx \
> > KBUILD_EXTMOD="" -f /l/latest/xxx/Makefile _all
> > make -f /l/latest/xxx/Makefile silentoldconfig
> > make -f /l/latest/xxx/scripts/Makefile.build obj=scripts/basic
> > if test ! /l/latest/xxx -ef /l/latest/my; then \
> > /bin/sh /l/latest/xxx/scripts/mkmakefile              \
> >     /l/latest/xxx /l/latest/my 2 6         \
> >     > /l/latest/my/Makefile;                                 \
> >     echo '  GEN    /l/latest/my/Makefile';                   \
> > fi
> >   GEN    /l/latest/my/Makefile
> > mkdir -p include/linux include/config
> > make -f /l/latest/xxx/scripts/Makefile.build obj=scripts/kconfig silentoldconfig
> > scripts/kconfig/conf -s arch/i386/Kconfig
> > init/Kconfig:3: unknown option "option"
> > make[3]: *** [silentoldconfig] Error 1
> > make[2]: *** [silentoldconfig] Error 2
> > make[1]: *** [include/config/auto.conf] Error 2
> > make: *** [_all] Error 2
> > 
> > Then, when I delete the line, there is another problem:

It's unlikely the problem, did anything special happen before (e.g. disk 
full or other errors)?
I cannot reproduce this, can you reproduce this with a clean 
source/object dir?

bye, Roman
