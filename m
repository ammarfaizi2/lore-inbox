Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVBCKno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVBCKno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVBCKkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:40:11 -0500
Received: from gprs215-57.eurotel.cz ([160.218.215.57]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262469AbVBCKjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:39:16 -0500
Date: Thu, 3 Feb 2005 11:38:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jes Sorensen <jes@wildopensource.com>
Cc: linux-pm@osdl.org, kernel-janitors@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: driver model u32 -> pm_message_t conversion: help needed
Message-ID: <20050203103857.GB1389@elf.ucw.cz>
References: <20050125194710.GA1711@elf.ucw.cz> <yq0brb3qs74.fsf@jaguar.mkp.net> <20050202095014.GA12955@elf.ucw.cz> <20050202095739.GB12955@elf.ucw.cz> <yq0y8e6ovqt.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0y8e6ovqt.fsf@jaguar.mkp.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Sorry for being late responding to this, but I'd say this is a
> >> prime > example for typedef's considered evil (see Greg's OLS talk
> >> ;).
> >> > 
> >> > It would be a lot cleaner if it was made a struct and then
> >> passing a > struct pointer as the argument instead of passing the
> >> struct by value > as you do right now.
> >> 
> >> Sorry, can't do that. That would require flag day and change
> >> everything at once. That is just not feasible. When things are
> >> settled, it is okay to change it to struct passed by value.. It is
> >> small anyway and at least we will not have problems with freeing it
> >> etc.
> 
> Pavel> Well, we could switch to passing struct by reference
> 
> Pavel> (typedef struct pm_message *pm_message_t)
> 
> Pavel> , but AFAICS it would only bring us problems with lifetime
> Pavel> rules etc. Lets not do it.  Pavel
> 
> This way you end up hiding what is really going on, the very problem
> of using typedefs. If the change is really needed why not get it right
> in the first go?

Because it is impossible? 

[You can't change all drivers at once in incompatible way. See
previous discussion, about half a year ago.]
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
