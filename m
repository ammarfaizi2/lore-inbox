Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293233AbSBWVez>; Sat, 23 Feb 2002 16:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293216AbSBWVdI>; Sat, 23 Feb 2002 16:33:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26119 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293217AbSBWVbu>; Sat, 23 Feb 2002 16:31:50 -0500
Date: Sat, 23 Feb 2002 22:28:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dave Jones <davej@suse.de>, Benjamin Pharr <ben@benpharr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020223212837.GC943@elf.ucw.cz>
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de> <20020222022329.A3533@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222022329.A3533@suse.cz>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > It compiled fine. When I booted up everything looked normal with the
> >  > exception of a 
> >  > eth1: going OOM 
> >  > message that kept scrolling down the screen. My eth1 is a natsemi card.
> > 
> >  That's interesting. Probably moreso for Manfred. I'll double check
> >  I didn't goof merging the oom-handling patch tomorrow.
> > 
> >  > Eventually that stopped and gdm came up. For some reason my keyboard and
> >  > mouse wouldn't work.
> > 
> >  -dj includes a different input layer to Linus' tree, which requires
> >  some extra options enabled.  Vojtech, this is quite a frequent
> >  'bug report', and I think if you merged that with Linus, the number
> >  of reports would climb. Is there a possibility of simplifying the
> >  config.in somewhat? Or at least changing the defaults to give the
> >  element of least surprise..
> 
> The defaults are changed :(. However people coying their .configs over
> don't use the defaults. The help files say what to do in case of doubt.
> I'm not sure what more I can do.

Few define_bool's for transition period? That way it will get as =y to
.config, and you can present real config options after few versions
;-).

Or create 

CONFIG_ADVANCED_INPUT_OPTIONS, default to N, which will make all
suitable options Y.... That's hacky, but we've got a precedents.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
