Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265345AbUBAP20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUBAP2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:28:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61393 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265350AbUBAP1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:27:53 -0500
Date: Sun, 1 Feb 2004 16:27:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan <alan@clueserver.org>
Cc: linux-kernel@vger.kernel.org, Mans Matulewicz <cybermans@xs4all.nl>
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
Message-ID: <20040201152742.GH11683@suse.de>
References: <1075511134.5412.59.camel@localhost> <20040131093438.GS11683@suse.de> <401BF122.2090709@blue-labs.org> <20040131184923.GD11683@suse.de> <1075623865.26031.9.camel@zontar.clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075623865.26031.9.camel@zontar.clueserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01 2004, Alan wrote:
> On Sat, 2004-01-31 at 10:49, Jens Axboe wrote:
> > On Sat, Jan 31 2004, David Ford wrote:
> > > I don't have an RW, but when my cdrom fixates, it stalls everything 
> > > while it's fixating.  I have an nForce chipset.  (2.6.x)
> > 
> > Does "everything" mean everything on that ide channel? If so, then
> > that's a hardware limitation.
> 
> I have seen the problem as well.
> 
> It is not just processes using the IDE.  Everything will pause for a
> second or two. (Which causes grief with streaming audio running at the
> same time.)

One process can easily stall the other, if they end up waiting on some
resource. Might not always happen, but easily can.

> Even more annoying is that it does not always occur. I have not tried
> tracking down where the kernel is getting hung up at that moment since
> it has been fairly intermittent for me.

There's not much you can do about it - you may want to try -immed as
mentioned earlier in this thread.

-- 
Jens Axboe

