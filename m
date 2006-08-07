Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWHGOOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWHGOOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHGOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:14:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34578 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932114AbWHGOOA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:14:00 -0400
Date: Mon, 7 Aug 2006 14:11:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/12] hdaps: Remember keyboard and mouse activity
Message-ID: <20060807141120.GI4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492613229-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492613229-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When the current hdaps driver is queried for recent keyboard/mouse activity
> (which is provided by the hardware for use in disk parking daemons), it
> simply returns the last readout. However, every hardware query resets the
> activity flag in the hardware, and this is triggered by (almost) any
> hdaps sysfs attribute read, so the flag could be reset before it is 
> observed and is thus nearly useless.
> 
> This patch makes the activities flags persist for 0.1sec, by remembering
> when was the last time we saw them set. This gives apps like the hdaps
> daemon enough time to poll the flag.

Should we perhaps remember time of last activity instead of 0/1? Aha,
that is how it is implemented, but would not time value be better
userland interface, too?

Ok... changing userland interface should be separate patch, anyway.
And should not hdapsd get it from input interface?

Signed-off-by: Pavel Machek <pavel@suse.cz>


-- 
Thanks for all the (sleeping) penguins.
