Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbSK2CFf>; Thu, 28 Nov 2002 21:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266931AbSK2CFf>; Thu, 28 Nov 2002 21:05:35 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:7926 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266930AbSK2CFe>; Thu, 28 Nov 2002 21:05:34 -0500
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work
References: <20021128234536.DC53A2C113@lists.samba.org>
	<buohee16u19.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<6uel955e1u.fsf@zork.zork.net>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 29 Nov 2002 11:11:42 +0900
In-Reply-To: <6uel955e1u.fsf@zork.zork.net>
Message-ID: <buod6op6s69.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:
> > I find the name a bit wierd, BTW -- it sounds like it's going to return
> > the _value_ of the symbol.  How about something like `symbol_addr' instead?
> 
> Surely the value of a symbol is precisely that: an address.

Perhaps; but in my mind the concept of `symbol' (in C) is sort of fuzzy,
and conflated with the objects to which they refer.  If I see

   x = symbol_get(some_variable);

it _looks_, at first glance, like it's going to return the value of
some_variable (maybe this simply indicates that I'm a moron, but anyway).

This:

   x = symbol_addr(some_variable);

is a whole lot more obvious, I think, regardless of how clued in you are.

-Miles
-- 
Come now, if we were really planning to harm you, would we be waiting here, 
 beside the path, in the very darkest part of the forest?
