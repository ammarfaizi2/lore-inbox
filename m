Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSDIUy4>; Tue, 9 Apr 2002 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311577AbSDIUy4>; Tue, 9 Apr 2002 16:54:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32272 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311575AbSDIUyW>; Tue, 9 Apr 2002 16:54:22 -0400
Date: Tue, 9 Apr 2002 22:54:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: m.knoblauch@TeraPort.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp fixes] Re: Linux 2.4.19pre5-ac3
Message-ID: <20020409205424.GD4322@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CB1B89D.13DDF456@TeraPort.de> <20020408215908.GI31172@atrey.karlin.mff.cuni.cz> <3CB29AE3.E3447952@TeraPort.de> <20020409105440.GB14695@atrey.karlin.mff.cuni.cz> <3CB2D8E6.F0513802@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  My question was: can I have a system without active swap and still use
> > > swsusp? Creating a swap/suspend partition of appropriate size is not a
> > > problem. I just do not want to "swapon" it.
> > 
> > You need to swapon it. If you do not want to keep it swapped on,
> > there's no problem in
> > 
> > swapon /dev/swap
> > echo 4 > /proc/acpi/sleep
> > sleep 10
> > swapoff /dev/swap
> > 
> 
>  thanks. That is what I wanted to know. That basically means that I will
> have to boot with a active swap device in order to get the resume
> functionality - correct? And then I would do a "swapoff" late in the
> boot process (maybe before starting the graphical crap :-).

You do not need swapon during boot. swsusp no longer works like that
(it used to, but not now). swapon just before suspend is okay.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
