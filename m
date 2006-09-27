Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWI0JKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWI0JKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWI0JKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:10:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55265 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751094AbWI0JKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:10:06 -0400
Date: Wed, 27 Sep 2006 11:09:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060927090953.GD24857@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz> <20060925160648.de96b6fa.akpm@osdl.org> <20060925232151.GA1896@elf.ucw.cz> <1159289108.9652.10.camel@chalcedony.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159289108.9652.10.camel@chalcedony.pathscale.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-09-26 09:45:08, Bryan O'Sullivan wrote:
> On Tue, 2006-09-26 at 01:21 +0200, Pavel Machek wrote:
> 
> > Your machines spend 15 seconds in drivers? Ouch, I did not realize
> > _that_. 
> 
> My laptop spends some substantial amount of time aimilarly mooning me
> when I suspend it.  The phases are timed roughly like this:
> 
> 16 seconds doing things to devices
> 2 seconds memory
> 4 seconds doing more things to devices
> 10 seconds writing to disk
> 
> (Yes, it takes about 32 seconds to suspend.)

But you should still have logs of that first 16 seconds, as they
happen before memory snasphots, right? dmesg after resume should be
enough.

Can you enable printk timing, and get us the log? Perhaps
bugzilla.kernel.org?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
