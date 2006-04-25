Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWDYW0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWDYW0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 18:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWDYW0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 18:26:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21657 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932131AbWDYW0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 18:26:08 -0400
Date: Wed, 26 Apr 2006 00:25:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Message-ID: <20060425222526.GG6379@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl> <200604252312.26249.rjw@sisk.pl> <200604260718.42681.nigel@suspend2.net> <200604260021.08888.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604260021.08888.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It does apply to all of the LRU pages. This is what I've been doing for years 
> > now. The only corner case I've come across is XFS. It still wants to write 
> > data even when there's nothing to do and it's threads are frozen (IIRC - 
> > haven't looked at it for a while). I got around that by freezing bdevs when 
> > freezing processes.
> 
> This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> except for the pages mapped by the current task, without copying.  I think we
> can try to do this, but we'll need a patch to freeze bdevs for this purpose. ;-)

...adding more dependencies to how vm/blockdevs work. I'd say current
code is complex enough...
							Pavel
-- 
Thanks for all the (sleeping) penguins.
