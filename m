Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313570AbSDJTUy>; Wed, 10 Apr 2002 15:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313572AbSDJTUx>; Wed, 10 Apr 2002 15:20:53 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:3976 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313570AbSDJTUx>; Wed, 10 Apr 2002 15:20:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Skip Ford <skip.ford@verizon.net>
Subject: Re: 2.5.8-pre2: preempt: exits with preempt_count 1
Date: Wed, 10 Apr 2002 21:20:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net
In-Reply-To: <E16vHbV-0000M5-00@baldrick> <20020410183923.RMC1346.out012.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16vNdy-0000Jn-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 April 2002 8:40 pm, Skip Ford wrote:
> Duncan Sands wrote:
> > My system (x86 K6 UP running 2.5.8-pre2 with preemption) on powering down
> > gave:
> > ...
> > Power down.
> > error: halt[411] exited with preempt_count 1
> >
> > This was after about 24 hours of up time.  What can I do to help
> > track down this locking problem?
>
> If you fixed the oopsing 2.5.8-pre1 kernel by putting 'lock_kernel()'
> in exit.c, then you have to remove that line.
>
> The correct fix was applied later, and if you leave in the call
> to 'lock_kernel()' you get the exact message you're reporting.
>
> If line 505 of kernel/exit.c is lock_kernel() in your tree then delete
> it, and try again.

No, it wasn't that, but thanks for thinking about it.

Ciao, Duncan.
