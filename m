Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWHGXRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWHGXRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWHGXRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:17:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44955 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751030AbWHGXRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:17:44 -0400
Date: Tue, 8 Aug 2006 01:17:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807231728.GB2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com> <20060807162743.GA26224@atjola.homenet> <41840b750608070941i521fe56crebc491589a67cb59@mail.gmail.com> <20060807165452.GB26224@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807165452.GB26224@atjola.homenet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> >> +     struct dmi_device *dev = NULL;
> > >> >unneeded initializer.
> > >> On a local variable?!
> > >
> > >You assign a new value to it on the next line, without ever using its
> > >initial value.
> > 
> > The initial value is used in the last parameter to dmi_find_device():
> > 
> > 	struct dmi_device *dev = NULL;
> > 	while ((dev = dmi_find_device(type, NULL, dev))) {
> > 		if (strstr(dev->name, substr))
> > 			return 1;
> > 	}
> 
> Sorry, somehow my brain skipped the end of the line.

Ahha, sorry about that, I was blind, too. I thought it is because the
code is ugly, but now I see I was wrong.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
