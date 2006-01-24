Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWAXVRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWAXVRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWAXVRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:17:39 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59831 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750730AbWAXVRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:17:38 -0500
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched
	(was: 2.6.15-rt12 bugs)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <6bffcb0e0601241300xd0b8d8dt@mail.gmail.com>
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
	 <1138065822.6695.6.camel@localhost.localdomain>
	 <6bffcb0e0601240533h3ba1a01ci@mail.gmail.com>
	 <1138112388.6695.26.camel@localhost.localdomain>
	 <6bffcb0e0601240737u3e77245g@mail.gmail.com>
	 <1138126262.6695.29.camel@localhost.localdomain>
	 <6bffcb0e0601241300xd0b8d8dt@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 16:17:30 -0500
Message-Id: <1138137450.6695.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 22:00 +0100, Michal Piotrowski wrote:
> On 24/01/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 2006-01-24 at 16:37 +0100, Michal Piotrowski wrote:
> [snip]
> > > It's very hard to track down, because earlier versions of -rt ware too
> > > buggy for me and most of them doesn't compile/boot.
> >
> > The 2.6.14-rtX series was pretty stable. How early did you go back?
> 
> To 2.6.15-rt1 - it doesn't compile (ipv6 module). 2.6.15-rt2 gives me
> wonderful series of oops/warnings/badness on boot ;).

Ingo was busy at the time getting true mutexes into the kernel.  So he
was pushing the -rt stuff out before testing.  So I created a tree to
handle this:

These are patches against Ingo's -rt patches, that should help make some
of your problems work.

http://home.stny.rr.com/rostedt/patches/archive/patch-2.6.15-rt1-sr2
http://home.stny.rr.com/rostedt/patches/archive/patch-2.6.15-rt2-sr3
http://home.stny.rr.com/rostedt/patches/archive/patch-2.6.15-rt3-sr1
http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt4-sr2

-- Steve


