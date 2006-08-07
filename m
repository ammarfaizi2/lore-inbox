Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWHGX0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWHGX0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHGX0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:26:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15555 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932338AbWHGX0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:26:44 -0400
Date: Tue, 8 Aug 2006 01:26:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060807232625.GG2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-08-07 19:30:55, Shem Multinymous wrote:
> Hi Pavel,
> 
> On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> >> +     int total, ret;
> >> +     for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
> >
> >Could we go from 0 to timeout, not the other way around?
> 
> Sure.
> (That's actually vanilla hdapsd code, moved around...)

Thanks for cleaning it up :-).

> >This actually changes userland interface... but that is probably okay.
> 
> Those two sysfs attributes were bogus. If anything used them (which I
> very much doubt), it's a good thing we broke it.

Okay, just make sure you note this in the changelog.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
