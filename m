Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263637AbUJ2Xnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUJ2Xnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbUJ2Xiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:38:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59663 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263537AbUJ2X2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:28:24 -0400
Date: Sat, 30 Oct 2004 01:27:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Brownell <david-b@pacbell.net>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] usbnet.c: remove an unused function
Message-ID: <20041029232742.GE6677@stusta.de>
References: <20041028232455.GK3207@stusta.de> <20041029002850.GD29142@stusta.de> <200410291617.30136.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291617.30136.david-b@pacbell.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 04:17:30PM -0700, David Brownell wrote:
> On Thursday 28 October 2004 17:28, Adrian Bunk wrote:
> > [ this time without the problems due to a digital signature... ]
> > 
> > The patch below removes an unused function from drivers/usb/net/usbnet.c
> 
> Actually in this case I'd rather leave the function there;
> the documentation on this chip is hard to find, and this
> function will be needed when someone finally spends the time
> to fix some of the init/reset handshake issues for these
> PL2301/2302 chips.  The current init code cloned some
> very ancient code from about the 2.2.10 (!) or so kernel.
>...

OK.

> - Dave
> 
> p.s. Last I looked, GCC ignored unused inlines; no code
>      generated, no warnings.  Did that change?
>...

It didn't change.

But there are three different possible reactions on my patches:
1. ACK, kill this dead code
2. ups, I really wanted to use this function
3. please keep, code using this function will/might follow in the future

Case 1 is the most common case (and this simply removes some dead code).

I had until now two times case 2 (which means the code is now better).

You are the first person for case 3.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

