Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUJEXQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUJEXQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUJEXQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:16:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266357AbUJEXJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:09:47 -0400
Date: Tue, 5 Oct 2004 19:09:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jan Dittmer <jdittmer@ppp0.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.5-1.358 SMP
In-Reply-To: <416328AB.1060909@ppp0.net>
Message-ID: <Pine.LNX.4.53.0410051908400.1059@chaos.analogic.com>
References: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
 <416328AB.1060909@ppp0.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Jan Dittmer wrote:

> Richard B. Johnson wrote:
> > Hello,
> >
> > I almost have everything converted over from 2.4.26 to
> > 2.6.whatever.
> >
> > I need to make some modules that have lots of assembly code.
> > This assembly uses the UNIX calling convention and can't be
> > re-written (it would take many months). The new kernel
> > is compiled with "-mregparam=2". I can't find where that's
> > defined. I need to remove it because I cannot pass parameters
> > to the assembly stuff in registers.
> >
> > Where is it defined??? I grepped through all the scripts and
> > the hidden files, but I can't discover where it's defined.
>
> You don't mean CONFIG_REGPARM=n:
>
> arch/i386/Makefile:cflags-$(CONFIG_REGPARM)     += $(shell if [
> $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
>
> ?

Okay. Thanks. I wouldn't have guessed what to look for.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

