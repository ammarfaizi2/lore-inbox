Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVBRWAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVBRWAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVBRWAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:00:31 -0500
Received: from mail1.kontent.de ([81.88.34.36]:48019 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261528AbVBRWAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:00:24 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 23:00:21 +0100
User-Agent: KMail/1.7.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <200502182223.19896.oliver@neukum.org> <20050218213428.GD1403@elf.ucw.cz>
In-Reply-To: <20050218213428.GD1403@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502182300.21420.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Februar 2005 22:34 schrieb Pavel Machek:

> Well, if you have power button on usb keyboard -- why should it be
> handled differently from built-in button?

I see no reason. But that tells you that one subsystem should handle
that, not which subsystem.
 
> > > I think that's all you need to trigger actions. You don't need the exact
> > > percentage of the battery, and you don't need the exact AC voltage at
> > > input. 
> > 
> > That is very debateable. I might want a quiet mode and would be
> > interested in notifications about thermal data and fan status. 
> 
> Hmm, yes, some thermal notifications are needed. OTOH I'm not sure if
> all the hardware does sent interrupts for temperature changes (you
> definitely do not get interrupts for "small" changes that do not cross

I suspect that this is really done in SMI.

> trip points), and I do not see how you can do interrupts for fan
> status. Either fans are under Linux control (and kernel could tell you
> when it turns fan on/off, but...), or they do not exist from Linux's
> point of few.

They still can have a readable rate, even if not under os control.
Nevertheless I don't think you can reasonably define what might
interest user space or not and in which detail.

	Regards
		Oliver
