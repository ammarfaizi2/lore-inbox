Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVBRXwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVBRXwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVBRXwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:52:00 -0500
Received: from mail1.kontent.de ([81.88.34.36]:24544 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261567AbVBRXvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:51:51 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Sat, 19 Feb 2005 00:51:47 +0100
User-Agent: KMail/1.7.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <200502182300.21420.oliver@neukum.org> <20050218233443.GB1628@elf.ucw.cz>
In-Reply-To: <20050218233443.GB1628@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502190051.48052.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 19. Februar 2005 00:34 schrieb Pavel Machek:
> Hi!
> 
> > > Well, if you have power button on usb keyboard -- why should it be
> > > handled differently from built-in button?
> > 
> > I see no reason. But that tells you that one subsystem should handle
> > that, not which subsystem.
> 
> If usb keyboard has power button... I do not think we really want to
> route that through acpi. And what if acpi is not available? (APM knows
> about suspend key in weird way, but not about power key).

I'd suggest to primarily care about acpi. The other important power
management subsystems will follow suit.

> > > trip points), and I do not see how you can do interrupts for fan
> > > status. Either fans are under Linux control (and kernel could tell you
> > > when it turns fan on/off, but...), or they do not exist from Linux's
> > > point of few.
> > 
> > They still can have a readable rate, even if not under os control.
> > Nevertheless I don't think you can reasonably define what might
> > interest user space or not and in which detail.
> 
> Well, we can say that userspace definitely is interested in "power"
> key ;-).

I wouldn't call that selfevident. The system might be eg. a ticket
vending system and we care only about wake ups from touchscreen,
trackball and modem and about volume control keys. I don't think
you can make up any rules about what user space is interested or not.

	Regards
		Oliver
