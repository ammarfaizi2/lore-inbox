Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbVKBVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbVKBVJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVKBVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:09:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25527 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965243AbVKBVJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:09:19 -0500
Date: Wed, 2 Nov 2005 22:08:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051102210843.GF23943@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200511011929.20073.rjw@sisk.pl> <20051101210452.GH7172@elf.ucw.cz> <200511020053.25123.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511020053.25123.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That depends on how you implement the interface.  If you insist on using
> > > ioctls then yes, it's ugly.  However, if it is a file in sysfs, for example,
> > > then you have well-defined open(), close(), read() and write() operations
> > > and it is assumed you will keep some context accross eg. write()s.
> > 
> > I was trying to keep kernel code simple. Yes, if we do it sysfs based,
> > that's probably not a problem. I'm not sure if nice sysfs interface
> > can be done without excessive ammount of code.
> 
> I'm not sure either, but I'm going to try.

Ok, I'm looking forward. We still have my ugly ioctls as a fallback :-).

> Still first I'd like to make swsusp free only as much memory as needed
> and not as much as possible which should improve its performance
> quite a bit.

Yes, I'd like that patch in. It will make many people happy.
								Pavel
-- 
Thanks, Sharp!
