Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312858AbSC1HJR>; Thu, 28 Mar 2002 02:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312076AbSC1HJI>; Thu, 28 Mar 2002 02:09:08 -0500
Received: from 68dyn61.com21.casema.net ([213.17.72.61]:54429 "HELO
	fruit.eu.org") by vger.kernel.org with SMTP id <S311960AbSC1HI5>;
	Thu, 28 Mar 2002 02:08:57 -0500
Date: Thu, 28 Mar 2002 08:08:55 +0100
From: Wessel Dankers <wsl@fruit.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler priorities
Message-ID: <20020328070855.GB514@fruit.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020327125828.U2343-100000@angelina.sl.pt> <1017236512.16546.116.camel@phantasy> <20020327202335.GA514@fruit.eu.org> <1017263732.17510.204.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-03-27 16:14:55-0500, Robert Love wrote:
> On Wed, 2002-03-27 at 15:23, Wessel Dankers wrote:
> 
> > Any plans for a SCHED_IDLE?
> 
> I think Ingo Molnar has mentioned lately doing one.
> 
> The problem is, it is not easy to implement right - there are priority
> inversion issues to deal with ...

Well evidently it should be root-only, just like SCHED_RR and SCHED_FIFO.
If the priority inversion issues are worked out this restriction could be
removed. I remember discussing this problem with Rik van Riel.
The kernel-preempt patch seems to be able to detect when a process holds a
lock; perhaps the process scheduler can temporarily revert to SCHED_NORMAL
when this is the case? Preferably with a large nice value.

--
Wessel Dankers <wsl@fruit.eu.org>

(the armchair engineer)
