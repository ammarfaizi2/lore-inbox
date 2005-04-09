Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVDIS4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVDIS4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDIS4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:56:12 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:47569 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261372AbVDIS4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:56:08 -0400
Subject: Re: Kernel SCM saga..
From: Ray Lee <ray-lk@madrabbit.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric D. Mudama" <edmudama@gmail.com>
In-Reply-To: <Pine.LNX.4.61.0504091930250.15339@scrub.home>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <1112858331.6924.17.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
	 <Pine.LNX.4.61.0504072318010.15339@scrub.home>
	 <311601c905040909525ef8242e@mail.gmail.com>
	 <Pine.LNX.4.61.0504091930250.15339@scrub.home>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Sat, 09 Apr 2005 11:56:06 -0700
Message-Id: <1113072966.27590.35.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-09 at 19:40 +0200, Roman Zippel wrote:
> On Sat, 9 Apr 2005, Eric D. Mudama wrote:
> > > For example bk does something like this:
> > > 
> > >         A1 -> A2 -> A3 -> BM
> > >           \-> B1 -> B2 --^
> > > 
> > > and instead of creating the merge changeset, one could merge them like
> > > this:
> > > 
> > >         A1 -> A2 -> A3 -> B1 -> B2

> > I believe that flattening the change graph makes history reproduction
> > impossible, or alternately, you are imposing on each developer to test
> > the merge results at B1 + A1..3 before submission, but in doing so,
> > the test time may require additional test periods etc and with
> > sufficient velocity, might never close.
> 
> The merge result has to be tested either way, so I'm not exactly sure, 
> what you're trying to say.

The kernel changes. A lot. And often.

With that in mind, if (for example) A2 and A3 are simple changes that
are quick to test and B1 is large, or complex, or requires hours (days,
weeks) of testing to validate, then a maintainer's decision can
legitimately be to rebase a tree (say, -mm) upon the B1 line of
development, and toss the A2 branch back to those developers with a
"Sorry it didn't work out, something here causes Unhappiness with B1,
can you track down the problem and try again?"

Ray

