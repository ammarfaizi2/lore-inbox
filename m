Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270632AbTHABLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 21:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270636AbTHABLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 21:11:38 -0400
Received: from mail.msi.umn.edu ([128.101.190.10]:5576 "EHLO mail.msi.umn.edu")
	by vger.kernel.org with ESMTP id S270632AbTHABLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 21:11:36 -0400
Date: Thu, 31 Jul 2003 20:11:36 -0500
From: Michael Bakos <bakhos@msi.umn.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
In-Reply-To: <20030731145954.47d6247f.akpm@osdl.org>
Message-ID: <Pine.SGI.4.33.0307312008210.23301-100000@ir12.msi.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the previous bad sent)
The patch (2.6.0-test2-mm2) did fix the asm/local.h missing file problem,
but I'm getting another one:

  CC arch/x86_64/kernel/asm-offsets.s
In file included from include/linux/topology.h:35,
                 from include/linux/mmzone.h:294,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:31,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/topology.h: In function `pcibus_to_cpumask':
include/asm/topology.h:24: error: invalid operands to binary &
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2

I'd also like to thanks thoses that replied to me for the previous
problem.

Michael Bakhos


On Thu, 31 Jul 2003, Andrew Morton wrote:

> Michael Bakos <bakhos@msi.umn.edu> wrote:
> >
> > Kernel version: 2.6.0-test2
> > CPU type: x86-64 (Opteron)
> > Problem: Can not successfuly do: make bzImage
> >
> > For process.c:
> > It says that the file asm/local.h is missing, and errors out in module.h
> > at line 175, parse error before local_t
>
> Try test-2-mm2: it has the x86_64 update.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm2/2.6.0-test2-mm2.bz2
>

