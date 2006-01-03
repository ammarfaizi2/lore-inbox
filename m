Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWACMin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWACMin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWACMin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:38:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53948 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750991AbWACMim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:38:42 -0500
Date: Tue, 3 Jan 2006 13:38:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 16/19] mutex subsystem, semaphore to completion: SX8
Message-ID: <20060103123823.GA13178@elte.hu>
References: <20060103100924.GP23289@elte.hu> <43BA6C96.2060305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BA6C96.2060305@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Ingo Molnar wrote:
> >From: Steven Rostedt <rostedt@goodmis.org>
> >
> >change SX8 semaphores to completions.
> >
> >Signed-off-by: Ingo Molnar <mingo@elte.hu>

> >+#include <linux/completion.h>
> > #include <asm/io.h>
> > #include <asm/semaphore.h>
> 
> These patches should remove the asm/semaphore.h when appropriate too.  
> At a glance, this looks like one such case.

yeah, agreed. I did this in my tree. (the other sem2completion patches 
are not affected)

> Also, these aren't really part of a mutex subsystem patch series are 
> they?

i included them because they reduce the number of semaphores that are 
used in a non-mutex fashion, and thus make the mutex conversion easier. 
I.e. i consider both the sem2mutex and the sem2completion patches as 
part of the 'convert semaphores to mutexes' effort, even though 
sem2completions are independent technically. They can be applied 
independently of the mutex subsystem itself, of course.

	Ingo
