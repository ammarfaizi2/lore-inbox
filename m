Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVKWTvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVKWTvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKWTvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:51:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42447 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932258AbVKWTvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:51:44 -0500
Date: Wed, 23 Nov 2005 20:49:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] split sharpsl_pm.c into generic and corgi/spitz specific parts
Message-ID: <20051123194927.GA22375@elf.ucw.cz>
References: <20051123130350.GA23090@elf.ucw.cz> <1132754229.8016.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132754229.8016.55.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd like to see it applied...
> 
> This diff looks much neater than the last one and I agree with the
> principle of it. I don't think its the right time to apply it for two
> reasons:
> 
> 1. We probably shouldn't (can't?) make changes like this in -rc
> kernels 

No, it does not really belong in -rc. I was hoping you would merge it
in your tree so I do not have big patch here and could keep only
collie changes...

> I have a proposal for how we proceed with this:
> 
> After 2.6.15 is released, I envisage a patch which splits the common
> sections of sharpsl_pm.c into arm/common and arm/mach-pxa/sharpsl.h into
> include/arm/hardware/sharpsl_pm.h. I'm happy to generate that patch if
> necessary and pass it to Russell. I'll try and create a patch to show
> the structure I'm aiming for in the next couple of days but at the
> moment we don't know exactly which code is common and I'd prefer to try
> and do the split in one go. 

Ok, works for me. So I'll now concentrate on getting collie working
and leave infrastructure to you...

> I did note your patch adds a copyright header to a file you're mostly
> deleting code from?

I actually did add some collie parts into it, and then deleted
everything #ifdef collie from that. Sorry.
								Pavel
-- 
Thanks, Sharp!
