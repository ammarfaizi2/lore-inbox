Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289083AbSAOA3u>; Mon, 14 Jan 2002 19:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289322AbSAOA3k>; Mon, 14 Jan 2002 19:29:40 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:45582 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289083AbSAOA30>;
	Mon, 14 Jan 2002 19:29:26 -0500
Date: Mon, 14 Jan 2002 17:10:54 +1100
From: Anton Blanchard <anton@samba.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: cross-cpu balancing with the new scheduler
Message-ID: <20020114061054.GB17549@krispykreme>
In-Reply-To: <3C41BD74.28F6707A@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C41BD74.28F6707A@colorfullife.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> eatcpu is a simple cpu hog ("for(;;);"). Dual CPU i386.
> 
> $nice -19 ./eatcpu&;
>  <wait>
> $nice -19 ./eatcpu&;
>  <wait>
> $./eatcpu&.
> 
> IMHO it should be
> * both niced process run on one cpu.
> * the non-niced process runs with a 100% timeslice.
> 
> But it's the other way around:
> One niced process runs with 100%. The non-niced process with 50%, and
> the second niced process with 50%.

Rusty and I were talking about this recently. Would it make sense for
the load balancer to use a weighted queue length (sum up all priorities
in the queue?) instead of just balancing the queue length?

Anton
