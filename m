Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbSLRCUX>; Tue, 17 Dec 2002 21:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSLRCUX>; Tue, 17 Dec 2002 21:20:23 -0500
Received: from dp.samba.org ([66.70.73.150]:4747 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267107AbSLRCUW>;
	Tue, 17 Dec 2002 21:20:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: vamsi@in.ibm.com
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
In-reply-to: Your message of "Tue, 17 Dec 2002 11:48:46 +0530."
             <20021217114846.A30837@in.ibm.com> 
Date: Wed, 18 Dec 2002 11:23:35 +1100
Message-Id: <20021218022816.913AC2C238@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021217114846.A30837@in.ibm.com> you write:
> On Tue, Dec 17, 2002 at 11:17:05AM +1100, Rusty Russell wrote:
> > 
> > BTW, this was done for (1) simplicity, (2) so KBUILD_MODNAME can be
> > used to construct identifiers, and (3) so parameters when the module
> > is built-in have a consistent name.
> > 
> Ok, I see it now, this magic happens in scripts/Makefile.lib. 
> My module has been built outside the kernel build system, that's
> why I saw this problem.
> 
> I guess avoiding '-' should do it, but is there a simple way to 
> correctly build (simple, test) modules outside the kernel tree now?

Has there ever been a simple way?  You can either use _ in the name,
or use tr on the -DKBUILD_MODNAME line, I guess.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
