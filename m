Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTIOSeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTIOSeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:34:22 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.23]:41982 "EHLO
	mwinf0803.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261260AbTIOSeS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:34:18 -0400
From: jjluza <jjluza@yahoo.fr>
To: Aran Cox <spin@avalon.net>, linux-kernel@vger.kernel.org
Subject: Re: Is there a patch to make nvnet work ?
Date: Mon, 15 Sep 2003 20:34:16 +0200
User-Agent: KMail/1.5.3
References: <200309151633.12801.jjluza@yahoo.fr> <1063649591.5897.22.camel@benway>
In-Reply-To: <1063649591.5897.22.camel@benway>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309152034.16564.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find what is wrong
in fact the link "build" in directory /lib/modules/2.6.0-test5-mm2/ pointed to 
"."
so it can't work well ...
I make it point to the right directoryn abd now, nvnet compil without problem


Does someone have the same problem with this link with kernel test5-mm2 ?
I used Debian way (make-kpkg kernel-image) to compile it with clean sources 
which I take from kernel.org



Le Lundi 15 Septembre 2003 20:13, vous avez écrit :
> The important thing is that you don't seem to have linux/modversions.h
> available.  This is included with every kernel so something is set up
> wrong.  There may be other errors but you need to this that one first.
>
> On Mon, 2003-09-15 at 09:33, jjluza wrote:
> > I know this driver is closed-source and not supported, but with older
> > kernel the 2.6-test5, it works with a patch which could be found here :
> > http://penna.dyn.dhs.org/nvnet.2.5-1.diff
> > It works until kernel 2.6-test4-mm4 for me
> > But there is many changes in structures with 2.6-test5
> > Today, I try to compile test5-mm2 : it compiles well
> > I started it and try to compile nvnet against it.
> > The boot process work without problem.
> > But when I try to compile it with the last patch, it complains about
> > structures.
> > So I would like to know if there is a new patch which works well with the
> > new kernel structures ?
> >
> > thx
> >
> >
> > PS : maybe I'm not very clear with my explanation, so here is the message
> > when I run "make" :
> > cc -c -Wall -DLINUX -DMODULE -DEXPORT_SYMTAB -D__KERNEL__ -O
> > -Wstrict-prototypes -DCONFIG_PM  -fno-strict-aliasing
> > -mpreferred-stack-boundary=2 -march=i686 -falign-functions=4
> > -DKBUILD_BASENAME=nvnet -DKBUILD_MODNAME=nvnet -fno-common -DMODULE
> > -I/lib/ modules/2.6.0-test4-mm4/build/include
> > -I/lib/modules/2.6.0-test4-mm4/build/ include/asm/mach-default   nvnet.c
> > In file included from nvnet.h:20,
> >                  from nvnet.c:21:
> > /usr/include/linux/module.h:21:34: linux/modversions.h: No such file or
> > directory
> > In file included from nvnet.c:21:
> > nvnet.h:107: error: syntax error before "nvnet_interrupt"
> > nvnet.h:107: warning: type defaults to `int' in declaration of
> > `nvnet_interrupt'
> > nvnet.h:107: warning: data definition has no type or storage class
> > nvnet.c: In function `nvnet_open':
> > nvnet.c:738: warning: passing arg 2 of `request_irq' from incompatible
> > pointer type
> > nvnet.c: At top level:
> > nvnet.c:759: error: syntax error before "nvnet_interrupt"
> > nvnet.c:760: warning: return type defaults to `int'
> > nvnet.c: In function `nvnet_interrupt':
> > nvnet.c:771: error: `IRQ_NONE' undeclared (first use in this function)
> > nvnet.c:771: error: (Each undeclared identifier is reported only once
> > nvnet.c:771: error: for each function it appears in.)
> > nvnet.c:782: error: `IRQ_HANDLED' undeclared (first use in this function)
> > nvnet.c: In function `nvnet_probe':
> > nvnet.c:1135: warning: implicit declaration of function `SET_NETDEV_DEV'
> > nvnet.c:1135: error: structure has no member named `dev'
> > make: *** [nvnet.o] Error 1
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

