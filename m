Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUK0Ip6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUK0Ip6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 03:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUK0Ip6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 03:45:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16839 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261158AbUK0Ipw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 03:45:52 -0500
Date: Sat, 27 Nov 2004 08:22:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
Message-ID: <20041127072224.GM1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams> <1101293918.5805.221.camel@desktop.cunninghams> <20041125170718.GA1417@openzaurus.ucw.cz> <E1CXs6Z-0001cv-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CXs6Z-0001cv-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> 1) Make name_to_dev_t non init. Why should you need to reboot if all you
> >> want to do is change the device you're using to suspend? That's M_'s way
> > 
> > Well, if you change it using /proc and forget to change kernel cmd line, you'll have
> > a problem. Do you really change this so often?
> 
> name_to_dev_t needs to be non-init in order to make it possible to
> trigger a resume when the block device driver isn't static. Pavel, would
> you be willing to consider a patch to make it possible to trigger swsusp
> resume from userspace? That gets things working with initrd kernels.
> I've been using something along these lines for a few weeks now, and it
> hasn't eaten my filesystem yet.

Given it is not too intrusive... why not. Send it for comments.
I probably will not use this myself, so you'll need to test/maintain
it.

> Yes, I was thinking of this mostly from a distribution perspective.
> There's always potential for data-loss if users resume after touching
> the root filesystem. On the other hand, it's currently possible for them
> to do that anyway (think booting a different kernel without swsusp
> support, then rebooting back into the swsusp one)

Yep... 
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

