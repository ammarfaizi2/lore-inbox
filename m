Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbRFZMzz>; Tue, 26 Jun 2001 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbRFZMzq>; Tue, 26 Jun 2001 08:55:46 -0400
Received: from the-old.earth.li ([195.149.39.90]:40202 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id <S264931AbRFZMzd>;
	Tue, 26 Jun 2001 08:55:33 -0400
Date: Tue, 26 Jun 2001 14:55:31 +0200
From: Simon Huggins <huggie@earth.li>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
Message-ID: <20010626145531.J3776@paranoidfreak.co.uk>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106260308100.1730-100000@freak.distro.conectiva> <20010626102303.K7663@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010626102303.K7663@redhat.com>
User-Agent: Mutt/1.3.19i
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
X-Attribution: huggie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkml,

On Tue, Jun 26, 2001 at 10:23:03AM +0100, Tim Waugh wrote:
> > If the initialization of parport_serial fails, we obviously get an
> > error message, which is really annoying:
> [This is different to the issue that is fixed in the -ac tree about
> parport_serial getting probed for even when disabled in config.]

> The idea was that people who have multi-IO cards but don't know what
> modules are can have things Just Work: parport_serial gets loaded
> automagically and detects their cards for them.  But yes, the flip
> side is that people who _don't_ have multi-IO cards are going to get
> that error.

> - change parport_pc so that it doesn't request parport_serial at
>   init.  In this case, how will parport_serial get loaded at all?
>   Perhaps with some recommended /etc/modules.conf lines (perhaps
>   parport_lowlevel{1,2,3,...})?

Can't people who have such things just put:
pre-install insmod parport-serial
post-rm rmmod parport-serial
in modules.conf?

> - people who get the error and don't like it can put 'alias
>   parport_serial off' in /etc/modules.conf.  Not especially pleasant,
>   I guess.

That's the opposite of the above I suppose.

> - parport_serial could be made to initialise successfully even if it
>   doesn't see any devices that it can drive.

That sounds icky IMHO.


Simon.

-- 
UK based domain, email and web hosting ***/     "An excellent suggestion /*
http://www.blackcatnetworks.co.uk/     **/     sir, with only two minor /**
sales@blackcatnetworks.co.uk           */          flaws...." - Kryten /***
Black Cat Networks                     /                              /****
