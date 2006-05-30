Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWE3NVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWE3NVm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWE3NVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:21:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20644 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751102AbWE3NVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:21:41 -0400
Date: Tue, 30 May 2006 15:20:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Netdev list <netdev@vger.kernel.org>, Jirka Lenost Benc <jbenc@suse.cz>,
       pe1rxq@amsat.org
Subject: zd1201 failure on sharp zaurus explained
Message-ID: <20060530132054.GA9780@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Now I found out what went wrong with zd1201 on sharp zaurus (spitz)...

Card is detected and seems to work okay, except that you don't get any
results from iwlist eth1 scan, and card generally does not do anything
involving radio.

And now I have an explanation, too:

If you plug card directly to zaurus, above is what happens.

If you plug it into the hub, hub flashes the lights and shuts down, as
if not enough power is available from the zaurus.

...which is probably the case, because if I connect external 6V power
supply to the hub, it all starts to work.

So... it is

1) hw problem: spitz power supply is not strong enough to drive zd1201

2) usb problem, probably. Should not usb core detect that card
requires too much juice and refuse to power it up?

...and the morale is, always put hub between device and the host so
that you can see the flashy leds :-).
								Pavel 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
