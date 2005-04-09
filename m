Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVDIRlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVDIRlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 13:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVDIRlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 13:41:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30128 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261359AbVDIRlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 13:41:03 -0400
Date: Sat, 9 Apr 2005 19:40:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Eric D. Mudama" <edmudama@gmail.com>
cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <311601c905040909525ef8242e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504091930250.15339@scrub.home>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> 
 <1112858331.6924.17.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org> 
 <Pine.LNX.4.61.0504072318010.15339@scrub.home> <311601c905040909525ef8242e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 9 Apr 2005, Eric D. Mudama wrote:

> > For example bk does something like this:
> > 
> >         A1 -> A2 -> A3 -> BM
> >           \-> B1 -> B2 --^
> > 
> > and instead of creating the merge changeset, one could merge them like
> > this:
> > 
> >         A1 -> A2 -> A3 -> B1 -> B2
> > 
> > This results in a simpler repository, which is more scalable and which
> > is easier for users to work with (e.g. binary bug search).
> > The disadvantage would be it will cause more minor conflicts, when changes
> > are pulled back into the original tree, but which should be easily
> > resolvable most of the time.
> 
> The kicker comes that B1 was developed based on A1, so any test
> results were based on B1 being a single changeset delta away from A1. 
> If the resulting 'BM' fails testing, and you've converted into the
> linear model above where B2 has failed, you lose the ability to
> isolate B1's changes and where they came from, to revalidate the
> developer's results.

What good does it do if you can revalidate the original B1? The important 
point is that the end result works and if it only fails in the merged 
version you have a big problem. The serialized version gives you the 
chance to test whether it fails in B1 or B2.

> I believe that flattening the change graph makes history reproduction
> impossible, or alternately, you are imposing on each developer to test
> the merge results at B1 + A1..3 before submission, but in doing so,
> the test time may require additional test periods etc and with
> sufficient velocity, might never close.

The merge result has to be tested either way, so I'm not exactly sure, 
what you're trying to say.

bye, Roman
