Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbULOQX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbULOQX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbULOQX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:23:26 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:54221 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262378AbULOQXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:23:23 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20041215093246.GE13551@elte.hu>
References: <1103064432.14699.69.camel@krustophenia.net>
	 <200412142257.iBEMvYPj014838@localhost.localdomain>
	 <20041215093246.GE13551@elte.hu>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 11:23:21 -0500
Message-Id: <1103127802.18982.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 10:32 +0100, Ingo Molnar wrote:
> * Paul Davis <paul@linuxaudiosystems.com> wrote:
> 
> > the latter. to send MIDI Clock or MIDI Timecode requires an interrupt
> > source that is not locked to jiffie-ish intervals or power-of-2
> > related intervals. For example, MTC requires sending 2 bytes roughly
> > every 0.8msec. Sending them every msec isn't good enough, in general.
> 
> yeah, i can understand that - 20% slower music is bad, even to kernel
> hackers ;-)

It's a bit worse than that.  If there is excessive jitter in your MIDI
clock/MTC then your other devices will fail to lock on to it at all - it
does not degrade gracefully.

Lee

