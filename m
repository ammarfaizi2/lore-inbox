Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTHZJ7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 05:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbTHZJ7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 05:59:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28100 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263557AbTHZJ67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 05:58:59 -0400
Date: Tue, 26 Aug 2003 11:58:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Samphan Raruenrom <samphan@nectec.or.th>, Jens Axboe <axboe@image.dk>,
       linux-kernel@vger.kernel.org, Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
Message-ID: <20030826095830.GA20693@suse.de>
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org> <3F4B23E2.8040401@nectec.or.th> <20030826105613.A23356@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826105613.A23356@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Christoph Hellwig wrote:
> On Tue, Aug 26, 2003 at 04:09:54PM +0700, Samphan Raruenrom wrote:
> > The only visible feature of this new magicdev is that now
> > GNOME users can eject there CDs (the discs' icon will
> > disappear). The eject button now act as 'umount' command.
> > 
> > One new requirement from this new magicdev is the question
> > "will umount failed?". I have no preference on any way to
> > implement it. Should there be the right way to do it, I'll
> > do so. I can think of many way to implement it (including
> > adding a new lazy-lock mode to cdrom device) but since
> > I have no kernel hacking experience, I need everyone
> > advices. Novice users need this 'eject' button after all.
> 
> This doesn't make sense at all.  Just try the unmount and
> tell the user if it failed - you can't say whether it will
> fail before trying.

Exactly. You poll media events from the drive, and upon an eject request
you try and umount it. If it suceeds, you eject the tray. It's pretty
simple, really.

This mount status patch is seriously broken and misguided.

-- 
Jens Axboe

