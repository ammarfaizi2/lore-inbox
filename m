Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbULEXZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbULEXZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbULEXZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:25:06 -0500
Received: from gprs215-105.eurotel.cz ([160.218.215.105]:38529 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261305AbULEXZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:25:00 -0500
Date: Mon, 6 Dec 2004 00:24:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] swsusp-bigdiff: power-managment changes that are waiting in my tree
Message-ID: <20041205232440.GA1490@elf.ucw.cz>
References: <20041205214910.GA1293@elf.ucw.cz> <1102284611.11763.97.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102284611.11763.97.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +#These are not really events sent:
> > +#
> > +#System fully on -- device is working normally; this is probably never
> > +#passed to suspend() method... event = ON, flags = 0
> > +#
> > +#Ready after resume -- userland is now running, again. Time to free any
> > +#memory you ate during prepare to suspend... event = ON, flags =
> > +#READY_AFTER_RESUME
> 
> I think we need to add the pm_message_t to resume. You are already
> "fixing" everybody to change u32 -> pm_message_t, so it  shouldn't be
> that bad to add this too.

We need to add pm_message_t to resume, I agree about that, but yes, it
would be quite bad if I added this, too.

All changes I'm doing are "break nothing", because pm_message_t is
typedefed to u32 for now. Therefore they can be safely merged in any
order etc...

For the documentation changes... I already rewrote that twice. I'm not
native english speaker and I need some sleep now. If you send me
nicely-looking diff, I'm likely to accept it :-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
