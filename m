Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030661AbWHIKbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030661AbWHIKbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbWHIKbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:31:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23219 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030661AbWHIKbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:31:33 -0400
Date: Wed, 9 Aug 2006 12:31:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Message-ID: <20060809103120.GI3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091158.38458.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Introduce the memory bitmap data structure and make swsusp use in the suspend
> phase.
> 
> The current swsusp's internal data structure is not very efficient from the
> memory usage point of view, so it seems reasonable to replace it with a data
> structure that will require less memory, such as a pair of bitmaps.

Well, 500 lines of code  for what... 0.25% bigger image? I see it
enables you to do some cleanups... but could we get those cleanups
without those 500 lines? :-).


>  kernel/power/power.h    |    3 
>  kernel/power/snapshot.c |  605 ++++++++++++++++++++++++++++++++++++++++++------
>  kernel/power/swsusp.c   |    5 
>  3 files changed, 542 insertions(+), 71 deletions(-)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
