Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268876AbTBZUGI>; Wed, 26 Feb 2003 15:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268737AbTBZUGI>; Wed, 26 Feb 2003 15:06:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19841 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268876AbTBZUGH>; Wed, 26 Feb 2003 15:06:07 -0500
Date: Wed, 26 Feb 2003 15:19:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: jt@hpl.hp.com, Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: Invalid compilation without -fno-strict-aliasing
In-Reply-To: <20030226194209.GA20861@nevyn.them.org>
Message-ID: <Pine.LNX.3.95.1030226151646.5261A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Daniel Jacobowitz wrote:
[SNIPPED...]

> > It was supposed to force x, which may be cached in a register,
> > to be written to memory __now__. It doesn't seem to do anything.
> > I think FORCE_TO_MEM() needs to claim that it uses most all the
> > registers. That will make sure that any register values get
> > written to their final memory locations.
> 
> If so it wouldn't be inside the #APP/#NOAPP markers.  You didn't answer
> my other question: was X in memory at the time?

It was in %ebx register and didn't go back to NNN(%esp) where
it came from. Like I said, it did do anything.

> 
> You should be using something like __asm__ __volatile__ (""::"m"(x))
> anyway.
> 

Yep. Probably.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


