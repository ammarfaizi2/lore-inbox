Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRFWXdq>; Sat, 23 Jun 2001 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbRFWXdg>; Sat, 23 Jun 2001 19:33:36 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:46739 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263089AbRFWXdX>; Sat, 23 Jun 2001 19:33:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Fri, 22 Jun 2001 09:29:49 -0400
X-Mailer: KMail [version 1.2]
Cc: Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Message-Id: <0106220929490F.00692@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 June 2001 10:46, Mikulas Patocka wrote:

> I did some threaded programming on OS/2 and it was real pain. The main
> design flaw in OS/2 API is that thread can be blocked only on one
> condition. There is no way thread can wait for more events. For example 

Sure.  But you know what a race condition is, and how to spot one (in 
potential during coding, or during debugging.)  You know how to use 
semaphores and when and why, and when you DON'T need them.  You know about 
the potential for deadlocks.

And most of all, you know just because you got it to run once doesn't mean 
it's RIGHT...

> When OS/2 designers realised this API braindamage, they somewhere randomly
> added funtions to unblock threads waiting for variuos events - for example
> VioModeUndo or VioSavRedrawUndo - quite insane.

OS/2 had a whole raft of problems.  The fact half the system calls weren't 
available if you didn't boot the GUI was my personal favorite annoyance.

It was a system created _for_ users instead of _by_ users.  Think of the 
great successes in the computing world: C, Unix, the internet, the web.  All 
of them were developed by people who were just trying to use them, as the 
tools they used which they modified and extended in response to their needs.

This is why C is a better language than pascal, why the internet beat 
compuserve, and why Unix was better than OS/2.  Third parties writing code 
"for" somebody else (to sell, as a teaching tool, etc) either leave important 
stuff out or add in stuff people don't want (featuritis).  It's the nature of 
the beast: design may be clever in spurts but evolution never sleeps.  
(Anybody who doesn't believe that has never studied antibiotic resistant 
bacteria, or had to deal with cockroaches.)

> Programming with select, poll and kqueue on Unix is really much better
> than with threads on OS/2.

I still consider the difference between threads and processes with shared 
resources (memory, fds, etc) to be largely semantic.

> Mikulas

Rob
