Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVB0RAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVB0RAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVB0RAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:00:12 -0500
Received: from gprs215-59.eurotel.cz ([160.218.215.59]:23500 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261436AbVB0RAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:00:03 -0500
Date: Sun, 27 Feb 2005 17:59:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, mhf@berlios.de,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.11-rc[234] setfont fails on i810 after resume from ACPI-S3
Message-ID: <20050227165948.GF1441@elf.ucw.cz>
References: <20050215122233.22605728.akpm@osdl.org> <20050215202212.GK7338@elf.ucw.cz> <421A6B42.2070108@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421A6B42.2070108@superbug.demon.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, dumping random stuff to console can produce funny results. I'd
> >call that normal. Try cat /dev/urandom, that should be "enough
> >random".
> 
> I am also getting strange effects. I boot into  2.6.11-rc4 and the
> console fonts looks fine. Come back a day later and the console font has
>  corrupt characters. E.g. Displays a "D" instead of an "L" and stuff
> like that. It is mostly readable, except for a few characters.
> It is only the local console that is corrupted. ssh into the box
> displays correct characters, so all I can assume is that the VGA console
> is being programmed with different characters. The bad characters also
> survive a soft reboot( During BIOS boot up), until the linux kernel
> starts booting, and then it switches to a good font.

I have seen something similar on S3 cards with bad video ram (we had
>3 of them). If it survives soft reboot... well, that looks like
hardware problem to me. [We may do something bad in linux, too, but
strange effects should not survive reboot, that's hw bug. I'd suggest
memtest on video ram, but someone would need to write that tool, first].

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
