Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263291AbUJ2Cc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUJ2Cc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbUJ2C36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:29:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29667 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263168AbUJ2AHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:07:25 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
References: <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>
	 <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>
	 <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	 <20041028063630.GD9781@elte.hu>
	 <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	 <20041028085656.GA21535@elte.hu>
	 <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	 <20041028093215.GA27694@elte.hu>
	 <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
	 <20041028191605.GA3877@elte.hu>
	 <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
Content-Type: text/plain
Date: Thu, 28 Oct 2004 20:07:23 -0400
Message-Id: <1099008443.4199.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 00:49 +0100, Rui Nuno Capela wrote:
> > plus i've also got questions about how Jackd interfaces with ALSA: does
> > it use SIGIO, or some direct driver ioctl? If SIGIO is used then how is
> > it done precisely - is an 'RT' queued signal used or ordinary SIGIO?
> > Also, how is the 'channel' information established upon getting a SIGIO,
> > is it in the siginfo structure?
> >
> 
> Now that's really pushing me over. Any ALSA-JACK developers around here to
> comment?
> 

I think it uses a direct driver ioctl to open the device.  Then jack
uses mmap to talk to the audio device. 

Anyway I forwarded your question to Paul Davis, the author of JACK, and
cc'ed jackit-devel.

Lee

