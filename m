Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbULMOLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbULMOLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbULMOLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:11:35 -0500
Received: from tus-gate4.raytheon.com ([199.46.245.233]:2849 "EHLO
	tus-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S262269AbULMOLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:11:33 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFE91E87C4.B316CE31-ON86256F69.004D7BDC@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 13 Dec 2004 08:10:04 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 12/13/2004 08:10:13 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Disk access - at least on top of a filesystem - is not real-time. But we
>can say it is some other device.
I am not quite sure you should make such a general statement. There are
a number of "real time" processes that access disk drives. Things that
come to mind include:
 - paging for a visual display system (think a high end flight simulator)
 - streaming data acquisition
 - several multimedia applications (video / audio)
The application I mentioned (simulating a real world system that uses
a disk drive) certainly falls within the real time range as well.

You certainly have to manage the application carefully. But with
preallocated (prefer contiguous) files, you can do quite a lot with
a disk in a real time system. The rates may not be as high as needed
for some applications, but the overall concept is certainly valid.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

