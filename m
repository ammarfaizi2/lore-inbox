Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVE3VgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVE3VgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVE3VgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:36:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2728 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261766AbVE3Vfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:35:50 -0400
Date: Mon, 30 May 2005 23:35:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Q: swsusp with S5 instead of S4?
Message-ID: <20050530213532.GA3371@elf.ucw.cz>
References: <20050502214932.GA4650@elf.ucw.cz> <Pine.LNX.4.62.0505301540410.20347@light.int.webcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505301540410.20347@light.int.webcon.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Asside from trying to figure out exactly what hardware parameteres are not
> >>being saved/restored, I'm happy to let the BIOS initialise those things.
> >>But, I need a way to perform a normal power-off/S5 after swsusp instead 
> >>of a
> >>soft-off/S4 so that I don't have to go though the double-grub-boot process
> >>every time. Can this be done?
> >
> >echo shutdown > /sys/power/disk should do that. If it does
> >not... well, see what is different in those two codepaths...
> 
> I found out that 'shutdown' is the default and that I was already using
> that. Strange.
> 
> I did finally now get around to doing a more through battery of tests with
> many combinations of hibernating with 'platform' and 'shutdown' modes, and
> various GRUB 'halt' and 'reboot' commands. What I came up with is that
> basically nothing works.
> 
> In essentially all cases (except for rare inexplicable instances when it
> _does_ work, though I cannot replicate it with any consistency) the special
> keys _are_ functional immediately after power-on, through GRUB, through
> kernel initialization, through reading the suspended image. But then
> immediately after control is passed to the resumed system, the keys stop
> working.
> 
> Does this give you any other clues as to what might be going on?

No idea :-(. Something bad in ACPI land.

If there are some effects that survive reboot or powerdown, complain
to your system vendor about crappy hardware. We should fix Linux, too,
but that will be hard to do remotely.

Just go through swsusp and normal code paths, and see whats
different...

								Pavel
