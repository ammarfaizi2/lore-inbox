Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276380AbRJGOYa>; Sun, 7 Oct 2001 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276381AbRJGOYU>; Sun, 7 Oct 2001 10:24:20 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:23967 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S276380AbRJGOYK>; Sun, 7 Oct 2001 10:24:10 -0400
Date: Sun, 7 Oct 2001 16:24:39 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011007162439.P748@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3BC05D2E.94F05935@welho.com>; from Mika.Liljeberg@welho.com on Sun, Oct 07, 2001 at 04:48:30PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 04:48:30PM +0300, Mika Liljeberg wrote:
> Ingo Oeser wrote:
> > The idle-task might be (ab-)used for this, because it has perfect
> > data for this.
> > 
> > T_SystemElapsed - T_IdleTaskRun = T_CPULoaded
> 
> The problem here is that the idle task doesn't get run at all if there
> are runnable tasks. 

There are idle tasks per CPU. If there are runnable tasks and the
idle-task of a CPU is running it, it is not fully loaded at this
time.

No idle task is running, if all CPUs are fully loaded AFAIR.

> One interesting property of the load balancer tasks would be that the
> less heavily loaded CPUs would tend to execute the load balancer more
> often, actively releaving the more heavily loaded CPUs, while those
> would concentrate more on getting the job done. Come to think of it, it
> could be coded in such a way that only the least loaded CPU would
> execute the load balancing algorithm, while the others would simply
> chalk up elapsed times.
 
So you suggest only one load balancer task jumping from CPU to
CPU. I misunderstood it. _Only_ chalking up could certainly done by
the idle tasks.

Regards

Ingo Oeser
