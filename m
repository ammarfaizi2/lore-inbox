Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUAOWtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUAOWtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:49:13 -0500
Received: from gprs214-60.eurotel.cz ([160.218.214.60]:36736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262566AbUAOWtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:49:08 -0500
Date: Thu, 15 Jan 2004 23:48:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Robert Love <rml@ximian.com>, Daniel Gryniewicz <dang@fprintf.net>,
       Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency
Message-ID: <20040115224851.GD18488@elf.ucw.cz>
References: <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <1073841200.1153.0.camel@localhost> <E1AfjdT-0008OH-00@chiark.greenend.org.uk> <1073843690.1153.12.camel@localhost> <20040114045945.GB23845@redhat.com> <1074107508.4549.10.camel@localhost> <1074107842.1153.959.camel@localhost> <20040115204257.GG467@openzaurus.ucw.cz> <200401152221.i0FMLdQr000218@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401152221.i0FMLdQr000218@81-2-122-30.bradfords.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I have an athlon-xp laptop (HP pavilion ze4500) with powernow that
> > > > definitely goes into low power mode when the plug is pulled.  The screen
> > > > goes dark, and everything slows down.
> > > 
> > > Dave did not mean that the other power management schemes cannot do the
> > > automatic reduction on loss of AC, just that there is no SMM/BIOS hacks
> > > to do it automatically.
> > 
> > People are designing machines where battery can't provide
> > enough ampers for cpu in high-power mode. If speedstep machines
> > have same problem, SMM is actually right thing to do.
> 
> This reminds me of an idea I had years ago, but never really looked in
> to very much, (it may well have been implemented somewhere
> independently of my idea anyway).  Basically, it was for a multi-cpu
> machine which, instead of running cpus in parallel, with all the
> common scaling problems, ran each CPU in series for a very short
> timeslice, effectively being a uni-processor machine, but moving the
> state of the processor's registers between physical CPUs.  The theory
> was that it would be possible to clock each CPU much higher for a
> short period of time than it could be successfully clocked
> continuously.  Physical CPUs with poor cooling could even be given a
> shorter timeslice.

s390's actually do something like that. They have 16 (or so) physical
processors, but if you only have licence for running 1 cpu, you use
only one. OTOH if that cpu fails, it transfers state to next one and
continues.

Well, what you described could gain you some extra speed (relative to
uniprocessor), but it would be prohibitely expensive.

Wait.

We have it today.

Remember P4's? Those beasts have 90W but cooling designed only for 75W
or so, and thermal diode that slows when they get too hot.

If someone has SMP-P4 with such broken cooling solution (not sure how
common they are), ping-ponging task might actually get you extra
speed.

Same goes for any SMP machine whose CPU fans failed and is therefore
thermal-throttled. (But I'm not sure if thermal-throttling works at
all at SMPs.)

[I have one notebook here that has failed cpu fan... Thermal
throttling works more or less okay, but if you want your computation
to go fast, you need to place it next to fan...]
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
