Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJUR3O>; Mon, 21 Oct 2002 13:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSJUR3O>; Mon, 21 Oct 2002 13:29:14 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:31188 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261573AbSJUR3N>;
	Mon, 21 Oct 2002 13:29:13 -0400
Date: Mon, 21 Oct 2002 10:35:13 -0700
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-irda@pasta.cs.uit.no, Martin Diehl <info@mdiehl.de>,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] remove 2.4 compatibility code from irda/vlsi_ir.h
Message-ID: <20021021173513.GB20616@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.NEB.4.44.0210201422530.28761-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0210201422530.28761-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 02:34:54PM +0200, Adrian Bunk wrote:
> 
> I got the following compile error in 2.5.44:
> 
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,drivers/net/irda/.vlsi_ir.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
> -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vlsi_ir   -c -o
> drivers/net/irda/vlsi_ir.o drivers/net/irda/vlsi_ir.c
> In file included from drivers/net/irda/vlsi_ir.c:53:
> include/net/irda/vlsi_ir.h:30: parse error
> make[3]: *** [drivers/net/irda/vlsi_ir.o] Error 1
> 
> <--  snip  -->
> 
> 
> vlsi_ir.h in 2.4 and 2.5 differ significantly, and I therefore suggest the
> following patch to remove the compatibility stuff that caused this problem
> (IMHO a better solution than an #include <linux/version.h>):

	Thanks for the report. I personally don't care too much for
this compatibility code, so the patch is OK to me. Martin ?

	Regards,

	Jean
