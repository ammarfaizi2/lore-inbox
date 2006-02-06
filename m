Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWBFNos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWBFNos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWBFNos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:44:48 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:8875 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932109AbWBFNor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:44:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 6 Feb 2006 14:45:55 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <nigel@suspend2.net>,
       linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060206125253.GJ4101@elf.ucw.cz> <20060206130442.GV13598@suse.de>
In-Reply-To: <20060206130442.GV13598@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061445.55966.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 06 February 2006 14:04, Jens Axboe wrote:
> On Mon, Feb 06 2006, Pavel Machek wrote:
> > > > I'll get same bandwidth as you, without need for async I/O. Async I/O
> > > > is not really a feature, suspend speed is. (There are existing
> > > > interfaces for doing AIO from userspace, anyway, but I'm pretty sure
> > > > they will not be needed
> > > 
> > > If you keep writing single pages sync, you sure as hell wont get
> > > anywhere near async io in speed...
> > 
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

Actually the userland tools we're working on use async I/O.  [There's no real
need for sync, I think.]  Still we write one page at a time, for now, so the
I/O performance is not that much better than for the built-in swsusp, but it
_is_ better.

Greetings,
Rafael
