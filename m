Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTAQBs7>; Thu, 16 Jan 2003 20:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTAQBs7>; Thu, 16 Jan 2003 20:48:59 -0500
Received: from dp.samba.org ([66.70.73.150]:63651 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267353AbTAQBs6>;
	Thu, 16 Jan 2003 20:48:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling 
In-reply-to: Your message of "Tue, 14 Jan 2003 17:14:57 -0800."
             <20030114171457.E5751@twiddle.net> 
Date: Fri, 17 Jan 2003 12:57:03 +1100
Message-Id: <20030117015756.409DF2C437@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030114171457.E5751@twiddle.net> you write:
> On Tue, Jan 14, 2003 at 02:16:57PM +1100, Rusty Russell wrote:
> > So the semantics you want are that if A declares a weak symbol S, and
> > B exports a (presumably non-weak) symbol S, then A depends on B?
> 
> No.  The semantics I need is if A references a weak symbol S 
> and *no one* implements it, then S resolves to NULL.

Sorry, I was unclear.  I want to know the dependency semantics:

If B exports S, should depmod believe A needs B, or not?  Your patch
leaves that semantic (all it does is suppress the errors).

I'm not sure what semantics are "right", since I don't know what
you're trying to do, or what is wrong with get_symbol().

Hope that clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
