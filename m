Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbULIT3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbULIT3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbULIT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:29:33 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:1379 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S261593AbULIT3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:29:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
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
Message-ID: <OF005FDB8A.72F792AC-ON86256F65.0063E013@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 12:15:41 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 12:15:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
>
>> >also, i'd like to take a look at latency traces, if you have them for
>> >this run.
>>
>> I could if I had any. The _RT run had NO latency traces > 250 usec
>> (the limit I had set for the test). The equivalent _PK run had 37 of
>> those traces. I can rerun the test with a smaller limit to get some if
>> it is really important. My build of -12 is almost done and we can see
>> what kind of repeatability / results from the all_cpus trace shows.
>
>/me is puzzled.
>
>so all the CPU-loop delays within the -RT kernel are below 250 usecs? I
>guess i dont understand what this means then:

There were no cases where /proc/sys/kernel/preempt_max_latency went
over 250 usec in the RT stress test that I did (for the same test, _PK
had over 30 such traces).

>| The max CPU latencies in RT are worse than PK as well. The values for
>| RT range from 3.00 msec to 5.43 msec and on PK range from 1.45 msec to
>| 2.24 msec.
>
>these come from userspace timestamping? So where userspace detects a
>delay the kernel tracer doesnt measure any?
Yes. That is correct. Very puzzling to me too.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

