Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSIWTi4>; Mon, 23 Sep 2002 15:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbSIWTi4>; Mon, 23 Sep 2002 15:38:56 -0400
Received: from pcp810151pcs.nrockv01.md.comcast.net ([68.49.85.67]:24450 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S261409AbSIWTiz>;
	Mon, 23 Sep 2002 15:38:55 -0400
Date: Mon, 23 Sep 2002 15:44:01 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       Larry McVoy <lm@bitmover.com>, Peter Waechtler <pwaechtler@mac.com>,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923154401.A2325@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@work.bitmover.com>,
	Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
	Peter Waechtler <pwaechtler@mac.com>,
	ingo Molnar <mingo@redhat.com>
References: <20020922143257.A8397@work.bitmover.com> <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com> <20020923083004.B14944@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020923083004.B14944@work.bitmover.com>; from lm@bitmover.com on Mon, Sep 23, 2002 at 08:30:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 08:30:04AM -0700, Larry McVoy wrote:
> What do you think causes a context switch in
> a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%
> of the time?  And doesn't that mean you already went into the kernel to
> see if the I/O was ready?  And doesn't that mean that in all the real
> world applications they are already doing all the work you are arguing
> to avoid?

I suspect a fair number of cases is preemption too, when you fire up
computation threads in the background.  Of course, the preemption
event always goes through the kernel at some point, even if it's only
a SIGALARM.

Actually, in normal programs (even java ones), _when_ is a thread
voluntarily giving up control?  Locks?

  OG.

