Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263323AbUJ2ODt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbUJ2ODt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263329AbUJ2ODt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:03:49 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:27593 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263323AbUJ2ODs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:03:48 -0400
Message-Id: <200410291403.i9TE3jq3006445@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 15:55:30 +0200."
             <20041029135530.GA22463@elte.hu> 
Date: Fri, 29 Oct 2004 10:03:45 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 09:03:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {
>
>in Rui's test (9 fluidsynth instances running), what would be the value
>of nfds - 9 or 1? I.e. is the '9 streams' abstraction provided by jackd,
>and you map it to a single alsa driver fd over which you poll, or is
>each stream a separate fd?

for almost all audio interfaces, there is one fd per hardware
device. so whether its a 26 channel device or a simple stereo device,
there is one fd. jackd will be polling a single fd in that call under
almost all circumstances, and certainly those used in rui's testing.

--p
