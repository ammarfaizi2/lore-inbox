Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbVKBVMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbVKBVMd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVKBVMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:12:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33497 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965242AbVKBVMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:12:32 -0500
Date: Wed, 2 Nov 2005 22:11:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: vojtech@suse.cz, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102211146.GG23943@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <1130891953.8489.83.camel@localhost.localdomain> <20051102135614.GL30194@elf.ucw.cz> <1130942322.8523.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130942322.8523.15.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Perhaps I'd keep it simple and leave it at
> > 
> > * do hardcoded kernel action for this led
> > 
> > or
> > 
> > * do whatever userspace tells you.
> > 
> > That way you will not be able to remap charger LED onto hard disk
> > indicator, but we can support that on ibm-acpi too. (Where hw controls
> > LEDs like "sleep", but lets you control them. You can't remap,
> > though).
> 
> Then the arguments start about which function should be hardcoded to
> which leds and why can't userspace access these triggers?

Because there are some machines (IBM thinkpad) where LEDs are either
driven by userspace, or driven by hardware. I'd like to export that
functionality using same interface.

> I'd prefer a totally flexible system and it doesn't really add much
> complexity once you have a trigger framework which we're going to need
> to handle mutiple led trigger sources sanely anyway.

Unfortunately hardware can not do that, at least for IBM
thinkpad. Plus, remapping harddisk indicator on battery led is not
something I'd like to support :-). 

								Pavel
-- 
Thanks, Sharp!
