Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278409AbRJMUsx>; Sat, 13 Oct 2001 16:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278408AbRJMUsn>; Sat, 13 Oct 2001 16:48:43 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:57608 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S278407AbRJMUsb>; Sat, 13 Oct 2001 16:48:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@sourceforge.net,
        Paul.McKenney@us.ibm.com
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion 
In-Reply-To: Your message of "13 Oct 2001 20:42:34 +0200."
             <k23d4njs9x.fsf@zero.aec.at> 
Date: Sun, 14 Oct 2001 06:44:23 +1000
Message-Id: <E15sVdv-0005rx-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <k23d4njs9x.fsf@zero.aec.at> you write:
> In article <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com>,
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> >  - nobody has shown a case where existing normal locking ends up being
> >    really a huge problem, and where RCU clearly helps.
> 
> The poster child of such a case is module unloading. Keeping reference
> counts for every even non sleeping use of a module is very painful. 

Well, module unloading requires only a small fraction of the read copy
update infrastructure (synchronize_kernel()), and can be implemented
without any scheduler changes, as it's not at all speed critical.

If nothing else, this thread has served to make more kernel hackers
aware of the technique, so they can try it themselves as desired.

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
