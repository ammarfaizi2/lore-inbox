Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285388AbRLGDOo>; Thu, 6 Dec 2001 22:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285389AbRLGDOi>; Thu, 6 Dec 2001 22:14:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26303 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285388AbRLGDOW>; Thu, 6 Dec 2001 22:14:22 -0500
Date: Thu, 06 Dec 2001 19:17:39 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, riel@conectiva.com.br, lars.spam@nocrew.org,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <2643912454.1007666259@[10.10.1.2]>
In-Reply-To: <20011206184327.B4235@work.bitmover.com>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, where it wins big is on everything else.  Please explain to me how
> you are going to make a scheduler that works for 64 CPUS that doesn't suck?

Modifying the current scheduler to use multiple scheduler queues is not 
particularly hard.  It's been done already. See http://lse.sourceforge.net or 
Davide's work.

Please explain how you're going to load balance the scheduler queues across 
your system in a way that doesn't suck.

> And explain to me how that will perform as well as N different scheduler
> queues which I get for free.  Just as an example. 

I dispute that the work that you have to do up front to get ccClusters to work
is "free". It's free after you've done the work already. You may think it's 
*easier*, but that's different.

So we're going to do our work one step at a time in many small chunks, and
you're going to do it all at once in one big chunk (and not end up with as
cohesive a system out of the end of it) .... not necessarily a huge difference
in overall effort (though I know you think it is, the logic you're using to demonstrate
your point is fallacious).

Your objection to the "more traditional" way of scaling things (which seems
to be based around what you call the locking cliff) seems to be that it greatly
increases the complexity of the OS. I would say that splitting the system into
multiple kernels then trying to glue it all back together also greatly increases
the complexity of the OS. Oh, and the complexity of the applications that run 
on it too if they have to worry about seperate bits of the FS for each instance 
of the sub-OS.

Martin.

