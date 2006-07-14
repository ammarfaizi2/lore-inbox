Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbWGNRA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWGNRA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWGNRA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:00:59 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29885 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161267AbWGNRA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:00:58 -0400
Subject: Re: [PATCH] remove volatile from nmi.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607140941170.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141131390.27161@turbotaz.ourhouse>
	 <Pine.LNX.4.64.0607140941170.5623@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 13:00:51 -0400
Message-Id: <1152896451.27135.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 09:47 -0700, Linus Torvalds wrote:

> 
> So I'd argue that it's actually _worse_ to do a "mindless" conversion away 
> from volatile, than it is to just remove them outright. Removing them 
> outright may show a bug that the volatile hid (and at that point, people 
> may see what the _deeper_ problem was), but at least it won't add a memory 
> barrier that isn't necessary and will potentially just confuse people.

Perfectly agree, and that is why in my post I said this was a learning
experience for me and to please review.  Thinking, at worst you guys
just tell me I'm completely wrong.  At best I find a real bug and have a
fix for it.  Seems I'm in between the two ;)

I believe I did find a real bug (just luck that it worked) but as you
say, my fix is wrong and if applied would hide the bug.  So this was to
bring attention to would be bugs, and in the mean time, I learn exactly
how to use memory barriers and how to get rid of volatiles.  Yes, this
was more of a blind change, and I should have looked more into exactly
what the code was doing.  But this was more to bring attention to a
problem area than really to solve it.

Thanks for responding and giving me a lesson :)

-- Steve


