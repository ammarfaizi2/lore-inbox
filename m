Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130518AbRCLSGZ>; Mon, 12 Mar 2001 13:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRCLSGP>; Mon, 12 Mar 2001 13:06:15 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:13062 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130518AbRCLSGC>;
	Mon, 12 Mar 2001 13:06:02 -0500
Date: Mon, 12 Mar 2001 19:05:27 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: george anzinger <george@mvista.com>, Rik van Riel <riel@conectiva.com.br>,
        Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010312190527.A23065@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva> <3AA93124.EC22CC8A@mvista.com> <3AA93ABE.7000707@humboldt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA93ABE.7000707@humboldt.co.uk>; from adrian@humboldt.co.uk on Fri, Mar 09, 2001 at 08:19:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:
> Unfortunately the kernel is already full of counting semaphores. 
> Priority inheritance won't save you, as the task which is going to call 
> up() need not be the same one that called down().
> 
> Jamie Lokier's suggestion of raising priority when in the kernel doesn't 
> help. You need to raise the priority of the task which is currently in 
> userspace and will call up() next time it enters the kernel. You don't 
> know which task that is.

Dear oh dear.  I was under the impression that kernel semaphores are
supposed to be used as mutexes only -- there are other mechanisms for
signalling between processes.

Do any processes ever enter userspace holding a critical semaphore?

(Things like userspace signalling another userspace don't count -- it's
your own fault and your own problem if _that_ deadlocks).

-- Jamie
