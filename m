Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUHQTmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUHQTmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUHQTmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:42:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:30909 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266646AbUHQTlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:41:00 -0400
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
From: Albert Cahalan <albert@users.sf.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040817164046.GA19009@elf.ucw.cz>
References: <1092743463.5759.1403.camel@cube>
	 <20040817164046.GA19009@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1092762468.5759.1524.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Aug 2004 13:07:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 12:40, Pavel Machek wrote:
> Hi!
> 
> > > Coding style document is not consistent with
> > > itself on whether there should be space after
> > > ","... This makes it standartize on ", " option.
> > 
> > You can read it both ways, right? It's easy.
> > I can't even see the difference unless I'm
> > looking for it.
> 
> Well, you maybe can't tell the difference, but I definitely can. You
> can read code aligned by two spaces, right?

Sure, but you can't mix that in the same file
with something else. Indentation and braces have
to be consistent. Other stuff matters far less.

> > We don't need any more bureaucracy.
> > 
> > do_this(a,b); (1)
> > do_this(a, b); (2)
> > do_this (a,b);
> 
> This looks extremely bad.
> 
> > do_this (a, b);
> > 
> > I can read them all. I might notice the space in
> > front of the '(', but I might not. Even putting a
> > space in front of the ';' isn't unreadable.
> > 
> > People will pass laws until they are choked off,
> > unable to move without being in violation of some
> > silly little thing.
> 
> I've seen people "fixing" code from (2) to (1), because they thought I
> prefer (1). (And I definitely don't). So yes, it is important.

Spaces are good for grouping things to increase readability.
So one might do this:

foo(a,b,c,d,e,f);
bar(a+b, a-b);  // space needed for readability
baz(a,b, c,d);  // suppose a and b logically go together, as do c and d
zzz(a==b && c==d);   // common for an "if"

Slapping some arbitrary rule on top of this would
prohibit attempts to make things more readable.
Consider alignment between various lines when
calling similar functions:

foo(a, b+c,          *q, *p);
bar(a, b+c, another, *q, *p);
baz(a, b,   another, *q    );

Sometimes it helps to see things neatly lined up
like that. Sometimes not, of course. The author
needs freedom to lay things out nicely when it matters,
while not concerning himself with trivial spacing
differences when it doesn't matter.


