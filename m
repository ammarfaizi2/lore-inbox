Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUIVWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUIVWLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIVWLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:11:12 -0400
Received: from gprs214-200.eurotel.cz ([160.218.214.200]:31113 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268001AbUIVWLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:11:08 -0400
Date: Thu, 23 Sep 2004 00:07:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new class for led devices
Message-ID: <20040922220715.GA30210@elf.ucw.cz>
References: <1095829641l.11731l.0l@hydra> <20040922072727.GA4553@ucw.cz> <1095882787l.4629l.0l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095882787l.4629l.0l@hydra>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well, we already have an interface for setting LEDs through the input
> >layer, it'd be trivial to create an input device driver with just  
> >LEDs
> >and no buttons/keys ...
> >
> 
> It's not really a nice fit with what we are trying to do.  In the input  
> layer, there is a whole list of led types, none of which make sense...  
> For example, on the Sharp Zaurus, we have two leds, one green, one  
> amber.  Which one is LED_NUML?  We don't enforce anything on the policy  
> userspace has for the leds, sometimes it might use the amber led to let  
> the user know they have new mail, and sometimes to show the power is  
> plugged in, sometimes for something else (maybe even that caps lock or  
> numlock is on).

Actually on zaurus one led is labeled "CHARGING" and second is labeled
"MAIL". There are PC keyboards with "MAIL" led already, I
believe... It does not seem to be that bad fit. I do not think you
want to label leds by colors, machine may well have three green leds
(see normal pc keyboard). And on most machines you do not even know
what color the leds are (new notebooks like blue leds :-().

So right solution seems to be adding LED_MAIL and LED_CHARGING and be
done with that...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
