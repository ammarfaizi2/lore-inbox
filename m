Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbRBQSPt>; Sat, 17 Feb 2001 13:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbRBQSPj>; Sat, 17 Feb 2001 13:15:39 -0500
Received: from ns.caldera.de ([212.34.180.1]:58378 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129423AbRBQSPd>;
	Sat, 17 Feb 2001 13:15:33 -0500
Date: Sat, 17 Feb 2001 18:47:56 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Christoph Hellwig <hch@caldera.de>,
        Thomas Widmann <thomas.widmann@icn.siemens.de>,
        linux-kernel@vger.kernel.org, Nick Pollitt <npollitt@engr.sgi.com>
Subject: Re: SMP: bind process to cpu
Message-ID: <20010217184756.A15263@caldera.de>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Thomas Widmann <thomas.widmann@icn.siemens.de>,
	linux-kernel@vger.kernel.org, Nick Pollitt <npollitt@engr.sgi.com>
In-Reply-To: <200102171327.OAA00342@ns.caldera.de> <3A8E8719.DD58EB7C@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A8E8719.DD58EB7C@colorfullife.com>; from manfred@colorfullife.com on Sat, Feb 17, 2001 at 03:13:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	[Nick, I've added you to the Cc list so you can look at
	 it for future versions of your patch]


On Sat, Feb 17, 2001 at 03:13:45PM +0100, Manfred Spraul wrote:
> You must also update wake_process_synchroneous(), otherwise you can get
> lost wakeups with pipes.
> 
> Something like
> 
> >         if (!(p->cpus_allowed & (1 << smp_processor_id()))
> >                 reschedule_idle(p);
> 
> must be added after add_to_runqueue().

Ok.

> Ingo Molnar did some testing with tux2, and under high load wakeups were
> lost without such a patch.

(s/tux2/tux/ I suppose)

Yepp - but tux is again not userspace...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
