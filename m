Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272602AbTHEJRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272599AbTHEJRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:17:00 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:30619 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272610AbTHEJP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:15:59 -0400
Date: Tue, 5 Aug 2003 11:15:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] suspend.c cleanups
Message-ID: <20030805091529.GD388@elf.ucw.cz>
References: <20030726225809.GA528@elf.ucw.cz> <Pine.LNX.4.44.0308041758460.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041758460.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
> > +#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
> 
> This is not a cleanup, it changes behavior, so I didn't apply this first 
> part (since I had to make the other changes by hand anyway). 

Sorry for that.

> > @@ -906,7 +898,7 @@
> >  		return;
> >  
> >  	software_suspend_enabled = 0;
> > -	BUG_ON(in_interrupt());
> > +	BUG_ON(in_atomic());
> >  	do_software_suspend();
> >  }
> 
> I replaced the BUG() with might_sleep(), since it will produce a stack 
> trace, and is a bit friendlier. 

Yes, thats better.
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
