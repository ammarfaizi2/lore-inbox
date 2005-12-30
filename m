Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVL3UXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVL3UXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVL3UXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:23:12 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:60658 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932261AbVL3UXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:23:10 -0500
Subject: Re: userspace breakage
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
In-Reply-To: <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
	 <43B453CA.9090005@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
	 <43B46078.1080805@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 15:22:56 -0500
Message-Id: <1135974176.6039.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 16:10 -0800, Linus Torvalds wrote:

> Stuff outside the kernel is almost always either (a) experimental stuff 
> that just isn't ready to be merged or (b) tries to avoid the GPL.

(c) So damn specialized that it's not worth even trying to merge.
That's my camp. I'm modifying the kernel so damn much, that I'm doing
special things for a special purpose, that is so intrusive that I'd be
laughed out of LKML if I tried to merge it.

But as for kernel API breakage... hmm, don't care very much.  Since
everything from the kernel to the apps running on this kernel is all
very customized, I pretty much make up my own API.

I _do_ care about kernel bugs that creep in.  Since I built my stuff on
top of Ingo's RT patch, my debugging goes like this.

1) is this a problem with my changes?
  if yes then fix it.
  if no, continue to number 2.

2) is this a bug in the rt patch?
  if yes, fix it and send patch to Ingo.
  if no, continue to number 3.

3) Must be bug with Linus kernel.
  fix it and send patch to LKML, and try to get it in.

I've had a couple of 3's and you've seen those from me.  So although you
may not be getting the added work I'm doing (you most likely don't even
want it), at least people like me do help out by doing number 3.

-- Steve


