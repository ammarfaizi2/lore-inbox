Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUJYTDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUJYTDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUJYS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:59:45 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:61293 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S261244AbUJYS6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:58:22 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
To: Ingo Molnar <mingo@elte.hu>
Cc: Alexander Batyrshin <abatyrshin@ru.mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF1ADC83B8.7696CB2F-ON86256F38.0066D6EA@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 25 Oct 2004 13:55:44 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/25/2004 01:55:46 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK. Am now trying with -V0.2, it works better but locks up in more
mysterious ways.... The modprobe messages are gone - thanks.

Was able (once) to get the X server up and started some of my tests
but the machine locked up (no mouse movement, no response to keyboard)
and had to use the hardware reset to recover. Only significant message
in the system log was

BUG: sleeping function called from invalid context hdparm(3606) at
kernel/mutex.c
in_atomic():0 [00000000], irqs_disabled():1
... will send stack traceback separately ...
when setting udma2 mode in hdparm.

Also noticed a "14 minute gap" in the log file, presumably when I was
running my real time test. I could not get control back until the first
test had run to completion (but heard the audio - so the machine was
working...). Machine locked up within the next 4 minutes.

The second try, the X server came up but the system froze when I tried
to login (according to the splash screen, was reloading my environment).
Messages in the log file were normal until the failure.

Third try, booting with selinux=0. Froze up again, this time the X
server did not make it all the way up. Last image is the blue background
with the hourglass cursor (frozen in center).

I will send what I can, please advise any further tests or data you
need for analysis.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

