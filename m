Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268534AbTANCrc>; Mon, 13 Jan 2003 21:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268533AbTANCqX>; Mon, 13 Jan 2003 21:46:23 -0500
Received: from dp.samba.org ([66.70.73.150]:32140 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268530AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       tridge@samba.org
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT. 
In-reply-to: Your message of "Mon, 13 Jan 2003 09:48:12 MDT."
             <Pine.LNX.4.44.0301130938500.24477-100000@chaos.physics.uiowa.edu> 
Date: Tue, 14 Jan 2003 11:21:44 +1100
Message-Id: <20030114025452.A68832C3EF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301130938500.24477-100000@chaos.physics.uiowa.edu> y
ou write:
> On Mon, 13 Jan 2003, Rusty Russell wrote:
> 
> > I've only updated the x86 linker script, since the other archs'
> > compile will break as soon as they set CONFIG_MODULES=y (there are 40
> > linker scripts in the tree, and I don't want to patch them all again).
> > 
> > You now get:
> > ext2: version magic 'non-SMP,preempt,gcc-2.95' != kernel 'SMP,preempt,gcc-2
..95'
> 
> I think it may, as kaos pointed out, also be necessary to allow for
> architecture specific config options, like the processor type.

That's in there.  Look closer at the patch 8)

> The implementation I have in mind would not generate the special section 
> with that string inside a header but rather add it during the "ld -o 
> module.ko" step (one of the reasons why I introduced that), in order to 
> avoid unnecessary recompiles when e.g. the version changes from "-preN" to 
> "-preN+1", which was a major concern people had with the old module 
> version string.
> 
> Do you agree on doing it that way?

The time-to-recompile when version changes argument doesn't really
concern me (but of course, it does concern you 8).  My natural
aversion to changing the build system makes me tend away.

But get any solution past Linus and I'll be happy 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
