Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFIUxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTFIUxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:53:52 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22428 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261994AbTFIUxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:53:50 -0400
Date: Mon, 9 Jun 2003 23:07:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
Message-ID: <20030609210706.GA508@elf.ucw.cz>
References: <20030609184233.GA201@elf.ucw.cz> <Pine.LNX.4.44.0306091323340.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306091323340.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You are currently adding more methods and semantics just to make
> > system devices separate from "normal" ones. If you keep two-stage
> > (actually three-stage suspend), you'll have system devices similar to
> > normal ones, and will have less special cases to care about.
> 
> The whole point of doing this is because system devices are not regular 
> devices and shouldn't be treated as such. This actually simplifies the 
> requirements for representing system devices in the device hierarchy, 
> despite adding new functions..

Okay, but you should keep "new" functions as similar to existing ones
as possible. That means 3 parameters for suspend functions, and as
similar semantics to existing callbacks as possible.

> > And keyboard controller with its devices needs to be suspended
> > early/resumed late because both operations are likely to need
> > interrupts.
> 
> So? A keyboard controller is not classified as a system device.

Its not on pci, I guess it would end up as a system device...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
