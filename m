Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272982AbRIRQu5>; Tue, 18 Sep 2001 12:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRIRQur>; Tue, 18 Sep 2001 12:50:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37388 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272982AbRIRQuh>; Tue, 18 Sep 2001 12:50:37 -0400
Date: Tue, 18 Sep 2001 09:49:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Howells <dhowells@redhat.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, <Ulrich.Weigand@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: <5552.1000822425@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0109180948260.2077-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Sep 2001, David Howells wrote:
>
> Okay preliminary as-yet-untested patch to cure coredumping of the need
> to hold the mm semaphore:
>
> 	- kernel/fork.c: function to partially copy an mm_struct and attach it
> 			 to the task_struct in place of the old.

Oh, please no.

If the choice is between a hack to do strange and incomprehensible things
for a special case, and just making the semaphores do the same thing
rw-spinlocks do and make the problem go away naturally, Ill take #2 any
day. The patches already exist, after all.

		Linus

