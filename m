Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbVKCXXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbVKCXXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbVKCXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:23:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2777 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030525AbVKCXXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:23:53 -0500
Subject: Re: 2.6.14-rt1: oprofile doesn't work anymore
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1131053974.23154.9.camel@mindpipe>
References: <1131053974.23154.9.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 18:22:12 -0500
Message-Id: <1131060132.4770.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 16:39 -0500, Lee Revell wrote:
> I am using the simple "profile" script that Andrew Morton posted several
> months ago.  But no matter what I do, all I get is:
> 
> opreport error: No sample file found: try running opcontrol --dump
> or specify a session containing sample files
> 
> (Of course I have tried running opcontrol --dump, it has absolutely no
> effect)
> 
> Examining the log files I see that it does not collect any samples.

I just tested this with oprofile both built into the kernel and as a
module, and with oprofile userspace tools 0.9.1 and from CVS.  No
change.  I have verified that /dev/oprofile is mounted.  It looks like
the profiler never sees any samples.

rlrevell@mindpipe:~$ cat /dev/oprofile/stats/cpu0/sample_received 
0

Could one of the ktimers changes have broken the timer interrupt based
profiling?

Lee 

