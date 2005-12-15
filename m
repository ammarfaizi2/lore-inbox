Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVLOTCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVLOTCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVLOTCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:02:49 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:61369 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750998AbVLOTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:02:47 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17313.48611.868544.724971@gargle.gargle.HOWL>
Date: Thu, 15 Dec 2005 22:02:59 +0300
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
References: <20051215135812.14578.qmail@science.horizon.com>
	<Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > 
 > On Thu, 15 Dec 2005, linux@horizon.com wrote:
 > > 
 > > A counting semaphore is NOT a perfectly fine mutex, and it SHOULD be changed.
 > 
 > Don't be silly.
 > 
 > First off, the data structure is called a "semaphore", and always has 
 > been. It's _never_ been called a "mutex" in the first place, and the 
 > operations have been called "down()" and "up()", because I thought calling 
 > them P() and V() was just too damn traditional and confusing (I don't 
 > speak dutch, and even if I did, I think shortening names to that degree is 
 > just evil).
 > 
 > And dammit, a counting semaphore (and usually you don't even say the 
 > "counting" part, since counting is really always there) is just about 
 > _the_ classical mutual exclusion mechanism. If somebody doesn't know that, 
 > he has absolutely _no_ place talking about mutexes etc.

Dijkstra (that cannot talk about this due to much more serious reasons)
didn't know this, because semaphores were initially used as a
wait/signal mechanism to provide concurrency control between "process
context" and "interrupts" however they were called at the time, and
calling this "just mutual exclusion" is stretching a bit far.

Mutex implies usage pattern much narrower than generic semaphore. 

 > 
 > And a semaphore _is_ a mutex. 

Nope, a mutex is a semaphore and not other way around. For one thing, a
notion of ownership is well-defined for the mutex, but it is not for a
semaphore. This is what they call "sub-type".

 >                              Anybody who disputes that is just being a 
 > total troll. 

Oh wait... what is that thing on the right of my screen? This
is... gnome task-list!

[...]

 > 
 > And I can't understand how somebody has the balls to even say that a 
 > semaphore isn't a mutex. That's like saying that an object of type "long" 
 > isn't an integer, because only "int" objects are integers. That's just 
 > INSANE.

And the person that claims that "long" is an "int" is non-portable. :-)

[...]

 > 
 > 			Linus

Nikita.
