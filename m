Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTABKcZ>; Thu, 2 Jan 2003 05:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbTABKcZ>; Thu, 2 Jan 2003 05:32:25 -0500
Received: from dp.samba.org ([66.70.73.150]:745 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261292AbTABKcY>;
	Thu, 2 Jan 2003 05:32:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de,
       paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections 
In-reply-to: Your message of "Wed, 01 Jan 2003 21:15:36 -0800."
             <20030101.211536.121172392.davem@redhat.com> 
Date: Thu, 02 Jan 2003 21:35:54 +1100
Message-Id: <20030102104053.ABF0C2C0FD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030101.211536.121172392.davem@redhat.com> you write:
>    From: Richard Henderson <rth@twiddle.net>
>    Date: Wed, 1 Jan 2003 20:58:36 -0800
> 
>    On Wed, Jan 01, 2003 at 08:50:03PM -0800, David S. Miller wrote:
>    > I think this is to get .foo.init sections.
>    
>    Obviously.  Perhaps the question was worded badly.  Instead read
>    it as "Why don't we force this to be called .init.foo instead?"
> 
> This new naming order was created recently, but I forget the reason.
> It used to be .init.foo

No, it used to be .foo.init, but -ffunction-sections calls its
functions <funcname>.init, so it was changed to .init.foo.

Of course, the simpler prefix test should now be sufficient.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
