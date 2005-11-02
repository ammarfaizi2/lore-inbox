Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVKBNwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVKBNwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVKBNwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:52:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33160 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965037AbVKBNwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:52:14 -0500
Date: Wed, 2 Nov 2005 14:51:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] LEDs support for collie
Message-ID: <20051102135149.GJ30194@elf.ucw.cz>
References: <20051102132145.GA14946@elf.ucw.cz> <20051102134452.GA4778@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102134452.GA4778@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds support for controlling LEDs on sharp zaurus sl-5500. It may
> > look a little bit complex, but it probably needs to be complex --
> > blinking is pretty much mandatory when you only have two leds, and we
> > want to support charging led (controlled by kernel).
> 
> Isn't "blinking" a kind of policy, as is brightness (== duty cycle of
> a high speed toggling)?  What if someone wants synchronised toggling?
> 
> I still think anything over a very simple interface being exported to
> userspace is completely overkill and completely bloated.  Hell, I got
> laughed at for creating an abstracted LEDs interface in the first
> place because many thought the current version was far too bloated.

Well, waking userspace for every blink is going to be expensive,
power-wise. Plus we really need the blinking in kernel -- to
communicate charger error to user.

> I _know_ people have issues with the current interface, whinging that
> "it only exports the colour" but that's something which is actually
> very trivially solvable and therefore _not_ a major problem to solve.

Where's the current interface? I'll be happy to plug collie into that
one...
								Pavel
-- 
Thanks, Sharp!
