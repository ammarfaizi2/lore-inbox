Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753513AbWKVLtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbWKVLtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbWKVLtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:49:06 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:26786 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1753250AbWKVLtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:49:01 -0500
Date: Wed, 22 Nov 2006 14:47:23 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, Jeff Garzik <jeff@garzik.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122114723.GA15957@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <45622228.80803@garzik.org> <456223AC.5080400@redhat.com> <456436CA.7050809@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <456436CA.7050809@tls.msk.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 14:47:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 02:38:50PM +0300, Michael Tokarev (mjt@tls.msk.ru) wrote:
> Ulrich Drepper wrote:
> > Jeff Garzik wrote:
> >> I think we have lived with relative timeouts for so long, it would be
> >> unusual to change now.  select(2), poll(2), epoll_wait(2) all take
> >> relative timeouts.
> > 
> > I'm not talking about always using absolute timeouts.
> > 
> > I'm saying the timeout parameter should be a struct timespec* and then
> > the flags word could have a flag meaning "this is an absolute timeout".
> >  I.e., enable both uses,, even make relative timeouts the default. This
> > is what the modern POSIX interfaces do, too, see clock_nanosleep.
> 
> 
> Can't the argument be something like u64 instead of struct timespec,
> regardless of this discussion (relative vs absolute)?

It is right now :)

> /mjt

-- 
	Evgeniy Polyakov
