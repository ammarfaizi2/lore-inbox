Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWHHJjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWHHJjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHHJjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:39:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32457 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932172AbWHHJjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:39:42 -0400
Date: Tue, 8 Aug 2006 11:39:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060808093923.GD4245@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com> <20060807231557.GA2759@elf.ucw.cz> <41840b750608080223q3e00370bsaf9893dcac57c8a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608080223q3e00370bsaf9893dcac57c8a6@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Okay... but do we really need try_lock variant?
> 
> We need a nonlocking, nonsleeping variant to do the query in the timer
> function (softirq context).
> 
> >but what is try_lock semantics when taking multiple locks...?
> 
> Currently, the same as the undelying down_trylock().

Okay, I guess this works for me.

> >Well, this will also trigger for thinkpad module compiled into kernel,
> >right?
> 
> OK, I'm changing the DMI failure to KERN_WARNING. Subsequent hardware
> checks remains KERN_ERR, since failing those after passing the DMI
> check really is abnormal (and indicative of danger).

Yep, that sounds correct.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
