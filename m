Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130658AbRBWI7R>; Fri, 23 Feb 2001 03:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130647AbRBWI7A>; Fri, 23 Feb 2001 03:59:00 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130270AbRBWI6h>;
	Fri, 23 Feb 2001 03:58:37 -0500
Message-ID: <20010222224849.A14571@bug.ucw.cz>
Date: Thu, 22 Feb 2001 22:48:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nye Liu <nyet@curtis.curtisfong.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
In-Reply-To: <20010221140055.A8113@curtis.curtisfong.org> <E14VhQ7-0002s0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14VhQ7-0002s0-00@the-village.bc.nu>; from Alan Cox on Wed, Feb 21, 2001 at 10:07:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is NOT what I'm seeing at all.. the kernel load appears to be
> > pegged at 100% (or very close to it), the user space app is getting
> > enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
> > appears to be ACKING ALL the traffic, which I don't understand at all
> > (e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)
> 
> TCP _requires_ the remote end ack every 2nd frame regardless of
> progress.

Should not TCP advertise window of 0 to stop sender?

Where does kernel put all those data in tcp case? I do not understand
that. Transmiter blasts at 300Mbit, userspace gets 20Mbit. There's
280Mbit datastream going _somewhere_. It should be eating memory at
35MB/second, unless you have 1Gig of ram, something interesting should
happen after minute or so...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
