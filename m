Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTJ2XYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJ2XYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:24:09 -0500
Received: from dp.samba.org ([66.70.73.150]:62919 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262051AbTJ2XX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:23:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] input hotplug support 
In-reply-to: Your message of "Tue, 28 Oct 2003 21:19:01 +0300."
             <200310282119.01702.arvidjaar@mail.ru> 
Date: Wed, 29 Oct 2003 11:15:27 +1100
Message-Id: <20031029232358.C9A6D2C002@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200310282119.01702.arvidjaar@mail.ru> you write:
> > Thanks, I've applied this patch.  Did your module-init-tools patch make
> > it into that package too?
> 
> No, Rusty was against it. You should have received those mails as well (you 
> were on Cc at least), subject was
> 
> "module-init-tools - input devices id support"

Let's go through this again.

1) I don't understand what you want.  eg. for USB devices, they're
   used to match the USB device to the USB driver for autoloading.

   You seemed surprised when I suggested you could autoload the input
   drivers: but what else would you want this information for?

2) While a naive approach to aliases would make aliases for input
   drivers about 1000 chars long, that's just a good reason not to use
   a naive approach.  I already suggested one approach based on the
   looking at the current drivers in the tree.

3) Since we're talking about 5 drivers in all, you could simply
   hardcode them if this is all too much trouble for you.

4) You *have* been informed that this is changing, months ago.  As
   soon as Greg tells me that hotplug scripts no longer need those
   tables, they will be removed in favour of the aliases which exist.

5) If you want some tables for other reasons, there's no reason for
   you not to generate them yourself.  Experience has shown that this
   method is fragile, but that's your choice.

6) You're confused about external modules: the module supplier runs
   file2alias as part of the build process, the user runs depmod as
   normal, so no problems.

> I really think that keeping module-init-tools in sync with kernel is not much
> more difficult than keeping file2alias in sync with kernel.

But they are *distributed separately*, so for the end user, it's much
harder to keep them in sync.  That's been one of the main aims of the
new module code: kernel independence.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
