Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUJRPjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUJRPjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 11:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUJRPjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 11:39:42 -0400
Received: from lax-gate7.raytheon.com ([199.46.200.238]:64074 "EHLO
	lax-gate7.raytheon.com") by vger.kernel.org with ESMTP
	id S266721AbUJRPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 11:39:35 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Date: Mon, 18 Oct 2004 10:38:11 -0500
Message-ID: <OF7D12F73F.EA6A61CE-ON86256F31.0055E47B-86256F31.0055E4B1@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/18/2004 10:38:27 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i have released the -U4 PREEMPT_REALTIME patch:
>
>http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4

I still cannot get the network up and running with this. The BUG messages
are gone but the system stops processing init scripts somewhere in the
network related scripts. One time, it stopped in portmapper, the next it
got past that and stopped in the imapd script.

What I see on the screen is the normal boot, a few latency trace outputs
indicating increasing latency (up to about 2.3 msec) and then I make it to
single user mode. You can see those traces in /var/log/messages; I will
send that separately.

By doing the scripts in
  /etc/rc3.d/
by hand or by using
  telinit 3
I get normal displays until the system stops running the scripts. It just
stops at that point. No response to Ctrl-C (if done by hand). Alt-SysRq
keyboard commands do work (displayed on the screen) but the output does
not make it to /var/log/messages. The output from the second run is
particularly disappointing, it appears to be truncated.

I will rebuild with -U5 since I noticed it is available, but if you
have some suggestions on a way to capture more helpful data, I would
be glad to do it.

  --Mark

