Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314450AbSDWWhx>; Tue, 23 Apr 2002 18:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314454AbSDWWhw>; Tue, 23 Apr 2002 18:37:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36619 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314450AbSDWWhv>; Tue, 23 Apr 2002 18:37:51 -0400
Date: Tue, 23 Apr 2002 18:34:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
In-Reply-To: <Pine.LNX.3.95.1020419100917.724A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020423182543.31248C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002, Richard B. Johnson wrote:

> On Thu, 18 Apr 2002, Dr. Death wrote:
> 
> > Problem:
> > 
> > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> > damaged part of the file !
> > 
> 
> So what do you suggest? You can see from the logs that the device
> is having difficulty  reading your damaged CD. You can do what
> Windows-95 does (ignore the errors and pretend everything is fine),
> or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
> or you can try like hell to read the files like Linux does. What do you
> suggest?

Several things come to mind:
1 - don't dedicate the entire machine to retrying the error such that
    everything else runs slowly if at all.
2 - if the hardware returns an uncorrectable sector error that should be
    passed back to the user process rather than retried. An unconditional
    deep retry on an error the hardware labels as uncorrectable is not
    desirable, and not better than the Windows in most cases.

I took a bottle cap to one of the morning's AOL CDs and then tried to read
it. It's really not just annoying, it's pretty much useless. If you were
staging software off a CD on a running server, your clients would NOT be
happy!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

