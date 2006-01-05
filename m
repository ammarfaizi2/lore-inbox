Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752226AbWAEVpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbWAEVpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbWAEVpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:45:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10730 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752226AbWAEVpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:45:08 -0500
Date: Thu, 5 Jan 2006 22:44:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Scott E. Preece" <preece@motorola.com>, akpm@osdl.org,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105214432.GE2095@elf.ucw.cz>
References: <20060105211446.GD2095@elf.ucw.cz> <Pine.LNX.4.44L0.0601051631200.6460-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0601051631200.6460-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 16:37:52, Alan Stern wrote:
> > > And it's not all that complex.  Certainly no more complex than forcing
> > > userspace tools to use {"on", "D1, "D2", "suspend"} instead of the
> > > much-more-logical {"D0", "D1", "D2", "D3"}.
> > 
> > It is not much more logical. First, noone really needs D1 and
> > D2. Plus, people want to turn their devices on and off, and don't want
> > and should not have to care about details like D1.
> 
> Who are you to say what people really need?  What about people who want to 
> test their PCI device and see if it behaves properly in D1 or D2?  How are 
> they going to do that if you don't let them put it in that state?

> What about people with platform-specific non-PCI devices that have a whole
> bunch of different internal power states?  Why force them to use only two
> of those states?

Its okay with me to add more states _when they are needed_. Just now,
many drivers do not even handle system suspend/resume correctly.

> The kernel isn't supposed to prevent people from doing perfectly legal
> things.  The kernel should provide mechanisms to help people do what they
> want.

We are not adding random crap to kernel just because "someone may need
it". And yes, having aliases counts as "random crap". Perfectly legal
but totally useless things count as a random crap, too.

Bring example hardware that needs more than two states, implement
driver support for that, and then we can talk about adding more than
two states into core code.

								Pavel
-- 
Thanks, Sharp!
