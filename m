Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264904AbRF3KCb>; Sat, 30 Jun 2001 06:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264922AbRF3KCV>; Sat, 30 Jun 2001 06:02:21 -0400
Received: from vagabond.btnet.cz ([62.80.85.77]:10368 "EHLO vagabond.btnet.cz")
	by vger.kernel.org with ESMTP id <S264904AbRF3KCR>;
	Sat, 30 Jun 2001 06:02:17 -0400
Date: Sat, 30 Jun 2001 12:02:18 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: A signal fairy tale
Message-ID: <20010630120218.B898@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.0.20010629012354.02b759d0@imap.xman.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 01:26:29AM -0700, Christopher Smith wrote:
> At 10:59 AM 6/28/2001 -0400, Dan Maas wrote:
> >life-threatening things like SIGTERM, SIGKILL, and SIGSEGV. The mutation
> >into queued, information-carrying siginfo signals just shows how badly we
> >need a more robust event model... (what would truly kick butt is a unified
> >interface that could deliver everything from fd events to AIO completions to
> >semaphore/msgqueue events, etc, with explicit binding between event queues
> >and threads).
> 
> I guess this is my thinking: it's really not that much of a stretch to make 
> signals behave like GetMessage(). Indeed, sigopen() brings them 
> sufficiently close. By doing this, you DO provide this unified interface 
> for all the different types of events you described which works much like 
> GetMessage(). So, but adding a couple of syscalls you avoid having to 
> implement a whole new set of API's for doing AIO, semaphores, msgqueues, etc.

Wouldn't recv/recvfrom/recvmsg suffice? I think they could do the trick. More
covenience functions can than be derived in userland library. You still have
one type of events per descriptor, but you can combine with poll in userspace
library.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
