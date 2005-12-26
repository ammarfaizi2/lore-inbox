Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVLZW1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVLZW1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVLZW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:27:50 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28576 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750804AbVLZW1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:27:32 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Date: Mon, 26 Dec 2005 22:49:35 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
References: <20051222114147.GA18878@elte.hu> <200512251708.16483.zippel@linux-m68k.org> <20051225225446.GA10877@elte.hu>
In-Reply-To: <20051225225446.GA10877@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512262249.46339.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 25 December 2005 23:54, Ingo Molnar wrote:

> > [...] I also haven't hardly seen any discussion about why semaphores
> > the way they are. Linus did suspect there is a wakeup bug in the
> > semaphore, but there was no conclusive followup to that.
>
> no conclusive follow-up because ... they are too complex for people to
> answer such questions off the cuff? Something so frequently used in
> trivial ways should have the complexity of that typical use, not the
> complexity of the theoretical use. There is no problem with semaphores,
> other than that they are not being used as semaphores all that often.

It shouldn't be that out of the blue for you. I don't mind the whole concept 
of mutexes and I agree that that's what most semaphores are used for. Please 
stop for a moment trying to sell mutexes, the basic question I'd like to get 
answered is, what is the worst-case scenerio if we convert everything to 
mutexes?
To make it very clear: I'm not arguing against mutexes, I only want a look at 
the complete picture, I don't only want to see the undoubted advantages, but 
also what are the risks? Is the semaphore wakeup behaviour really only a bug 
or does it fix some problem that just nobody remembers (and maybe even 
doesn't exist anymore)? What about the fairness issues mentioned, how easy is 
it to starve waiters?
Ingo, you're working on it already for a while, so I would expect you already 
thought about possible problems already, so why don't you take a look at the 
risks for us instead of just explaining the advantages? What are the chances 
we end up with semaphores just under a different name? Are there other 
possible problems, which then can be only solved e.g. by adding priority 
inheritance?
The point of this is to be prepared for any predictable problem, since this 
change in its consequence is rather huge and we don't have the luxury of a 
single development tree anymore, which is used by most developers.

bye, Roman

