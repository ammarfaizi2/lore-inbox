Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTGOGWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTGOGWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:22:12 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59525 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263738AbTGOGWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:22:03 -0400
Date: Tue, 15 Jul 2003 08:36:12 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030715063612.GB27368@ucw.cz>
References: <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux> <20030714201245.GC24964@ucw.cz> <20030714201804.GF902@elf.ucw.cz> <20030714204143.GA25731@ucw.cz> <20030714230219.GB11283@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714230219.GB11283@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 01:02:19AM +0200, Pavel Machek wrote:

> > > > > Having listened to the arguments, I'll make pressing Escape to cancel
> > > > > the suspend a feature which defaults to being disabled and can be
> > > > > enabled via a proc entry in 2.4. I won't add code to poll for ACPI (or
> > > > > APM) events :>
> > > > 
> > > > I'd suggest making it a mappable function in the keymap, like reboot is
> > > > for example. Both for initiating and stopping the suspend. How about
> > > > that?
> > > 
> > > Any user can load his own keymap, I believe... And I do not like
> > > having special /proc options for esc key...
> > 
> > So what? He can press ctrl-alt-del or whatever if he has access to the
> > keyboard anyway. Nevertheless I don't see any way to cause harm by
> > cancelling a sw-suspend other than if a server was shutting down due to
> > the UPS batteries being empty. And in that case the machine will be in a
> > locked room anyway.
> 
> ctrl-alt-del maps to "echo you lost" on many machines. It just signals
> init, does nothing more.
> 
> That UPS is bad enough... It should be okay to have server locked but
> have its keyboard/monitor publicly available.

I'm very much sure this feature (having a server locked, while
keyboard/screen is accessible) is much LESS useful than being able to
stop an suspend in progress. That's if the suspend isn't lightning fast,
of course, which is is not.

Unfortunately, while you can route the start-suspend command through
userspace (init, whatever) like the reboot command is, but I fear when
the suspend is in progress, it's not possible to talk to userspace
anymore ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
