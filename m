Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWHILwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWHILwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWHILwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:52:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:958 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1160999AbWHILwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:52:15 -0400
Date: Wed, 9 Aug 2006 13:51:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 3/5] swsusp: Fix handling of highmem
Message-ID: <20060809115145.GT3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091209.03695.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091209.03695.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Make swsusp handle highmem pages similarly to the pages of the "normal"
> memory.

Is it feasible to create kernel/power/highmem.c?

>  include/linux/suspend.h |    6 
>  kernel/power/power.h    |    2 
>  kernel/power/snapshot.c |  822 ++++++++++++++++++++++++++++++++++++------------
>  kernel/power/swap.c     |    2 
>  kernel/power/swsusp.c   |   53 +--
>  kernel/power/user.c     |    2 
>  mm/vmscan.c             |    3 
>  7 files changed, 658 insertions(+), 232 deletions(-)

+400 lines for highmem... I hope highmem dies, dies, dies. Anyway, I'd
hate to debug this at the same time as the bitmap code. Can we get the
bitmaps in, wait for a while, and only then change highmem handling?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
