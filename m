Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUAUAGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUAUAGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:06:52 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:10624 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265847AbUAUAGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:06:51 -0500
Date: Wed, 21 Jan 2004 01:05:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: swsusp does not stop DMA properly during resume
Message-ID: <20040121000546.GF1234@elf.ucw.cz>
References: <20040120224653.GA19159@elf.ucw.cz> <20040120150629.6949eda7.akpm@osdl.org> <1074642037.739.49.camel@gaston> <20040120235347.GE1234@elf.ucw.cz> <20040120160159.5cb078ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120160159.5cb078ec.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I _think_ what this patch is doing is suspending all devices from within
> > > > the boot kernel before starting into the resumed kernel.  Is this correct?
> > > > 
> > > > > +	update_screen(fg_console);	/* Hmm, is this the problem? */
> > > > 
> > > > Cryptic comment.  To what "problem" does this refer?
> > > 
> > > Note that you should make sure all calls to update_screen (among others)
> > > are guarded by the console semaphore, with my VT patch, not doing so
> > > will result in WARN_ON's
> > 
> > Hmmm... yes, I'll need to fix that one. [Is there console semaphore in
> > 2.6.1, or do I need to wait for 2.6.2 before I can do something with
> > this?]
> 
> It's acquire_console_sem()/release_console_sem().
> 
> I'll change the patch.  Could you please test it all in next -mm, let me
> know?

Okay, no problem.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
