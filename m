Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbULFQDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbULFQDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULFQC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:02:59 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:23925 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261547AbULFQAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:00:37 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
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
Message-ID: <OF17EC3728.49FC8C3C-ON86256F62.00576C16@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 6 Dec 2004 09:59:47 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/06/2004 09:59:48 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > on low RT load (the common case) the scheduler behaves like the
>> > stock scheduler - the new logic only kicks in if a CPU runqueue has
>> > 2 or more RT tasks running at once.
>
>'the common case' == ordinary (non-RT) Linux boxes! When i implement
>scheduler features i'm always trying to make them as generic as
>possible, i.e. this feature too is structured to be as upstream
>mergeable as possible. For that purpose the change had to be
>low-overhead in the common, non-RT case.
I truly appreciate that. However...

>It is easy to hack the
>scheduler to fix some RT issue but break the generic scheduler - this
>solution is not meant to be such a hack.
I agree but I see the big delay of running the RT task to be a symptom
that the current non RT scheduler is somehow broken. I've reported the
non RT starvation condition several times. Yes, the second CPU is busy,
but I really do want to bump cpu_burn (which is non RT & nice) to run my
(non RT and not nice) stress script / commands instead.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

