Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266744AbUKAQmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbUKAQmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270616AbUKAQmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:42:52 -0500
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:52421 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S266744AbUKAQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:38:46 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF45B54BA4.2C7A16BA-ON86256F3F.0059443C@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Mon, 1 Nov 2004 10:34:22 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/01/2004 10:35:40 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've uploaded -V0.6.5 to the usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/

I built with this patch and had some problems with the system
locking up.

First attempt:
 - booted to single user without problem
 - telinit 5 was OK as well
 - logged in. After first window popped up, I did
  su -
to get root access and the system locked up. No display updates
nor any mouse movement. Entering Alt-SysRq-L displayed
  SysRq : Show Regs On All CPUs
and no other messages appeared on the serial console. Attempts
to use other Alt-SysRq keys were ignored, hard reset to reboot.

Second attempt:
 - booted to single user without problem
 - telinit 5 failed after kudzu timed out (had "detected" a
change due to the serial console)

No messages on serial console after the kudzu timeout. This time
Alt-SysRq-L did work. Also did Alt-SysRq-T and -D and will send
the all the serial console messages separately.

Did notice an odd message during the dump of tasks...
Losing too many ticks!
TSC cannot be used as a timesource.
Possible reasons for this are:
  You're running with Speedstep.   [almost surely not]
  You don't have DMA enabled for your hard disk (see hdparm), [udma4 should
be set at this point]
  Incorrect TSC synchronization on an SMP system (see dmesg). [can't look
at that, system is hung]
Falling back to a sane timesource now.

Alas, this "sane timesource" didn't help either, system still
not responding right. Alt-SysRq-S said
  SysRq : Emergency Sync
[without any complete messages]
and Alt-SysRq-B did reboot the system.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

