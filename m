Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVBBJuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVBBJuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVBBJuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:50:40 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:15236 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262201AbVBBJud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:50:33 -0500
Date: Wed, 2 Feb 2005 10:50:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jes Sorensen <jes@wildopensource.com>
Cc: kernel-janitors@osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org, benh@kernel.crashing.org
Subject: Re: driver model u32 -> pm_message_t conversion: help needed
Message-ID: <20050202095014.GA12955@elf.ucw.cz>
References: <20050125194710.GA1711@elf.ucw.cz> <yq0brb3qs74.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0brb3qs74.fsf@jaguar.mkp.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel> Hi!  Two Long time ago, BenH said that making patches is easy,
> Pavel> so I hope to get his help now... And will probably need more.
> 
> Pavel> Suspend routines change, slowly.
> 
> Pavel> - int (*suspend)(struct device * dev, u32 state); + int
> Pavel> (*suspend)(struct device * dev, pm_message_t state);
> 
> Pavel> For now u32 is typedef-ed to pm_message_t, but that is not
> Pavel> going to be the case for 2.6.12. What needs to be done is
> Pavel> changing all state parameters from u32 to
> Pavel> pm_message_t. suspend() functions should not use state variable
> Pavel> for now (except for PCI ones, those are allowed to call
> Pavel> pci_choose_state and convert state into pci_power_t, and use
> Pavel> that).
> 
> Sorry for being late responding to this, but I'd say this is a prime
> example for typedef's considered evil (see Greg's OLS talk ;).
> 
> It would be a lot cleaner if it was made a struct and then passing a
> struct pointer as the argument instead of passing the struct by value
> as you do right now.

Sorry, can't do that. That would require flag day and change
everything at once. That is just not feasible. When things are
settled, it is okay to change it to struct passed by value.. It is
small anyway and at least we will not have problems with freeing it
etc.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
