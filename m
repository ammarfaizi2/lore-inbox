Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUHAAYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUHAAYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUHAAYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:24:25 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27908 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263626AbUHAAYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:24:16 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Shane Shrybman <shrybman@aei.ca>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091246222.1677.65.camel@mindpipe>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
	 <1091209106.2356.3.camel@mars>
	 <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
	 <1091232345.1677.20.camel@mindpipe>
	 <1091236384.2672.0.camel@teapot.felipe-alfaro.com>
	 <1091246222.1677.65.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 01 Aug 2004 02:24:00 +0200
Message-Id: <1091319840.2386.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 23:57 -0400, Lee Revell wrote:
> On Fri, 2004-07-30 at 21:13, Felipe Alfaro Solana wrote:
> > On Fri, 2004-07-30 at 20:05 -0400, Lee Revell wrote:
> > > On Fri, 2004-07-30 at 19:21, Felipe Alfaro Solana wrote:
> > > > On Fri, 2004-07-30 at 13:38 -0400, Shane Shrybman wrote:
> > > > 
> > > > > > M5 does that differently, yes - so could you try it? If you still get
> > > > > > problems, does this fix it:
> > > > > 
> > > > > Ok, M5 locked up the whole machine within a few seconds of starting X.
> > > > 
> > > > Me too, with voluntary-preempt=3... It seems I can trigger this randomly
> > > > by heavily moving the mouse around while logging in into my KDE session.
> > > > 
> > > > However, with voluntary-preempt=2 I've been unable to lock the machine
> > > > yet.
> > > 
> > > It looks like this is a mouse problem, I have a PS/2 keyboard and USB
> > > mouse and have not had any problems yet with M5.  I also found that with
> > > L2, I could toggle Caps Lock fast enough to get significantly 'ahead' of
> > > it, this no longer happens with M5.
> > 
> > I have a PS/2 keyboard and a USB mouse.
> 
> Weird.  This is my setup also, and I have had no problems since
> installing M5.
> 
> Try:
> 
>         Option          "NoAccel"
> 
> in section "Device" of your XF86Config.  Also try commenting out:
> 
> 	Load		"dri"
> 
> in the "Module" section.
> 
> This will ensure that the X server is not accessing hardware directly. 
> Normally this should not be a problem but a buggy video driver can cause
> problems.  On my machine, having 2D acceleration enabled caused
> interrupts from other devices to be lost when dragging a window.
> 
> Also, is the machine pingable after it locks up?

Curiously, the machine is pingable, but I can't ssh/telnet into it: no
data is received from the locked machine.

