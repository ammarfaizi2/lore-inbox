Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUHHRNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUHHRNU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 13:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUHHRNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 13:13:20 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:10368 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265970AbUHHRNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 13:13:19 -0400
Date: Sun, 8 Aug 2004 19:13:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -mm swsusp: do not default to platform/firmware
Message-ID: <20040808171305.GB3298@elf.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz> <Pine.LNX.4.50.0408012313350.4359-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408012313350.4359-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -mm swsusp now defaults to platform/firmware suspend... That's
> > certainly unexpected, changes behaviour from previous version, and
> > only works on one of three machines I have here. I'd like the default
> > to be changed back. Please apply,
> 
> I'd rather leave it, and put pressure on the platform implementations to
> be made to work. If you want to shutdown, then specify it on the command
> line before you suspend (or add it to the suspend script).

I'm afraid that we'll get big storm of complains "swsusp does not
work after merge from -mm tree", "switch to shutdown method", "oh, it
works now". I assume it works in less than 30% of cases... it really
should not be default.

Oh and "firmware" suspend should never ever be autoselected -- it
needs completely different suspend partition layout which is
mainboard-specific....
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
