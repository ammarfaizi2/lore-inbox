Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVCDIcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVCDIcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVCDIcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:32:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7378 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262619AbVCDIcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:32:06 -0500
Date: Fri, 4 Mar 2005 09:31:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Todd Poynor <tpoynor@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Message-ID: <20050304083148.GA1345@elf.ucw.cz>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <422659B1.9090608@mvista.com> <20050303145522.GA3485@openzaurus.ucw.cz> <200503031801.25231.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503031801.25231.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > These are expected to be system states, and sleeping system
> > does not take calls, etc...
> 
> Pavel, remember that great big "wakeup" shaped hole in the
> current PM framework... ?  Even ACPI sleep states support
> wakeup mechanisms, although not well under Linux (yet).

Umm, yes, I see that one.

> One way a sleeping system could take a call is if some
> external chip raised a wakeup-enabled IRQ to wake up the
> system.  And if going from deep sleep to normal operational
> state has a low cost, why shouldn't the system routinely
> enter deep sleep instead of going to CPU idle state?

But in such case /sys/power/sleep is wrong interface to trigger
this. Imagine system taking short sleeps 10 times a second. You don't
want to trigger that using /sys/power/sleep [because it would switch
your consoles].

But yes, I see the fine line... If it turns display off and waits for
incoming call, yes, there /sys/power/sleep makes sense. Someone get me
Linux phone or tell me where to buy one so I can see the fine points
better ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
