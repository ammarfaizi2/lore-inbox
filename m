Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVJDVVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVJDVVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVJDVVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:21:09 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:15213 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964983AbVJDVVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:21:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=flHbQA21SLKE1dPM/A+8p2L4G9qPglAMQKCxsatMKnB4jafdVTqg+eCVlizVdzbvUoxFNz+5f0fcGlrgjie7Qh8fwgy9ce48FdZPVcwYAmI1BpzrIv1JS+kebX42H/RyVRMtobgvE6YQVnpC4Mxj3B4zYapc7aZ1tZV5VCPNdNc=
Message-ID: <5bdc1c8b0510041421t766a72f0lafe00f0c9847a3dc@mail.gmail.com>
Date: Tue, 4 Oct 2005 14:21:07 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.14-rc3-rt2
Cc: Steven Rostedt <rostedt@kihontech.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1128459217.13057.73.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
	 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
	 <1128459217.13057.73.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2005-10-04 at 13:49 -0700, Mark Knecht wrote:
> > On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Tue, 2005-10-04 at 11:58 -0700, Mark Knecht wrote:
> > > > > I guess its related to the priority leak I'm tracking down right now.
> > > > > Can you please set following config options and check if you get a bug
> > > > > similar to this ?
> > > > >
> > > > > BUG: init/1: leaked RT prio 98 (116)?
> > > > >
> > > > > Steven, it goes away when deadlock detection is enabled. Any pointers
> > >
> > > Thats actually a red hering caused by asymetric accounting which only
> > > happens when
> > >
> > > CONFIG_DEBUG_PREEMPT=y
> > > and
> > > # CONFIG_RT_DEADLOCK_DETECT is not set
> >
> > OK. I'll keep testing then.
> >
> > Are you asking me to apply the code you sent or is that for someone else?
>
> Please apply, but the second version I sent :(
>
> Pilot error. Will not solve the other problem you are seeing. Looking
> into this right now.
>
> tglx

Will try. I'm a guitar player, nopt a developer.

Save it as a file.
patch -p1 --dry-run <patch-file

(or maybe p0?)

I'll give it a shot.

Thanks,
Mark
