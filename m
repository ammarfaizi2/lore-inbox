Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265207AbSJWV4U>; Wed, 23 Oct 2002 17:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265210AbSJWV4U>; Wed, 23 Oct 2002 17:56:20 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:45317 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S265207AbSJWV4T>; Wed, 23 Oct 2002 17:56:19 -0400
Date: Thu, 24 Oct 2002 00:06:13 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
cc: jt@hpl.hp.com, <linux-kernel@vger.kernel.org>,
       <irda-users@lists.sourceforge.net>
Subject: Re: 2.5.42: IrDA issues
In-Reply-To: <7886757.1035409088586.JavaMail.nobody@web155>
Message-ID: <Pine.LNX.4.44.0210232354010.1564-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, ALESSANDRO.SUARDI wrote:

> /usr/src/linux-2.5.44/include/linux/irq.h:67: `NR_IRQS' undeclared here (not in a function)
> In file included from /usr/src/linux-2.5.44/include/linux/irq.h:69,
>                  from /usr/src/linux-2.5.44/include/asm/hardirq.h:6,
>                  from /usr/src/linux-2.5.44/include/linux/interrupt.h:25,
>                  from /usr/src/linux-2.5.44/include/linux/netdevice.h:454,
>                  from smsc-ircc2.c:47:

I've no idea whether smcc-ircc2 is (already) meant to compile with 2.5.
However, when compiling stuff outside of an official 2.5.3x or later 
kernel tree I've experienced the same problem. For me the solution was to 
add the arch-specific asm-include explicitly in the Makefile - i.e. try 
adding some "-I/usr/src/linux/arch/i386/mach-generic" or similar there.

Martin

