Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTKPNMz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTKPNMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:12:55 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:4736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262859AbTKPNMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:12:49 -0500
Date: Sun, 16 Nov 2003 14:13:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031116131314.GC199@elf.ucw.cz>
References: <200311090404.40327.rob@landley.net> <20031113130841.GC643@openzaurus.ucw.cz> <200311151830.45731.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311151830.45731.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This brings us to 2B) Snapshotting is way too opaque.  It sits there for
> > > 15 seconds sometimes doing inscrutable things, with no progress indicator
> > > or anything, and then either suspends, panics, or fails and fires the
> > > desktop back up with no diagnostic message.
> > >
> > > On the whole, this is really really cool, and if you have any suggestions
> > > how I could help, I'm all ears.  (I'm unlikely to poke into the code too
> >
> > Try "my" swsusp code. It should not fail silently; it may
> > panic the box but at that point you at least have a message.
> 
> I've had your swsusp hang, panic, go into a half-suspended state where I have 
> to hold the power button ten seconds to actually power it off and reboot, and 
> fail in a few other ways.  What I've never actually had your code do is 
> successfully suspend something I could resume from.
> 
> 90% of the time, patrick's code does that for me.  Yours has yet to do so even 
> once for me.
> 
> I suppose I could give it another shot, though...

Strange, they should be pretty much the same, functionality-wise.

Here are few tricks... OTOH if it works for you 90% of time, these
would take a lot of time to test :-(.

If you want to trick swsusp/S3 into working, you might want to try:

* go with minimal config, turn off drivers like USB, AGP you don't
really need

* use ext2. At least it has working fsck. [If something seemes to go
  wrong, force fsck when you have a chance]

* turn off modules

* use vga text console, shut down X

* try running as few processes as possible, preferably go from single
use mode

When you make it work, try to find out what exactly was it that broke
suspend, and preferably fix that.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
