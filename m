Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbULIOPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbULIOPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbULIOPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:15:35 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:59618 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S261361AbULIOP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:15:27 -0500
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
Message-ID: <OFBFDFFF38.8E8C4EA3-ON86256F65.004D59FB@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 9 Dec 2004 08:14:34 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/09/2004 08:14:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another odd crash, this time with PREEMPT_RT and 32-5.

Was trying to download 32-12 using mozilla and saw the following:
 - the download window came up with ?? of ?? downloaded
 - at this point, mozilla was not responsive, could move windows
with the window manager but no updates to the window contents.
 - top showed no CPU usage for mozilla-bin
Tried alt-sysrq-L (was then going to do -D) and got the following
messages on the serial console...

SysRq : (          IRQ 1-278  |#0): new 2304 us maximum-latency critical
section.
[stack dump shown]
(          IRQ 1-278  |#0): new 374313 us maximum-latency critical section.
[stack dump shown]
(          IRQ 1-278  |#0): new 374868 us maximum-latency critical section.
[stack dump shown]
(          IRQ 1-278  |#0): new 374923 us maximum-latency critical section.
[stack dump shown]

At this point, the system is non responsive. Network operations had
stopped, no mouse / display updates, no response to keyboard commands
like Alt-SysRq keys. Never saw the output of Alt-SysRq-L on the serial
console. The system log did not have anything either, its last message
was the one noting that I had logged in for the day.

Let me know if you need the serial console output.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

