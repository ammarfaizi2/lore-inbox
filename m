Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUAMAkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUAMAkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:40:04 -0500
Received: from gprs214-71.eurotel.cz ([160.218.214.71]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263787AbUAMAkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:40:00 -0500
Date: Tue, 13 Jan 2004 01:39:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040113003908.GB4752@elf.ucw.cz>
References: <20040108214240.GD467@openzaurus.ucw.cz> <Pine.LNX.4.44.0401130012100.12912-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401130012100.12912-100000@poirot.grange>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've seen slow machine (386sx with ne1000) that could not receive 7 full-sized packets
> > back-to-back. You are sending 22 full packets back-to-back.
> > I'd expect some of them to be (almost deterministicaly) lost,
> > and no progress ever made.
> 
> As you, probably, have already seen from further emails on this thread, we
> did find out that packets were indeed lost due to various performance
> reasons. And the best solution does seem to be switching to TCP-NFS, and
> making it the default choice for mount (where available) seems to be a
> very good idea.
> 
> Thanks for replying anyway.
> 
> > In same scenario, TCP detects "congestion" and works mostly okay.
> 
> Hm, as long as we are already on this - can you give me a hint / pointer
> how does TCP _detect_ a congestion? Does it adjust packet sizes, some
> other parameters? Just for the curiousity sake.

If TCP sees packets are lost, it says "oh, congestion", and starts
sending packets   more   slowly   ie       introduces          delays
between          packets.     When    they   no longer  get lost, it
speeds up to full speed.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
