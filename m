Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTIJAGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTIJAGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:06:42 -0400
Received: from gprs150-72.eurotel.cz ([160.218.150.72]:3968 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265086AbTIJAGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:06:40 -0400
Date: Wed, 10 Sep 2003 02:06:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Passing suspend level down to drivers
Message-ID: <20030910000627.GD217@elf.ucw.cz>
References: <20030909230755.GG211@elf.ucw.cz> <Pine.LNX.4.44.0309091615400.695-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091615400.695-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > APM suspend-to-ram
> > APM suspend-to-disk
> > ACPI standby (S1)
> > ACPI suspend-to-ram (S3)
> > ACPI suspend-to-disk (S4bios)
> > swsusp
> > 
> > Do we want to support ACPI S2? I don't think so. That list is not
> > *that* bad.
> 
> ACPI S2 is irrelevant. Nonetheless, you're suggesting that we add manual 
> checks at runtime for each device to determine what state to go into, 
> depending on whether the system is entering suspend-to-disk or suspend-to-
> ram. 
> 
> That's a bad idea because:
> 
> - It doesn't need to be done at runtime, only initialization. Though it's 
>   not a permformant path, it's still more efficient to do it once only. 
> 
> - It forces policy into the drivers, instead of having them specify a 
>   changeable default. 

Okay, so you suggest "driver has table of default things to do on
suspend-to-X, changeable by user", while I say "driver has table of
default things to do on suspend-to-X". I do not thing changeability by
user is so important here, but I'm not going to argue too much about
that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
