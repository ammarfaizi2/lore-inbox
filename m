Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTIEKHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbTIEKHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:07:40 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262386AbTIEKHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:07:39 -0400
Date: Fri, 5 Sep 2003 11:33:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030905093328.GA200@elf.ucw.cz>
References: <20030903174904.GH30629@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0309031618390.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309031618390.944-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Notice that this is done during resume. You are free to suspend with 1
> > cpu, then attempt to resume with 2 cpus. Not *too* likely to happen,
> > but....
> 
> That's a silly thing to do, though I don't support the notion of letting 
> people find out the hard way. Why not just fail on CONFIG_SMP until it's 
> done right? 

I guess runtime check for number of cpus is better idea -- with more
P4's around kernels with CONFING_SMP will be very common. We should at
least work in single-processor config there.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
