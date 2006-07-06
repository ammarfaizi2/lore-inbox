Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWGFXwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWGFXwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWGFXwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:52:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46567 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751077AbWGFXwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:52:21 -0400
Date: Fri, 7 Jul 2006 01:52:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Create new LED trigger for CPU activity
Message-ID: <20060706235204.GB4821@elf.ucw.cz>
References: <20060706191603.GA13898@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706191603.GA13898@phoenix>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch creates a new LED trigger that triggers whenever the CPU is
> active.  It can be configured with module parameters to trigger on any
> combination of user, nice, system, or iowait time, and defaults to
> including user and system time but not nice or iowait time.  I've tested
> it a bit, and it seems to work, but no guarantees.  It's diffed against
> 2.6.17-git25.
> 
> Signed-off-by: Thomas Tuttle <thinkinginbinary@gmail.com>

I like the idea.. CPU usage led is very useful, and old led system
actually provided it. But...

> +/*
> + * ChangeLog:
> + *
> + * Revision 3 (2006/06/06):
> + *   Added module parameters to configure which time is counted as CPU
> + *     activity. (thanks to Andrew Morton)
> + *
> + * Revision 2 (2006/06/05):
> + *   Diffed against 2.6.17-git25 instead of 2.6.17.1.
> + *   Fixed several code style issues (thanks to Randy Dunlap)
> + *
> + * Revision 1 (2006/06/05):
> + *   Initial patch submitted.
> + */

Please don't include changelogs in sources.

> +#define UPDATE_INTERVAL (5) /* delay between updates, in ms */

Polling every 5 msec is going to cost _lot_ of juice. Is there a
better way?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
