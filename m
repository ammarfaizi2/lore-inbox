Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHFQbj>; Tue, 6 Aug 2002 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSHFQbj>; Tue, 6 Aug 2002 12:31:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34833 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313113AbSHFQbi>; Tue, 6 Aug 2002 12:31:38 -0400
Date: Tue, 6 Aug 2002 09:35:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <vamsi_krishna@in.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.30 
In-Reply-To: <20020806073804.690DE4BA4@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208060932360.1885-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Aug 2002, Rusty Russell wrote:
> 
> > You mean _exception_ handlers. It's definitely not unnecessary. Exceptions 
> > can very much be preempted.
> 
> The patch changes traps 1 and 3 (debug & int3) to interrupt gates
> though.  

Yes, but then it enables interrupts at one point.

And I'm not saying that is wrong - I'm saying that the warning is really 
because you didn't tell the kernel that it was _not_ wrong. The warning is 
a "I got called with interrupts disabled, not nobody actually told me that 
I shouldn't reschedule. I will refuse to reschedule (exactly because 
interrupts weren't enabled), but I don't like the fact that somebody 
apparently did things behind my back".

Think of the kernel as a grumpy girlfriend that you just stood up, and 
bring flowers next time.

		Linus

