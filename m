Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276928AbRJCJGv>; Wed, 3 Oct 2001 05:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276931AbRJCJGg>; Wed, 3 Oct 2001 05:06:36 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28682 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S276928AbRJCJGR>; Wed, 3 Oct 2001 05:06:17 -0400
Date: Wed, 3 Oct 2001 11:06:29 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event() :(
Message-ID: <20011003110629.A29671@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"M.Gopi Krishna" <mgopi@csa.iisc.ernet.in>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110031351580.21283-100000@opal.csa.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110031351580.21283-100000@opal.csa.iisc.ernet.in>; from mgopi@csa.iisc.ernet.in on Wed, Oct 03, 2001 at 01:55:32PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a doubt regarding wait_event.
> In the macro __wait_event, the calling process changes its state to
> TASK_UNINTERRUPTIBLE and calls schedule.
> And does this in infinite loop.
> After the loop, it itself changes its state to TASK_RUNNING.
> 
> Once it calls schedule(), the scheduler will remove it from task list as
> it is in uninterruptible mode.
> Then when does it come again into running state to check the condition.
> 
> kindly cc the reply to me as i'm not subscribed to the list
> thanks

It inserts itself in a wait queue. The schedule returns when wakeup is called
on the wait queue.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
