Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422927AbWAMU0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWAMU0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422928AbWAMU0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:26:42 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:18370 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422927AbWAMU0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:26:41 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Roger Heflin <rheflin@atipa.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <1137182991.8283.7.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 15:26:20 -0500
Message-Id: <1137183980.6731.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 15:09 -0500, Steven Rostedt wrote:

> Nope it doesn't work :-(
> 
> I ran this test:
>  http://www.kihontech.com/tests/rt/monotonic.c
> 
[...]
> 
> I'll reboot to vanilla 2.6.15 and see if that is broken too (just to
> make sure)
> 

Failed on 2.6.15 too:

$ ./monotonic
main program pid=6724
hello from thread 0!
hello from thread 4!
Failed! prev: 316.952599248   current: 316.951899248
hello from thread 3!
hello from thread 2!
hello from thread 1!

$ uname -r
2.6.15
$ cat /proc/cmdline
root=/dev/md0 ro console=tty0 nmi_watchdog=2 lapic clock=pmtmr

:-(

-- Steve


