Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbTJ1PxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTJ1PxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:53:08 -0500
Received: from [204.178.40.224] ([204.178.40.224]:39309 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264020AbTJ1PxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:53:04 -0500
Date: Tue, 28 Oct 2003 10:54:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Valdis.Kletnieks@vt.edu
cc: Boszormenyi Zoltan <zboszor@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup 
In-Reply-To: <200310281539.h9SFdixF024951@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0310281048130.21561@chaos>
References: <3F9E707B.7030609@freemail.hu>            <Pine.LNX.4.53.0310280936550.20004@chaos>
 <200310281539.h9SFdixF024951@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 Valdis.Kletnieks@vt.edu wrote:

> On Tue, 28 Oct 2003 09:39:53 EST, "Richard B. Johnson" said:
> > On Tue, 28 Oct 2003, Boszormenyi Zoltan wrote:
> > [SNIPPED...]
> >
> > > -rw-rw-r--    1 zozo     zozo      1090912 okt 27 22:54 interface.c
> >                                      ^^^^^^^
> > Guess you use `vim` to edit ...eh?
> >
> > Linux does have a good linker, you know. You don't need to put
> > everything in one file!
>
> On the flip side, if there's a lot of routines all declared 'static' so they are
> only visible to that .c file, it's less than simple to split them out and
> tell the *rest* of the projects that 'routines in interface/*.c are visible
> to each other, but not to C code in database/*.c'.
>
> The Linux kernel has the same issues:
>
> % find . -name '*.[ch]' | xargs grep acpi_bus_unregister_driver
>
> referenced only in drivers/acpi and one include file - but pollutes the global
> linkage namespace all the same.
>

I keep hearing 'pollutes the global namespace' all the time, now. Do
you mean that 'C' code designers actually intend to use the same
name for different procedures or objects in different files?

If so, that's a problem of idiocy, not pollution. Anybody who
writes code for a living would not do that, now would they??

The fact that there may be many global references that need to
be resolved by the linker is not pollution. It's using tools to
simplify design, implementation, testing, and maintenance.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


