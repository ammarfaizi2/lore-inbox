Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132764AbRDQRBj>; Tue, 17 Apr 2001 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbRDQQ7c>; Tue, 17 Apr 2001 12:59:32 -0400
Received: from t2.redhat.com ([199.183.24.243]:35581 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132770AbRDQQ7Q>; Tue, 17 Apr 2001 12:59:16 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org, Peter Rival <frival@zk3.dec.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@cambridge.redhat.com>
Subject: Re: generic rwsem [Re: Alpha "process table hang"] 
In-Reply-To: Your message of "Tue, 17 Apr 2001 17:07:17 +0200."
             <20010417170717.H2696@athlon.random> 
Date: Tue, 17 Apr 2001 17:59:13 +0100
Message-ID: <10115.987526753@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

How did you generate the 00_rwsem-generic-1 patch? Against what did you diff?
You seem to have removed all the optimised i386 rwsem stuff... Did it not work
for you?

> (the generic rwsemaphores in those kernels is broken, try to use them in
> other archs or x86 and you will notice) and I cannot reproduce the hang any
> longer.

Can you supply a test case that demonstrates it not working?

> My generic rwsem should be also cleaner and faster than the generic ones in
> 2.4.4pre3 and they can be turned off completly so an architecture can really
> takeover with its own asm implementation.

I quick look says it shouldn't be faster (inline functions and all that).

However, I think you might be right about it being too dependent on the
algorithm I put in, and that is easy to change.

> (while with the 2.4.4pre3 design this is obviously not possible because
> lib/rwsem.c compilation isn't conditional and such file knows the internals
> of the struct rw_semaphore).

Could be very easily changed.

David
