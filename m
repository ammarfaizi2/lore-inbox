Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268162AbTBNC6y>; Thu, 13 Feb 2003 21:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268160AbTBNC6y>; Thu, 13 Feb 2003 21:58:54 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:16842 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S268164AbTBNC6J>; Thu, 13 Feb 2003 21:58:09 -0500
Subject: Re: Synchronous signal delivery..
From: Keith Adamson <keith.adamson@attbi.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030214024046.GA18214@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> 
	<20030214024046.GA18214@bjl1.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 22:11:07 -0500
Message-Id: <1045192268.14703.20.camel@x1-6-00-d0-70-00-74-d1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trimmed cc list

> I see that there are several fairly general event sources now:
> 
> 	- signals
> 	- epoll events
> 	- async I/O events
> 	- posix timers
> 
> More events that don't provide enough information:
> 
> 	- dnotify details (siginfo doesn't say enough)
> 	- sigsegv read/write? (siginfo doesn't say enough)
> 
> More events that should be accessible but aren't:
> 
> 	- vm paging like crazy, please release some memory
> 
> Your synchronous signals code effectively makes signals work with
> select/poll/epoll nicely.  

How about also including a connect()/bind() interface so that 
you can sort of have a "sockets for signals" type interface.  
This seems like a nice type of interface for synchronization.
And maybe use send()/recv() instead of read()/write().  Or am 
I on crack:)


