Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSDIPRg>; Tue, 9 Apr 2002 11:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSDIPRf>; Tue, 9 Apr 2002 11:17:35 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:49927 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S293092AbSDIPRe>;
	Tue, 9 Apr 2002 11:17:34 -0400
Date: Tue, 9 Apr 2002 11:17:32 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Corey Minyard <minyard@acm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Further WatchDog Updates
In-Reply-To: <3CB2EBC7.4010207@acm.org>
Message-ID: <Pine.LNX.4.33.0204091103070.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Apr 2002, Corey Minyard wrote:

> Why is that too fine grained?  You would just set the values from 1000
> to 255000 instead of 1 to 255, and round up.
>
> I have a board that sets the time value in wierd times (like 225ms,
> 450ms, 900ms, 1800ms, 3600ms, etc.).  I wouldn't be against the
> WDIOS_TIMEINMILLI option, but milliseconds should be good enough for anyone.

Yet Another Brainfart.  I've been having a lot of them recently.

I don't feel comfortable changing the API that much in a stable kernel
series.  Also, some other boards that have very small timeout windows
emulate a larger userspace timeout since it's quite possible that a
process won't get scheduled every 250ms.  I guess the only reason I can see
for such a small timeout window is if one needs 99.9999% uptime and the 29
extra seconds that the watchdog waits before kicking off is important.

Regards,
Rob Radez

