Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVKAVFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVKAVFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVKAVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:05:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751223AbVKAVFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:05:35 -0500
Date: Tue, 1 Nov 2005 22:04:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051101210452.GH7172@elf.ucw.cz>
References: <200510301637.48842.rjw@sisk.pl> <200510310135.42190.rjw@sisk.pl> <20051031215938.GB14877@elf.ucw.cz> <200511011929.20073.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011929.20073.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Oh, it can be done on-the-fly in
> > > sys_put_this_stuff_where_appropriate(image data) (at the expense of one
> > > redundant check per call).
> > 
> > Yes, but it is still ugly, as you keep some context across the
> > syscalls.
> 
> That depends on how you implement the interface.  If you insist on using
> ioctls then yes, it's ugly.  However, if it is a file in sysfs, for example,
> then you have well-defined open(), close(), read() and write() operations
> and it is assumed you will keep some context accross eg. write()s.

I was trying to keep kernel code simple. Yes, if we do it sysfs based,
that's probably not a problem. I'm not sure if nice sysfs interface
can be done without excessive ammount of code.
								Pavel
-- 
Thanks, Sharp!
