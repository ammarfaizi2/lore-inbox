Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUIPOz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUIPOz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268122AbUIPOzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:55:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31363 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268115AbUIPOzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:55:03 -0400
Date: Thu, 16 Sep 2004 10:54:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Having problem with mmap system call!!!
In-Reply-To: <1095341494.22744.26.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0409161050200.12305@chaos>
References: <4EE0CBA31942E547B99B3D4BFAB348111078FE@mail.esn.co.in> 
 <Pine.LNX.4.53.0409160958070.12146@chaos> <1095341494.22744.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Alan Cox wrote:

> On Iau, 2004-09-16 at 15:07, Richard B. Johnson wrote:
> >     if((vp = mmap((caddr_t) HINT, len, PROT, FLAGS, fd, addr)) == SHM_FAIL)
> >     {
> >         fprintf(stderr, "Can't access shared memory\n");
> >         exit(EXIT_FAILURE);
>
> SHM_FAIL is the wrong error check btw.
>

MAP_FAILED only appeared in real late 'C' runtime library headers.
That's why the code defines SHM_FAIL, which is also correct, but
doesn't cause a redefinition error.

> It is much better to do this in the driver than do nasty user mode hacks
> using /dev/mem. When you do it kernel driver side you end up with a
> cleaner mmap interface, a sensible permissions model and the hardware
> device pages mapped directly and nicely into the app
>

Well that's really nice. Now, how do you do that? The kernel DS
is not the user DS so you end up with a kernel hack instead of
a user hack?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

