Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269729AbUICSaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269729AbUICSaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269718AbUICS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:29:22 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:21939 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S269729AbUICS20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:28:26 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF6D4A65F.6B636459-ON86256F04.00651ACF@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Fri, 3 Sep 2004 13:28:03 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/03/2004 01:28:05 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>a quick suggestion: could you add this near the top of sched.c (below
>the #include lines):
>
> #define static
>
>this will turn off all inlining and makes the scheduler-internal
>functions visible. ....

I did this and built a broken kernel. I panics very early in start up.
I also got warnings like
kernel/sched.c: In function __might_sleep
kernel/sched.c:4974: warning: prev_jiffy might be used uninitialized in
this function
which if I read the code right should be a local static variable.

I suppose you meant
 #define inline
instead (which throws a warning about a duplicate definition; can I
ignore it?)

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

