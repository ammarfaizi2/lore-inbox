Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbSLLHxY>; Thu, 12 Dec 2002 02:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbSLLHxY>; Thu, 12 Dec 2002 02:53:24 -0500
Received: from dp.samba.org ([66.70.73.150]:5042 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267433AbSLLHxW>;
	Thu, 12 Dec 2002 02:53:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Chua <jchua@fedex.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 ide module problem (fwd) 
In-reply-to: Your message of "Thu, 12 Dec 2002 14:22:02 +0800."
             <Pine.LNX.4.50.0212121419410.15261-100000@boston.corp.fedex.com> 
Date: Thu, 12 Dec 2002 18:54:35 +1100
Message-Id: <20021212080110.E663A2C564@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.50.0212121419410.15261-100000@boston.corp.fedex.com> you
 write:
> 
> Rusty,
> 
> Any chance that module-init-tools-0.9.3 can be modified to stop looping
> when it detected it has repeated scanning the same module again?

I didn't see this report before, so it's the first I've heard of it.

> > 	I think the new depmod recurses infinitely when it encounters
> > circular dependencies.  It eventually segfaults and leaves a huge
> > modules.dep file from the infinite loop.  If you look at the final
> > huge line in that file, you can see where the loop occurred.
> >
> > 	depmod has no need to do any recursion, since it only needs
> > to determine the immediate dependencies of each module.  However,
> > noticing such loops and printing them out would be a handy feature.

Actually, depmod should print out every dependency, so that modprobe
doesn't have to do the recursion check.

But yes, circular dependencies will screw it.

> >depmod will ecounter "Segmentation fault" if the ide.ko and ide-io.ps
> >modules are in /lib/modules/2.5.51/kernel

I'll test, and release a fix.

Thanks for the (indirect) bug report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
