Return-Path: <linux-kernel-owner+w=401wt.eu-S1754976AbWL1Ux5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbWL1Ux5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbWL1Ux5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:53:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33671 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754975AbWL1Ux4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:53:56 -0500
Date: Thu, 28 Dec 2006 21:53:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Message-ID: <20061228205341.GA3060@elf.ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612201312.36616.david-b@pacbell.net> <20061227175344.GC4088@ucw.cz> <200612281248.21325.david-b@pacbell.net> <20061228205055.GA2311@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228205055.GA2311@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-12-28 21:50:55, Pavel Machek wrote:
> Hi!
> 
> > > > From: Philipp Zabel <philipp.zabel@gmail.com>
> > > 
> > > Missing s-o-b?
> > 
> > Yes, still ...
> > 
> > > > +static inline int gpio_direction_input(unsigned gpio)
> > > > +{
> > > > +	if (gpio > PXA_LAST_GPIO)
> > > > +		return -EINVAL;
> > > > +	pxa_gpio_mode(gpio | GPIO_IN);
> > > > +}
> > > 
> > > Missing return 0?
> > > 
> > > > +static inline int gpio_direction_output(unsigned gpio)
> > > > +{
> > > > +	if (gpio > PXA_LAST_GPIO)
> > > > +		return -EINVAL;
> > > > +	pxa_gpio_mode(gpio | GPIO_OUT);
> > > > +}
> > > > +
> > > 
> > > And here?
> > 
> > You're looking at about the oldest version of that patch.
> > Admittedly there were too many floating around...
> 
> I think I've looked at the newer ones, too, and this particular return
> was _not_ fixed.

Ok, I was wrong, the very newest one seems to be okay.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
