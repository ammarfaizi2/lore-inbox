Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbUKVQu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUKVQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKVQsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:48:14 -0500
Received: from [199.46.245.231] ([199.46.245.231]:46974 "EHLO
	tus-gate2.ext.ray.com") by vger.kernel.org with ESMTP
	id S262139AbUKVQqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:46:31 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFCFE9D624.21CBF2C0-ON86256F54.005B438A@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 22 Nov 2004 10:44:01 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/22/2004 10:44:06 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just did a build with -V0.7.30-2 and was about to start testing when
>the system locked up (no keyboard response, display frozen, etc.). ...

Same symptom with a slightly different set of steps leading to the
problem.
 - boot / telinit 5 OK
 - su'd to get privileges
 - cat /proc/sys/kernel/preempt_wakeup_latency (showed 0)
 - echo 1 > /proc/sys/kernel/preempt_wakeup_latency
 - set RT priorities as before
 - started scripts to record data
 - system-config-soundcard (newline shown)
At this point, the system is locked up again with no response to any
inputs.

One thing I did notice from the previous test, I had two output files
from preempt_trace showing a couple minor (just over 50 usec each)
wakeup traces.

I have a few ideas to simplify the set up to see if I can get some
useful data out of the system.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

