Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbSK2B0P>; Thu, 28 Nov 2002 20:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266929AbSK2BZc>; Thu, 28 Nov 2002 20:25:32 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:5041 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266927AbSK2BYt>; Thu, 28 Nov 2002 20:24:49 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Rusty Lynch" <rusty@linux.co.intel.com>,
       "Wang, Stanley" <stanley.wang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work
References: <20021128234536.DC53A2C113@lists.samba.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 29 Nov 2002 10:31:30 +0900
In-Reply-To: <20021128234536.DC53A2C113@lists.samba.org>
Message-ID: <buohee16u19.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> > > int *ptr = symbol_get(their_integer);
> > > if (!ptr) ...
>
> That's because it's a new primitive.  Very few places really want to
> use it, they usually just want to use the symbol directly.  However,
> there are some places where such a dependency is too harsh: it's more
> "if I can get this, great, otherwise I'll do something else".

I find the name a bit wierd, BTW -- it sounds like it's going to return
the _value_ of the symbol.  How about something like `symbol_addr' instead?

-Miles
-- 
`To alcohol!  The cause of, and solution to,
 all of life's problems' --Homer J. Simpson
