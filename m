Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbTDVUxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTDVUxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:53:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17543 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263877AbTDVUvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:51:03 -0400
Date: Tue, 22 Apr 2003 17:06:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig?
In-Reply-To: <3EA5AABF.4090303@techsource.com>
Message-ID: <Pine.LNX.4.53.0304221701320.17809@chaos>
References: <3EA5AABF.4090303@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Timothy Miller wrote:

> Is anyone else able to build 2.5.68 with allyesconfig?
>
> I'm using RH7.2, so the first thing I did was edit the main Makefile to
> replace gcc with "gcc3" (3.0.4).  Maybe the compiler is STILL my
> problem.  The problem doesn't stand out clearly to me, but I also
> haven't put much thought into it.  I'll try to use some more of my
> brain.  But if it's not going to be fixable by me, I humbly request help.
>
> Before the compile terminates, there are a number of the same warning
> for other files, being the same as the ones below for 'flags'.
>
> The compile dies thusly:
>
>   gcc3 -Wp,-MD,drivers/char/.riscom8.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=riscom8 -DKBUILD_MODNAME=riscom8 -c -o
> drivers/char/.tmp_riscom8.o drivers/char/riscom8.c
[SNIPPED...]

drivers/char/riscom8.c uses old methods including 'cli' and 'sti'.
It hasn't been fixed yet. Remove this from your configuration
and try again.

No code should use cli and sti. If any compile errors out on 2.5.n.n,
as a result of this, and you need the driver, you might try to inspect
the source and contact its maintainer. There are a lot of cleanups
on-going in this version.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

