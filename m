Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSE1PuK>; Tue, 28 May 2002 11:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316834AbSE1PuJ>; Tue, 28 May 2002 11:50:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63739 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316831AbSE1PuI>; Tue, 28 May 2002 11:50:08 -0400
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
From: Robert Love <rml@tech9.net>
To: dipankar@in.ibm.com
Cc: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20020528182806.A21303@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 08:49:58 -0700
Message-Id: <1022600998.20317.44.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 05:58, Dipankar Sarma wrote:

> > Thanks, I am convinced RCU is the way to go.

I am not. :P

> Well, the last time RCU was discussed, Linus said that he would
> like to see someplace where RCU clearly helps.

I agree the numbers posted are nice, but I remain skeptical like Linus. 
Sure, the locking overhead is nearly gone in the profiled function where
RCU is used.  But the overhead has just been _moved_ to wherever the RCU
work is now done.  Any benchmark needs to include the damage done there,
too.

I also balk at implicit locking...

	Robert Love

