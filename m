Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSFUSKF>; Fri, 21 Jun 2002 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSFUSKE>; Fri, 21 Jun 2002 14:10:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316712AbSFUSKE>;
	Fri, 21 Jun 2002 14:10:04 -0400
Message-ID: <3D136BEF.3030509@mandrakesoft.com>
Date: Fri, 21 Jun 2002 14:09:51 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>, Cort Dougan <cort@fsmlabs.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <m1r8j1rwbp.fsf@frodo.biederman.org> <20020621105055.D13973@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> the first place.  It's proactive rather than reactive.  And the reason
> I harp on this is that I'm positive (and history supports me 100%)
> that the reactive approach doesn't work, you'll be stuck with it,
> there is no way to "fix" it other than starting over with a new kernel.
> Then we get to repeat this whole discussion in 15 years with one of the
> Linux veterans trying to explain to the NewOS guys that multi threading
> really isn't as cool as it sounds and they should try this other approach.


One point that is missed, I think, is that Linux secretly wants to be a 
microkernel.

Oh, I don't mean the strict definition of microkernel, we are continuing 
to push the dogma of "do it in userspace" or "do it in process context" 
(IOW userspace in the kernel).

Look at the kernel now -- the current kernel is not simply an 
event-driven, monolithic program [the tradition kernel design].  Linux 
also depends on a number of kernel threads to perform various 
asynchronous tasks.  We have had userspace agents managing bits of 
hardware for a while now, and that trend is only going to be reinforced 
with Al's initramfs.

IMO, the trend of the kernel is towards a collection of asynchronous 
tasks, which lends itself to high parallelism.  Hardware itself is 
trending towards playing friendly with other hardware in the system 
(examples: TCQ-driven bus release and interrupt coalescing), another 
element of parallelism.

I don't see the future of Linux as a twisted nightmare of spinlocks.

	Jeff



(I wonder if, shades of the old Linus/Tanenbaum flamewar, I will catch 
hell from Linus for mentioning the word "microkernel"  :))

