Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154877-6881>; Tue, 5 Jan 1999 04:38:12 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:2616 "EHLO saturn.cs.uml.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155296-12152>; Mon, 4 Jan 1999 15:21:08 -0500
Date: Mon, 4 Jan 1999 17:35:52 -0500 (EST)
Message-Id: <199901042235.RAA11592@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Good MM benchmarks utilities?
Sender: owner-linux-kernel@vger.rutgers.edu


Steve Bergman writes:

> I've been doing some benchmarking of the 2.2pre kernels and various
> patches in development.  I am looking for memory management benchmark
> utilities.  Something like Bonnie for vm subsystem benchmarking.
> I'm concerned about the comprehensiveness of my own simple tests.
> What I'm finding is that while 2.2 is outperforming 2.0.36 in some
> situations, it is falling far behind in others.  Particularly the very
> low memory case (6M with X running) 2.0.36 performs far better (Even
> though the overall 'available memory' as reported by top is actually
> slightly *greater* for 2.2.  Andrea Arcangeli's recent patches have
> improved things a great deal but I still haven't found anything to
> beat 2.0.36 in very low memory.  It would help to have a suite that
> gives a more comprehensive view of mm performance.
> 
> Also, no matter how good the suite is, it will only tell me about the
> performance of my particular hardware layout.  The more people who
> test and submit results, the better 2.2/2.3 mm will be.  

If gcc could be IO-bound, you'd have a great benchmark.
You could get a 450 MHZ Xeon or 666 MHz Alpha with old IDE drives,
or slow down your IO in software to adjust for a normal CPU.

There might be a place in the block device code where you could add
a nice delay. You could get the NFS swap patches and use a PPP link
over a 14.4 modem. I suspect that would make gcc highly IO-bound.

If you had the kernel log user IO operations and page faults, you
could have a benchmark play back gcc IO behavior without all the
normal CPU usage.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
