Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUHQAt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUHQAt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUHQAt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:49:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22418 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268054AbUHQAtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:49:52 -0400
Subject: Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <41215334.7050203@mvista.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
	 <1092702077.2429.88.camel@cog.beaverton.ibm.com>
	 <41215334.7050203@mvista.com>
Content-Type: text/plain
Message-Id: <1092703747.2429.111.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Aug 2004 17:49:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 17:37, George Anzinger wrote:
> john stultz wrote:
> > On Mon, 2004-08-16 at 16:08, Tim Schmielau wrote:
> >>Simple fix: revert the patch below.
> >>Complicated fix: correct process start times in fork.c (no patch provided, 
> >>too complicated for me to do).
> > 
> > Hmm. While that patch fixed the uptime proc entry, I thought the issue
> > was with process start times. I'm looking at fixing the start_time
> > assignment in proc_pid_stat(). My suspicion is that we need to use ACTHZ
> > in jiffies64_to_clock_t().
> 
> I really don't see how the start_time that proc_pid_stat() is producing could be 
> anything but a constant.  The complaint is that it moves, not that it is 
> incorrect, right?

My impression was that it was both. 

Regardless, your point stands, it would just be a constant. Good catch.
I'll have to think about this some more. 

Let me look at procps to see how exactly it comes up w/ STIME. 

thanks
-john


