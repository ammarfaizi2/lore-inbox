Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbSK2Dx6>; Thu, 28 Nov 2002 22:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbSK2Dx6>; Thu, 28 Nov 2002 22:53:58 -0500
Received: from dp.samba.org ([66.70.73.150]:47753 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266941AbSK2Dx5>;
	Thu, 28 Nov 2002 22:53:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miles Bader <miles@gnu.org>
Cc: "Rusty Lynch" <rusty@linux.co.intel.com>,
       "Wang, Stanley" <stanley.wang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work 
In-reply-to: Your message of "29 Nov 2002 10:31:30 +0900."
             <buohee16u19.fsf@mcspd15.ucom.lsi.nec.co.jp> 
Date: Fri, 29 Nov 2002 14:29:38 +1100
Message-Id: <20021129040120.6E2582C25E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <buohee16u19.fsf@mcspd15.ucom.lsi.nec.co.jp> you write:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> > > > int *ptr = symbol_get(their_integer);
> > > > if (!ptr) ...
> >
> > That's because it's a new primitive.  Very few places really want to
> > use it, they usually just want to use the symbol directly.  However,
> > there are some places where such a dependency is too harsh: it's more
> > "if I can get this, great, otherwise I'll do something else".
> 
> I find the name a bit wierd, BTW -- it sounds like it's going to return
> the _value_ of the symbol.  How about something like `symbol_addr' instead?

I agree, the names are a bit wierd (there were earlier get_symbol()
implementations I cribbed off), but the compiler should catch most
bugs (a void * variable being the exception).

And I already have a symbol_put_addr() separate from symbol_put(), so
I'd have to rethink the whole naming scheme, and it's a Friday 8)

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
