Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbTAKFAj>; Sat, 11 Jan 2003 00:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbTAKFAi>; Sat, 11 Jan 2003 00:00:38 -0500
Received: from dp.samba.org ([66.70.73.150]:5848 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267065AbTAKFAc>;
	Sat, 11 Jan 2003 00:00:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org
Subject: Re: Another idea for simplifying locking in kernel/module.c 
In-reply-to: Your message of "Fri, 10 Jan 2003 03:16:30 -0800."
             <200301101116.DAA03752@baldur.yggdrasil.com> 
Date: Sat, 11 Jan 2003 14:53:23 +1100
Message-Id: <20030111050918.C06212C2DE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301101116.DAA03752@baldur.yggdrasil.com> you write:
> I wrote:
> >On Thu, 09 Jan 2003, Max Krasnyansky wrote:
> >>We have to be able to call try_module_get() from interrupt context.
> 
> >	Where?  Why?  Please show me one or more examples.
> 
> 	Come to think of it, I don't think you even have to answer
> that question.  You should be able to use my try_module_get() from
> interrupt context.  It never blocks.

Yes, your try_module_get just gets spurious failures on SMP, as well
as thrashing the cacheline (why bother with one counter per CPU
then?).

I guess I just don't understand your solution?

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
