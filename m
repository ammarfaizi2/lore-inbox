Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTJQBRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTJQBRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:17:09 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:8205 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S263269AbTJQBRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:17:06 -0400
Message-ID: <3F8F4312.FDCECC3B@compuserve.com>
Date: Thu, 16 Oct 2003 21:17:06 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.0-test7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: machine hangs in 2.6 bk latest
References: <3F89C10A.D230DD33@compuserve.com> <3F8B4EC4.2584A2E9@compuserve.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius wrote:
> 
> Kevin Brosius wrote:
> >
> > I've noticed a pair of machine hangs today with latest 2.6.0 bk tree.
> > So far, I've been unable to retrieve information from the test machine,
> > as the network is down, console is unresponsive and in power save at the
> > time of the hang.  (I've haven't tried Magic-Sysrq yet.)
> >
> > After reboot, logs are truncated, so no useful information there either.
> >
> > System is base SuSE 8.2, running 2.6.0 bk, pulled today (Sun 16:00 EST
> > or earlier).
> >
> > Dual AMD MP CPUs, with reiserfs main fs on Mylex RAID disks.  2.6 bk
> > kernel from about a week ago was stable on this machine.  I'll try and
> > capture more info.  Any thoughts, please copy my email.
> 
> bk pulls from today behave the same.  The lockup seems to occur while
> using an ssh forwarded X connection and moving a large mozilla window on
> a remote machine.
> 
> The server machine is hard locked.  Alt-Sysrq does not respond at all.

It looks like 

ChangeSet 1.1237.1.117 2003/10/13 16:30:26 torvalds@home.osdl.org
  Revert recent SMP timer changes - they cause deadlocks

resolved this problem.  Thanks Linus! :)

-- 
Kevin
