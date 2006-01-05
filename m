Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWAEW3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWAEW3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWAEW3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:29:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47272 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751453AbWAEW3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:29:01 -0500
Date: Thu, 5 Jan 2006 23:28:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105222849.GH2095@elf.ucw.cz>
References: <Pine.LNX.4.50.0601051342470.17046-100000@monsoon.he.net> <Pine.LNX.4.44L0.0601051701560.6460-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601051701560.6460-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 5 Jan 2006, Pavel Machek wrote:
> 
> > Its okay with me to add more states _when they are needed_. Just now,
> > many drivers do not even handle system suspend/resume correctly.
> 
> > We are not adding random crap to kernel just because "someone may need
> > it". And yes, having aliases counts as "random crap". Perfectly legal 
> > but totally useless things count as a random crap, too.
> > 
> > Bring example hardware that needs more than two states, implement
> > driver support for that, and then we can talk about adding more than
> > two states into core code.
> 
> Embedded devices are a great example.  Consider putting Linux on a 
> portable phone.  The individual components can have many different power 
> states, depending on which clock and power lines are enabled.  "on" and 
> "suspend" won't be sufficient to handle the vendor's needs.

Consider putting Linux on a portable phone. It could contain 13-bit
bytes. Does that mean we should support 13-bit bytes in linux?

No.

People are running Linux on cellphones today, and they are running for
weeks in standby, too. And runtime suspend support is still terminally
broken, so they somehow get around that.

Do you have example of device that has multiple "sleep states" and it
makes sense to use them?

There are examples of devices that have multiple "on states". IIRC
graphics cards can already control their clock tick rates. I hope we
are not trying to solve that one here. 
								Pavel
-- 
Thanks, Sharp!
