Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTKONPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTKONPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:15:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23056 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261692AbTKONPJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:15:09 -0500
Date: Sat, 15 Nov 2003 08:04:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Pascal Schmidt <der.eremit@email.de>
cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311131413000.947-100000@neptune.local>
Message-ID: <Pine.LNX.3.96.1031115080315.2903B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Pascal Schmidt wrote:

> On Thu, 13 Nov 2003, Bill Davidsen wrote:
> 
> > For a read-only access, I think the size is what's written, while for
> > writing it's the physical size, I think. Does it need to be as complex as
> > having the order depend on the access mode? It seems that a size of zero
> > is correct for a read access to an unwritten media.
> 
> Well, there is only one capacity and we cannot tell at the time we
> fetch the capacity from the drive whether the user will use the disk
> read-only or read-write.
> 
> In any case, cdrom_read_capacity() is the only thing that works on my
> MO drive, the other methods all fail. So my patch from yesterday changes 
> the order of things so that read_capacity is used first to get the 
> capacity, and the other methods are allowed to override it's findings
> later on.

And that sounds like the correct thing to do.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

