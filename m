Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWARMuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWARMuI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWARMuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:50:08 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:63983 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932487AbWARMuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:50:06 -0500
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, david singleton <dsingleton@mvista.com>,
       Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0601181120100.1993-201000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0601181120100.1993-201000@lifa02.phys.au.dk>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 07:49:43 -0500
Message-Id: <1137588583.6762.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 11:31 +0100, Esben Nielsen wrote:
> Hi,
>  I have updated it:
> 
> 1) Now ALL_TASKS_PI is 0 again. Only RT tasks will be added to
> task->pi_waiters. Therefore we avoid taking the owner->pi_lock when the
> waiter isn't RT.
> 2) Merged into 2.6.15-rt6.
> 3) Updated the tester to test the hand over of BKL, which was mentioned
> as a potential issue by Bill Huey. Also added/adjusted the tests for the
> ALL_TASKS_PI==0 setup.
> (I really like unittesting: If someone points out an issue or finds a bug,
> make a test first demonstrating the problem. Then fixing the code is a lot
> easier - especially in this case where I run rt.c in userspace where I can
> easily use gdb.)

Hmm, maybe I'll actually get a chance to finally play with this. I've
discovered issues with the hrtimers earlier, and was too busy helping 
Thomas with them.  That had to take precedence.

;)

-- Steve


