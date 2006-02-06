Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWBFOYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWBFOYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWBFOYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:24:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23957 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751056AbWBFOYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:24:47 -0500
Date: Mon, 6 Feb 2006 15:24:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, Rafael Wysocki <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206142432.GA1675@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz> <200602062213.24735.nigel@suspend2.net> <20060206124034.GH4101@elf.ucw.cz> <20060206125035.GT13598@suse.de> <20060206125253.GJ4101@elf.ucw.cz> <20060206130442.GV13598@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206130442.GV13598@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > well, we can perfectly do 128K block... just read 128K into userspace
> > buffer, flush it via single write to block device. That should get us
> > very close enough to media speed.
> 
> That'll help naturally, 128k sync blocks will be very close to async
> performance for most cases. Most cases here being drives with write back
> caching enabled, if that is disabled async will still be a big win.
> 
> Is there any reason _not_ to just go with async io? Usually the code is
> just as simple (or simpler), since the in-kernel stuff is inherently
> async to begin with.

Keeping it simple... when we are moving to doing writeback in
userland, anyway.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
