Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276933AbRJCJJB>; Wed, 3 Oct 2001 05:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276932AbRJCJIv>; Wed, 3 Oct 2001 05:08:51 -0400
Received: from csa.iisc.ernet.in ([144.16.67.8]:53772 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S276931AbRJCJIl>;
	Wed, 3 Oct 2001 05:08:41 -0400
Date: Wed, 3 Oct 2001 14:39:09 +0530 (IST)
From: "M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>
To: Jan Hudec <bulb@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event() :(
In-Reply-To: <20011003110629.A29671@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0110031437570.21820-100000@opal.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, Jan Hudec wrote:

> > I have a doubt regarding wait_event.
> > In the macro __wait_event, the calling process changes its state to
> > TASK_UNINTERRUPTIBLE and calls schedule.
> > And does this in infinite loop.
> > After the loop, it itself changes its state to TASK_RUNNING.
> > 
> > Once it calls schedule(), the scheduler will remove it from task list as
> > it is in uninterruptible mode.
> > Then when does it come again into running state to check the condition.
> > 
> > kindly cc the reply to me as i'm not subscribed to the list
> > thanks
> 
> It inserts itself in a wait queue. The schedule returns when wakeup is called
> on the wait queue.
> 
> --------------------------------------------------------------------------------
>                   				- Jan Hudec `Bulb' <bulb@ucw.cz>
> 

Then why does it have a for(;;) around it when anyway someone is going to
wake it up after the condition is true.
Or is that it may be woken up even when the condition is not true.
-- 
gopi.

