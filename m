Return-Path: <linux-kernel-owner+w=401wt.eu-S965115AbWLUOhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWLUOhr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 09:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWLUOhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 09:37:47 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38941 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965047AbWLUOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 09:37:46 -0500
Date: Thu, 21 Dec 2006 17:36:21 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: jamal <hadi@cyberus.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061221143621.GA32706@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11666924573643@2ka.mipt.ru> <20061221103539.GA4099@2ka.mipt.ru> <458A64E5.4050703@garzik.org> <20061221104918.GA16744@2ka.mipt.ru> <1166708885.3749.49.camel@localhost> <20061221140429.GA25214@2ka.mipt.ru> <1166710867.3749.56.camel@localhost> <20061221142337.GA17204@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061221142337.GA17204@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 21 Dec 2006 17:36:27 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 05:23:37PM +0300, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> Ok, when site will be ready I will patch libevent and post patch or link
> in this thread. I plan to complete it this week.

Btw, it uses only read/write/signal on fd events, so it must use
->poll() and thus be as fast as epoll. 

Things like sockets/pipes can only benefit from direct kevent usage 
instead of ->poll() and wrappers.

-- 
	Evgeniy Polyakov
