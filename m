Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUH0Q2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUH0Q2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUH0Q2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:28:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:51905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266523AbUH0Q0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:26:50 -0400
Date: Fri, 27 Aug 2004 09:26:13 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Summarizing the PWC driver questions/answers
Message-ID: <20040827162613.GB32244@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I've gotten a lot of emails about this topic, so I'll just answer
them all here in public, and point people at them when they ask them
again:

First off, here's Nemosoft's big post about the driver, please read that
first, and the responses to that thread:
http://thread.gmane.org/gmane.linux.usb.devel/26310

And here's Linus's response after I removed the driver, when Nemosoft
asked me to:
http://thread.gmane.org/gmane.linux.kernel/229968

Oh, and there's now a lwn.net thread too:
http://lwn.net/Articles/99615/

Ok, on to the questions:

Q: Why did you remove the hook from the pwc driver?
A: It was there for the explicit purpose to support a binary only
   module.  That goes against the kernel's documented procedures, so I
   had to take it out.

Q: That hook had been in there for years!  Why did you suddenly decide
   to remove it now?
A: I was really not aware of the hook, and the fact that it was only
   good for a binary module to use.  I'm sorry, I should have realized
   this years ago, but I didn't.  Recently someone pointed this hook out
   to me, and the fact that it really didn't belong in there due to the
   kernel's policy of such hooks.  So, once I became aware of it, I had
   no choice but to remove it.

Q: Why did you delete the whole pwc driver from the tree?
A: That is what the original author (Nemosoft) wanted to happen.  It was
   his request, and I honored it.  Go ask him why he wanted it out if
   you are upset about this, I merely accepted his decision as he was
   the current maintainer and author of the code.

Q: But you took away my freedom!  Isn't Linux about freedom?
A: Again, it was Nemosoft's decision.  The kernel also has to abide by
   it's documented procedures, so that is why the hook had to go.
   Remember, the original driver was released under the GPL, so you are
   free to take that code and maintain it if you so desire.  I'd gladly
   support someone taking the GPL code and agreeing to maintain it, and
   resubmitting it for inclusion in the main kernel tree.  That's the
   freedom that Linux provides, no closed source OS would allow you to
   do that, if a company pulled support for a product (which happens all
   the time.)

Q: You jerk, I had invested lots of money in this camera, you are
   costing me money by ripping it out.  You should be ashamed of
   yourself!
A: See the above question about freedom.  If it means that much to you,
   then offer to maintain the code, it's that simple.

Q: You are keeping companies from wanting to write binary drivers for
   Linux.
A: Duh!  What do you think all of the kernel developers have been
   stating for years, in public.  Binary drivers only take from Linux,
   they do not give back anything.  See Andrew Morton's OLS 2004 keynote
   address for more information and background on this topic.

Q: You are a fundamentalist turd / jerk / pompous ass /
   GNU-freebeer-biased-idiot-fundamentalist fucktard / ignorant slut!
A: I've been called worse by better people, get over yourself.

