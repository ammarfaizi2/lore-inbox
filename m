Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUHAAc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUHAAc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUHAAc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:32:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6325 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263818AbUHAAcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:32:25 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Lee Revell <rlrevell@joe-job.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Shane Shrybman <shrybman@aei.ca>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091319840.2386.3.camel@teapot.felipe-alfaro.com>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
	 <1091209106.2356.3.camel@mars>
	 <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
	 <1091232345.1677.20.camel@mindpipe>
	 <1091236384.2672.0.camel@teapot.felipe-alfaro.com>
	 <1091246222.1677.65.camel@mindpipe>
	 <1091319840.2386.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091320373.20819.74.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 20:32:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 20:24, Felipe Alfaro Solana wrote:
> On Fri, 2004-07-30 at 23:57 -0400, Lee Revell wrote:
> > On Fri, 2004-07-30 at 21:13, Felipe Alfaro Solana wrote:
> > > On Fri, 2004-07-30 at 20:05 -0400, Lee Revell wrote:
> > > > On Fri, 2004-07-30 at 19:21, Felipe Alfaro Solana wrote:
> > > > > On Fri, 2004-07-30 at 13:38 -0400, Shane Shrybman wrote:
> > > > > 
> > > > > > > M5 does that differently, yes - so could you try it? If you still get
> > > > > > > problems, does this fix it:
> > > > > > 
> > > > > > Ok, M5 locked up the whole machine within a few seconds of starting X.
> > > > > 
> > > > > Me too, with voluntary-preempt=3... It seems I can trigger this randomly
> > > > > by heavily moving the mouse around while logging in into my KDE session.
> > > > > 
> > > > > However, with voluntary-preempt=2 I've been unable to lock the machine
> > > > > yet.
> > > > 
> > > > It looks like this is a mouse problem, I have a PS/2 keyboard and USB
> > > > mouse and have not had any problems yet with M5.  I also found that with
> > > > L2, I could toggle Caps Lock fast enough to get significantly 'ahead' of
> > > > it, this no longer happens with M5.
> > > 
> > > I have a PS/2 keyboard and a USB mouse.
> > 
> > Weird.  This is my setup also, and I have had no problems since
> > installing M5.
> > 
> > Try:
> > 
> >         Option          "NoAccel"
> > 
> > in section "Device" of your XF86Config.  Also try commenting out:
> > 
> > 	Load		"dri"
> > 
> > in the "Module" section.
> > 
> > This will ensure that the X server is not accessing hardware directly. 
> > Normally this should not be a problem but a buggy video driver can cause
> > problems.  On my machine, having 2D acceleration enabled caused
> > interrupts from other devices to be lost when dragging a window.
> > 
> > Also, is the machine pingable after it locks up?
> 
> Curiously, the machine is pingable, but I can't ssh/telnet into it: no
> data is received from the locked machine.
> 

Hmm.  Maybe the problem is filesystem or disk related.  Is your root
partition on IDE or SCSI?  It could be a SCSI problem.

Are you running software or hardware RAID?

This is the same behavior you get when, for example, a disk dies.

Lee

