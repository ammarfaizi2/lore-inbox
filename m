Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTICV7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTICV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:59:55 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5636 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S263532AbTICV7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:59:53 -0400
Date: Wed, 3 Sep 2003 19:08:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030903170801.GA739@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz> <20030901233023.F22682@flint.arm.linux.org.uk> <1062498096.757.45.camel@gaston> <1062594137.19058.23.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062594137.19058.23.camel@dhcp23.swansea.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The whole point was to get rid of the old 2 step save_state, then
> > suspend model which didn't make sense. A saved state is only meaningful
> > as long as that state doesn't get modified afterward, so saving state
> > and suspending are an atomic operation.

Actually swsusp does exactly that, its

suspend drivers
snapshot state
resume drivers
write snapshot to the disk

I do not think that it matters, through, because I can do save_state
and suspend anyway...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
