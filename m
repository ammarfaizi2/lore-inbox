Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbQKHUgZ>; Wed, 8 Nov 2000 15:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbQKHUgP>; Wed, 8 Nov 2000 15:36:15 -0500
Received: from winds.org ([209.115.81.9]:38669 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129679AbQKHUgJ>;
	Wed, 8 Nov 2000 15:36:09 -0500
Date: Wed, 8 Nov 2000 15:36:05 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: "J.D. Hollis" <jdhollis@cc.gatech.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: major problem with linux-2.4.0test10
In-Reply-To: <CBECJLMFDMBGLDALACILAEHJCEAA.jdhollis@cc.gatech.edu>
Message-ID: <Pine.LNX.4.21.0011081533320.13062-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, J.D. Hollis wrote:

> I've been having a problem with memory since 2.4.0test9...for some reason,
> shortly after my system boots, my hard drive begins to seek rapidly for no
> apparent reason, and suddenly about 150MB of my 256MB RAM is filled up with
> something gtop labels 'Other.'  whatever's filling my memory isn't attached
> to any process.   the one time I managed to get gtop open while the hard
> drive was seeking, I noticed that kflushd was using about 98% of my
> processor (an Athlon 900MHz).  I'm running Redhat 7.0 (although I have no
> idea whether that makes a difference).

It's probably a program called 'sa' that anacron starts up right after boot
(on RH 7.0). It's a system accounting program that starts up and scans the
entire drive looking for stuff, which fills up cache in RAM.

I generally disable all anacron stuff and remove /etc/cron.??* and the
daily/weekly/monthly entries in /etc/crontab, then I run 
'/etc/rc.d/init.d/crond restart'. That oughta fix it, but you might want to
look into the cron scripts individually and selectively remove the lines you
don't want. :-)

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
