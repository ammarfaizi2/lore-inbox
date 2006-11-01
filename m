Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992670AbWKAQxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992670AbWKAQxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992675AbWKAQxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:53:14 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:13785 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S2992670AbWKAQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:53:12 -0500
Date: Wed, 1 Nov 2006 19:24:03 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061101162403.GA29783@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <1162380963981@2ka.mipt.ru> <20061101130614.GB7195@atrey.karlin.mff.cuni.cz> <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061101160551.GA2598@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Wed, 01 Nov 2006 19:40:37 +0300 (MSK)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 01 Nov 2006 19:25:23 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 05:05:51PM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> Hi!

Hi Pavel.

> > Kevent is a generic subsytem which allows to handle event notifications.
> > It supports both level and edge triggered events. It is similar to
> > poll/epoll in some cases, but it is more scalable, it is faster and
> > allows to work with essentially eny kind of events.
> 
> Quantifying "how much more scalable" would be nice, as would be some
> example where it is useful. ("It makes my webserver twice as fast on
> monster 64-cpu box").

Trivial kevent web-server can handle 3960+ req/sec on Xeon 2.4Ghz with
1Gb RAM, epoll based - 2200-2500 req/sec.
100 Mbit wire is filled almost 100% (10582.7 KB/s of data without
TCP and below headers).
More benchmarks created by me and Johann Borck can be found on project's 
homepage as long as all my sources used in tests.

-- 
	Evgeniy Polyakov
