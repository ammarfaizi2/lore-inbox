Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSGKUUy>; Thu, 11 Jul 2002 16:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSGKUUx>; Thu, 11 Jul 2002 16:20:53 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:31625
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S293203AbSGKUUw>; Thu, 11 Jul 2002 16:20:52 -0400
Date: Thu, 11 Jul 2002 13:23:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Riley Williams <rhw@infradead.org>
Cc: Justin Hibbits <jrh29@po.cwru.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: Patch for Menuconfig script
Message-ID: <20020711202323.GH695@opus.bloom.county>
References: <20020708181838.GL695@opus.bloom.county> <Pine.LNX.4.21.0207112100010.9595-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0207112100010.9595-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 09:06:50PM +0100, Riley Williams wrote:
> Hi Tom.
> 
> >>>>> This is just a patch to the Menuconfig script (can be easily adapted
> >>>>> to the other ones) that allows you to configure the kernel without
> >>>>> the requirement of bash (I tested it with ksh, in POSIX-only mode).  
> >>>>> Feel free to flame me :P
> >>>>
> >>>> Does it also work in the case where the current shell is csh or tcsh
> >>>> (for example)?
> >>>
> >>> Er.. why wouldn't it?
> >>> $ head -1 scripts/Menuconfig 
> >>> #! /bin/sh
> >>>
> >>> So this removes the /bin/sh is not bash test, yes?
> >>
> >>  Q> # ls -l /bin/sh | tr -s '\t' ' '
> >>  Q> lrwxrwxrwx 1 root root 4 May 7 1999 /bin/sh -> tcsh
> >>  Q> #
> >>
> >> You tell me - the above is from one of the systems I regularly use,
> >> which does not even have bash installed...
> > 
> > So does tcsh work as a POSIX-sh when invoked as /bin/sh ?
> 
> You tell me - what exactly defines "a POSIX-sh" ???

http://www.opengroup.org/onlinepubs/007904975/toc.htm

> Probably of more interest is this: Prior to your tweaks, the Menuconfig
> script just reported that one was trying to run it under the wrong
> shell. What happens when one tries to run your modified version under
> those conditions? There are only two valid answers:

Remember, Keith Owens pointed out that it's really a test of
CONFIG_SHELL, not /bin/sh.

>  1. It runs successfully.
> 
>  2. It reports that it can't run under that shell.
> 
> You're the one proposing the patch, so you're the one who needs to
> answer that question.

Well, my understanding of the patch is that it removes all of the
bash'ism and related from the script, so that any shell which will
accept things from the above URL will work.  So one of two things will
happen when /bin/sh != /bin/bash

1. The shell is complaint, and modulo bugs in the shell or script, it
will work.  This should be the common case.

2. The shell is not compliant, and the system is misconfigured.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
