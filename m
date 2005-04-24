Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVDXUWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVDXUWw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVDXUWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:22:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18316 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262404AbVDXUWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:22:46 -0400
Date: Sun, 24 Apr 2005 22:22:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
Message-ID: <20050424202230.GC30088@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232338.43297.rjw@sisk.pl> <20050423220757.GD1884@elf.ucw.cz> <426B7B97.4030009@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426B7B97.4030009@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> The following patch makes some comments and printk()s in swsusp.c up to date.
> >> In particular it adds the string "swsusp" before every message that is printed by
> >> the code in swsusp.c.
> > 
> > I don't like this one. Adding swsusp everywhere just clutters the
> > screen, most of it should be clear from context.
> 
> I like it. The messages are short enough so we should not get line wraps
> and it makes stuff more clear. You know, the context is not familiar to
> everyone, just imagine the "why do we {suspend,resume} devices during
> {resume,suspend} questions.
> 
> Also, i can ask for "send me output of dmesg|grep ^swsusp" to avoid
> newbies flooding me with totally irrelevant info ;-)

That would not work, anyway. You want the messages from drivers,
too... and drivers are not going to prepend "swsusp".

Ultimately, cleaning up "suspend screen" so that it is not too scary
for non-technical users might be nice... It means killing some debug
messages from drivers, too.

					 			Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
