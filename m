Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132968AbRDEUbC>; Thu, 5 Apr 2001 16:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132935AbRDEUax>; Thu, 5 Apr 2001 16:30:53 -0400
Received: from [209.250.53.51] ([209.250.53.51]:26122 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S132968AbRDEUan>; Thu, 5 Apr 2001 16:30:43 -0400
Date: Thu, 5 Apr 2001 15:28:59 -0500
From: Steven Walter <trwalter@apex.net>
To: "Sarda?ons, Eliel" <Eliel.Sardanons@philips.edu.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c questions
Message-ID: <20010405152859.A16443@hapablap.dyn.dhs.org>
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA028416D@MAINSERVER>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA028416D@MAINSERVER>; from Eliel.Sardanons@philips.edu.ar on Wed, Apr 04, 2001 at 04:52:32PM -0300
X-Uptime: 3:07pm  up 2 days, 18:24,  1 user,  load average: 2.19, 1.85, 1.38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 04:52:32PM -0300, Sarda?ons, Eliel wrote:
> switch (prev->state) {
>                 case TASK_INTERRUPTIBLE:
>                         if (signal_pending(prev)) {
>                                 prev->state = TASK_RUNNING;
>                                 break;
>                         }
>                 default:
>                         del_from_runqueue(prev);
>                 case TASK_RUNNING:
> }

I'm not sure about the other two, but this one is pretty straight
forward:  its listed explicitly because we don't want tasks with 
p->state TASK_RUNNING to fall into the default case, that is, getting
deleted from the runqueue.  This would be bad.

-- 
-Steven
Freedom is the freedom to say that two plus two equals four.
