Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263454AbUJ2SDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbUJ2SDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbUJ2SAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:00:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10987 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263447AbUJ2R54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:57:56 -0400
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
In-Reply-To: <32870.192.168.1.5.1099062000.squirrel@192.168.1.5>
References: <20041027211957.GA28571@elte.hu>
	 <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	 <20041028063630.GD9781@elte.hu>
	 <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	 <20041028085656.GA21535@elte.hu>
	 <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	 <20041028093215.GA27694@elte.hu>
	 <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
	 <20041028191605.GA3877@elte.hu>
	 <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
	 <20041029073001.GB30400@elte.hu>
	 <32870.192.168.1.5.1099062000.squirrel@192.168.1.5>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 13:57:50 -0400
Message-Id: <1099072671.14209.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 16:00 +0100, Rui Nuno Capela wrote:
> For example, in my own case, if those tests are done with ACPI disabled
> (yes, with acpi=off), this laptop of mine just skews the results
> completely: vanilla 2.6.9 gets better results, while the RT ones go
> slumber. Go figure ;)

I suspect that your laptop uses SMM traps to talk to the battery.  That
could certainly explain the 700 us xruns, because SMM disables all
interrupts.  This was covered recently in another thread.  According to
Alan Cox most laptops work this way.

Has anyone been able to reproduce the problem on a desktop system?

Lee

