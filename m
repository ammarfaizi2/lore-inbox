Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUHHQyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUHHQyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUHHQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:54:38 -0400
Received: from gprs214-125.eurotel.cz ([160.218.214.125]:22144 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265966AbUHHQyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:54:36 -0400
Date: Sun, 8 Aug 2004 18:54:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: What PM should be and do (Was Re: Solving suspend-level confusion)
Message-ID: <20040808165416.GB2668@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston> <200408032030.41410.david-b@pacbell.net> <1091594872.3191.71.camel@laptop.cunninghams> <1091595224.1899.99.camel@gaston> <1091595545.3303.80.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091595545.3303.80.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yes. I'm not trying to give drivers an inconsistent state, just delaying
> suspending some until the last minute....
> 
> Suspend 2 algorithm:
> 
> 1. Prepare image (freeze processes, allocate memory, eat memory etc)
> 2. Power down all drivers not used while writing image
> 3. Write LRU pages. ('pageset 2')
> 4. Quiesce remaining drivers, save CPU state, to atomic copy of
> remaining ram.
> 5. Resume quiesced drivers.

Hmm, this means pretty complex subtree handling.. Perhaps it would be
possible to make "quiesce/unquiesce" support in drivers so that this
is not needed?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
