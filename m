Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263437AbUJ2Rit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbUJ2Rit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbUJ2RRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:17:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40936 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263162AbUJ2RPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:15:21 -0400
Date: Fri, 29 Oct 2004 19:16:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029171608.GA14449@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain> <20041029111408.GA28259@elte.hu> <20041029161433.GA6717@elte.hu> <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu> <20041029163155.GA9005@elte.hu> <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu> <20041029170948.GA13727@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029170948.GA13727@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

>  5971  ioctl(7, 0x4143, 0x446b7d3c)      = 0
>  5971  ioctl(7, 0x4140, 0x446b7d3c)      = 0
>  5971  ioctl(7, 0x4142, 0x446b7d3c)      = 0
> 
> which ones are these? Look at the patch for how to change a .ioctl one
> to .ioctl_nobkl (lame solution ...). So if your setup uses any other
> ioctl (sndctl perhaps?) then you should change that one to nobkl too.

note that even if just one of these ioctls is still a BKL user then
-V0.5.12 will show no significant difference. So i've uploaded -V0.5.13
with some more converted. I think this should cover the above ones, but
i'm not 100% sure.

	Ingo
