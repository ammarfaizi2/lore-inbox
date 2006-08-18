Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWHRKmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWHRKmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWHRKmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:42:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63172 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751355AbWHRKmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:42:07 -0400
Date: Fri, 18 Aug 2006 11:41:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>, tglx@linutronix.de
Subject: Re: [take9 2/2] kevent: poll/select() notifications. Timer notifications.
Message-ID: <20060818104120.GA20816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
	tglx@linutronix.de
References: <1155536496588@2ka.mipt.ru> <11555364962857@2ka.mipt.ru> <20060816133014.GB32499@infradead.org> <20060816134032.GB4314@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816134032.GB4314@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 05:40:32PM +0400, Evgeniy Polyakov wrote:
> > What speaks against a patch the recplaces the epoll core by something that
> > build on kevent while still supporting the epoll interface as a compatibility
> > shim?
> 
> There is no problem from my side, but epoll and kevent_poll differs on
> some aspects, so it can be better to not replace them for a while.

Please explain the differences and why they are important.  We really
shouldn't keep on adding code without beeing able to replace older bits.
If there's a really good reason we can keep things separate, but

  "epoll and kevent_poll differs on some aspects"

is not one :)

