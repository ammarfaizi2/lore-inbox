Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWG0IL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWG0IL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWG0IL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:11:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28202 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750792AbWG0IL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:11:28 -0400
Date: Thu, 27 Jul 2006 10:11:15 +0200
From: Jens Axboe <axboe@suse.de>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, drepper@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060727081114.GH5282@suse.de>
References: <20060726062817.GA20636@2ka.mipt.ru> <20060726.231055.121220029.davem@davemloft.net> <20060727074902.GC5490@2ka.mipt.ru> <20060727.010255.87351515.davem@davemloft.net> <20060727080901.GG5282@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727080901.GG5282@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27 2006, Jens Axboe wrote:
> On Thu, Jul 27 2006, David Miller wrote:
> > From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > Date: Thu, 27 Jul 2006 11:49:02 +0400
> > 
> > > I.e. map skb's data to userspace? Not a good idea especially with it's
> > > tricky lifetime and unability for userspace to inform kernel when it
> > > finished and skb can be freed (without additional syscall).
> > 
> > Hmmm...
> > 
> > If it is paged based, I do not see the problem.  Events and calls to
> > AIO I/O routines make transfer of buffer ownership.  The fact that
> > while kernel (and thus networking stack) "owns" the buffer for an AIO
> > call, the user can have a valid mapping to it is a unimportant detail.
> 
> Ownership may be clear, but "when can I reuse" is tricky. The same issue
> comes up for vmsplice -> splice to socket.

Ownership transition from user -> kernel that is, what I'm trying to say
that returning ownership to the user again is the tricky part.

-- 
Jens Axboe

