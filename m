Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTEWPvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTEWPvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 11:51:00 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:45545
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264088AbTEWPu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 11:50:58 -0400
Date: Fri, 23 May 2003 12:04:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [bug] only serial console -> build failure
Message-ID: <20030523160404.GB8575@gtf.org>
References: <20030523160239.GA8575@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523160239.GA8575@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 12:02:39PM -0400, Jeff Garzik wrote:
>   gcc -Wp,-MD,drivers/char/.vt.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=pentium4
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=vt -DKBUILD_MODNAME=vt -c -o
> drivers/char/vt.o drivers/char/vt.c
> drivers/char/vt.c: In function `vty_init':
> drivers/char/vt.c:2518: `console_driver' undeclared (first use in this
> function)
> drivers/char/vt.c:2518: (Each undeclared identifier is reported only
> once
> drivers/char/vt.c:2518: for each function it appears in.)
> make[2]: *** [drivers/char/vt.o] Error 1
> make[1]: *** [drivers/char] Error 2

Following up:

This only occurs when CONFIG_VT=y but not CONFIG_VT_CONSOLE=y.

	Jeff



