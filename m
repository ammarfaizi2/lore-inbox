Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbTCKCWr>; Mon, 10 Mar 2003 21:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbTCKCWr>; Mon, 10 Mar 2003 21:22:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:12599 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262795AbTCKCWq>;
	Mon, 10 Mar 2003 21:22:46 -0500
Message-Id: <5.2.0.9.2.20030311033325.00c854c8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 11 Mar 2003 03:37:57 +0100
To: rwhron@earthlink.net, ingo@elte.hu
From: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation running irman with 2.5.64bk2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030311000923.GA1315@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:09 PM 3/10/2003 -0500, rwhron@earthlink.net wrote:
> > OK, can you do the following to determine whether we're both seeing the
> > _same_ problem?
>
> > 1.)  build the attached rtnice utility (don't remember who wrote/posted 
> this)
> > 2.)  login on vt1 and set the shell SCHED_RR via rtnice -n 1 -p <pid_of_sh>
> > -d RR
> > 3.)  login on vt2 and renice that shell to -10
> > 4.)  login on another vt as a normal user, and start irman
> > 5.)  try login/out on another vt, or ps or _whatever_ (doesn't matter)
> > until box is starving
> > 6.)  on vt2, try to do ps (it should hang despite -10 priority)
> > 7.)  on vt1, try to do ps (it should work just fine)
>
>Here is the test as I understand it, splitted by tty.  Quick summary,
>only new process seems starved.  RR and nice -10 process behave okay.
>
>BTW, this is now with 2.5.64bk5.

The only difference I see is that reniced task wasn't starved with this 
kernel... wonder what the difference is.  Thanks for running the test.

         -Mike 

