Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVLBRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVLBRvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVLBRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:51:15 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:35752 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750840AbVLBRvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:51:14 -0500
Subject: Re: Use enum to declare errno values
From: Steven Rostedt <rostedt@goodmis.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, francis_moreau2000@yahoo.fr,
       Paul Jackson <pj@sgi.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <2cd57c900512020907h4be23519q@mail.gmail.com>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com> <4390730F.8000909@tmr.com>
	 <2cd57c900512020907h4be23519q@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 12:51:00 -0500
Message-Id: <1133545860.32583.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to regret jumping in on this.

On Sat, 2005-12-03 at 01:07 +0800, Coywolf Qi Hunt wrote:
> 2005/12/3, Bill Davidsen <davidsen@tmr.com>:
> > Coywolf Qi Hunt wrote:
> >
> > > This is a reason why enums are worse than #defines.
> > >
> > > Unlike in other languages, C enum is not much useful in practices.
> >
> > Actually they are highly useful if you know how to use them. They allow
> > type checking, have auto increment, and are part of the language instead
> >   of a feature of the preprocessor.
> 
> Yes, I know type checking and auto increment. But they are not
> worthwhile, at least not for serious C programming. No, I don't know
> how to use them comfortably.

Hmm, I like to use a lot of both enums and macros (defines).  I use
defines mostly for general constants and emums for enumerations.
Although it can be argued that errno should be enums, I would prefer
them as macros.  Especially since they then can be used in asm. (.S
files).

I seldom use enums for kernel programming though.  I use it just to
define a list of numbers where I don't care what their value is (usually
for transition states).  I use defines when I do.  Because errno does
depend on the value (for glibc to figure them out too) then I think
defines are better.

But in user space programming I use enums more often than defines,
because gdb can convert the number into a name.  So instead of seeing
x=0x1234 I see x=FOO.

-- Steve



