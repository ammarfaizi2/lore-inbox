Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUHRNLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUHRNLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266379AbUHRNKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 09:10:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2229 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266598AbUHRNFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 09:05:52 -0400
Date: Wed, 18 Aug 2004 15:03:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [patch] enums to clear suspend-state confusion
Message-ID: <20040818130348.GB1810@openzaurus.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz> <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org> <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org> <20040818002711.GD15046@elf.ucw.cz> <1092794687.10506.169.camel@gaston> <20040818061227.GA7854@elf.ucw.cz> <1092812149.9932.180.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092812149.9932.180.camel@gaston>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, that's exactly what I did... Unfortunately typedef means ugly
> > code. So I'll just switch it back to enum system_state, and lets care
> > about device power managment when it hits us, okay?
> 
> I don't agree... with this approach, we'll have to change all drivers
> _twice_ when we move to something more descriptive than a scalar
> 

I'm not entirely concinced we need anything more than a scalar.
I think we could simply create PM_RUNTIME_0 .. PM_RUNTIME_9, and that will work
as long as all devices have <= 10 power managment states.

That can well mean "forever".

Besides, when enums are in place, you can just searcg&replace.
Search part is way harder with u32s.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

