Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSHFSyH>; Tue, 6 Aug 2002 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSHFSyH>; Tue, 6 Aug 2002 14:54:07 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:3588 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315457AbSHFSyG>; Tue, 6 Aug 2002 14:54:06 -0400
Date: Tue, 6 Aug 2002 20:57:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering 
In-Reply-To: <20020806073804.2E30F4BA3@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208062031040.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Aug 2002, Rusty Russell wrote:

> > - I use a separate initcall for the module initialization, that's the
> > only way I can solve my IDE problems.
>
> That's horrible 8(  I think we need figure out why this is happening:
> do you know?  What does it actually need?

I think pci initialization.

> I've updated my explicit core initcalls patch on top of your new one,
> thanks!
>
> 	http://www.kernel.org/pub/linux/kernel/people/rusty/Misc/ordered-core-initcalls.patch.2.5.30.gz

I'm not sure we should go this way. My main problem is that it only solves
a single ordering problem - boot time ordering. What about suspend/wakeup?
We have more of these ordering problems and driverfs is supposed to help
with them, so I'd rather first would like to see how much we can fix this
way.

bye, Roman

