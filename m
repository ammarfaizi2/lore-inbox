Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRKFAxg>; Mon, 5 Nov 2001 19:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276468AbRKFAx0>; Mon, 5 Nov 2001 19:53:26 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:16565 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S276369AbRKFAxK>; Mon, 5 Nov 2001 19:53:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Tue, 6 Nov 2001 01:54:10 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111052246.fA5MkxG288247@saturn.cs.uml.edu>
In-Reply-To: <200111052246.fA5MkxG288247@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011106005304Z17249-18972+252@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 11:46 pm, Albert D. Cahalan wrote:
> Daniel Phillips writes:
> 
> > I've done quite a bit more kernel profiling and I've found that
> > overhead for converting numbers to ascii for transport to proc is
> > significant, and there are other overheads as well, such as the
> > sprintf and proc file open.  These must be matched by corresponding
> > overhead on the user space side, which I have not profiled.  I'll
> > take some time and present these numbers properly at some point.
> 
> You said "top -d .1" was 18%, with 11% user, and konsole at 9%.
> So that gives:
> 
> 9% konsole
> 7% kernel
> 2% top
> 0% X server ????

No, the konsole 9% is outside of top's 18%.

> If konsole is well-written, that 9% should drop greatly as konsole
> falls behind on a busy system. For example, when scrolling rapidly
> it might skip whole screenfuls of data. Hopefully those characters
> are rendered in a reasonably efficient way.

I don't think I'll try to optimize konsole/QT/X today, thanks ;-)

Lets just not lose sight of the overhead connected with ASCII proc IO, it's a 
lot more than some seem to think.

--
Daniel
