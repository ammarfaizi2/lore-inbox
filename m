Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSCIHOu>; Sat, 9 Mar 2002 02:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291340AbSCIHOj>; Sat, 9 Mar 2002 02:14:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292429AbSCIHO0>;
	Sat, 9 Mar 2002 02:14:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: frankeh@watson.ibm.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks 
In-Reply-To: Your message of "Fri, 08 Mar 2002 10:21:08 BST."
             <3C888284.8030206@loewe-komp.de> 
Date: Sat, 09 Mar 2002 15:50:37 +1100
Message-Id: <E16jYor-0003Ty-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C888284.8030206@loewe-komp.de> you write:
> Rusty Russell wrote:
> > To clarify: I'd love this, but rwlocks in the kernel aren't even
> > vaguely fair.  With a steady stream of overlapping readers, a writer
> > will never get the lock.
> > 
> > Hope that clarifies,
> 
> 
> But you talk about the current implementation, don't you?
> Is there something to prevent an implementation of rwlocks in the
> kernel, where a wrlock will lock (postponed) further rdlock requests?

It's proven hard to do without performance impact.  Also, we can't do
rw semaphores in a single word: you need two.

Disproving me by implementation VERY welcome!

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
