Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWHHKJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWHHKJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWHHKJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:09:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62957 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964781AbWHHKJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:09:56 -0400
Date: Tue, 8 Aug 2006 12:09:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Message-ID: <20060808100938.GD4442@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <1154849246822-git-send-email-multinymous@gmail.com> <20060807140222.GG4032@ucw.cz> <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com> <20060807232415.GE2759@elf.ucw.cz> <41840b750608080216l58f56030v9c766427f8582f4c@mail.gmail.com> <20060808092133.GB4245@elf.ucw.cz> <41840b750608080306w584b7524v746c688fa3d58342@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608080306w584b7524v746c688fa3d58342@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >        /* Parse position data: */
> >        x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1);
> >        y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1);
> >        transform_axes(&x, &y);
> >
> >...which looks even better to me.
> 
> Yes, that's elegant.
> But it made me realize there's a race condition here (and and also in
> the mainline driver): the global pos_x, rest_x etc. could be updated
> while an attribute's show_* function is called. Ugh. I guess I need to
> sprinkle spinlocks all over the place.

They are simple integers... so yes, locking is needed, but I'd not
label it as critical. I guess you should get your series done, first.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
