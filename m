Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbSK1XiQ>; Thu, 28 Nov 2002 18:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSK1XiP>; Thu, 28 Nov 2002 18:38:15 -0500
Received: from dp.samba.org ([66.70.73.150]:19357 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266840AbSK1XiO>;
	Thu, 28 Nov 2002 18:38:14 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Wang, Stanley" <stanley.wang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work 
In-reply-to: Your message of "Wed, 27 Nov 2002 15:19:53 -0800."
             <007401c2966b$7e370fc0$94d40a0a@amr.corp.intel.com> 
Date: Fri, 29 Nov 2002 10:42:11 +1100
Message-Id: <20021128234536.DC53A2C113@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <007401c2966b$7e370fc0$94d40a0a@amr.corp.intel.com> you write:
> <snip>
> > /* In header somewhere. */
> > extern int their_integer;
> > 
> > ....
> > int *ptr = symbol_get(their_integer);
> > if (!ptr) ...
> > 
> 
> I couldn't find a single file in the kernel that uses this.  What
> would be the appropriate scenario for using this?  Is there
> code in the kernel that is suppose to migrating to this?

That's because it's a new primitive.  Very few places really want to
use it, they usually just want to use the symbol directly.  However,
there are some places where such a dependency is too harsh: it's more
"if I can get this, great, otherwise I'll do something else".

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
