Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318975AbSHFDwl>; Mon, 5 Aug 2002 23:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318977AbSHFDwl>; Mon, 5 Aug 2002 23:52:41 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52135 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318975AbSHFDwk>;
	Mon, 5 Aug 2002 23:52:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30 
In-reply-to: Your message of "Mon, 05 Aug 2002 09:10:08 MST."
             <Pine.LNX.4.44.0208050906030.1753-100000@home.transmeta.com> 
Date: Tue, 06 Aug 2002 12:18:13 +1000
Message-Id: <20020806035803.23FC54B65@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208050906030.1753-100000@home.transmeta.com> you wri
te:
> 
> On Mon, 5 Aug 2002, Rusty Russell wrote:
> > 
> > In testing, I came up against the "spin_unlock() causes schedule()
> > inside interrupt" problem.
> 
> It shouldn't cause a schedule, it should cause a big warning (with 
> complete trace) to be printed out. Or did you mean something else?

Yes, that's what I meant.

> Maybe the warning should be changed to
> 
> 	Warning, kernel is mixing metaphors. "It's not rocket surgery".
> 
> to make it clear why it's a bad idea.

Oh yes, that's *much* clearer!

I am reading from this that we *should* be explicitly disabling
preemption in interrupt handlers if we rely on the cpu number not
changing underneath us, even if it's (a) currently unneccessary, and
(b) arch-specific code.

Yes?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
