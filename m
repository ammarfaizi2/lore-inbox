Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTFIS3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTFIS3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:29:09 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:32993 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264246AbTFIS3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:29:05 -0400
Date: Mon, 9 Jun 2003 20:42:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
Message-ID: <20030609184233.GA201@elf.ucw.cz>
References: <20030607203304.GB667@elf.ucw.cz> <Pine.LNX.4.44.0306090918200.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306090918200.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > System devices may be special, but they should not be so special not
> > to require u32 level.  All current system devices need to be
> > suspended last, but that's pure coincidence, I believe.
> 
> Fine. Then show me a device that needs a two-stage suspend. I'm not going 
> to add an extra method and semantics for something that isn't going to 
> currently be used by anyone.

Ouch?

You are currently adding more methods and semantics just to make
system devices separate from "normal" ones. If you keep two-stage
(actually three-stage suspend), you'll have system devices similar to
normal ones, and will have less special cases to care about.

And keyboard controller with its devices needs to be suspended
early/resumed late because both operations are likely to need
interrupts.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
