Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbUJ2RTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUJ2RTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbUJ2RTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:19:16 -0400
Received: from pop.gmx.de ([213.165.64.20]:64475 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263382AbUJ2RPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:15:50 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 19:33:03 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
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
Message-ID: <20041029193303.7d3990b4@mango.fruits.de>
In-Reply-To: <20041029170948.GA13727@elte.hu>
References: <20041029090957.GA1460@elte.hu>
	<200410291101.i9TB1uhp002490@localhost.localdomain>
	<20041029111408.GA28259@elte.hu>
	<20041029161433.GA6717@elte.hu>
	<20041029183256.564897b2@mango.fruits.de>
	<20041029162316.GA7743@elte.hu>
	<20041029163155.GA9005@elte.hu>
	<20041029191652.1e480e2d@mango.fruits.de>
	<20041029170237.GA12374@elte.hu>
	<20041029170948.GA13727@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 19:09:48 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> ok, i've uploaded -V0.5.12 which has this BKL trick. I hope i got the
> ALSA ioctls right: the ones that go outside the BKL for now are the
> pcm_native playback/capture ones, and rawmidi's ioctl. All the others
> are still BKL users. To recap, it's these ioctls that matter:

doesn't build here:

  CC      fs/exec.o
  CC      fs/pipe.o
  CC      fs/namei.o
  CC      fs/fcntl.o
  CC      fs/ioctl.o
fs/ioctl.c: In function `sys_ioctl':
fs/ioctl.c:75: error: structure has no member named `ioctl_nobkl'
fs/ioctl.c:76: error: structure has no member named `ioctl_nobkl'
make[1]: *** [fs/ioctl.o] Error 1
make: *** [fs] Error 2

flo
