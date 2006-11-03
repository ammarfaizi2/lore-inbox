Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWKCJSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWKCJSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 04:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbWKCJSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 04:18:37 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51919 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751067AbWKCJSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 04:18:36 -0500
Date: Fri, 3 Nov 2006 12:16:45 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: zhou drangon <drangon.mail@gmail.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
       Oleg Verych <olecom@flower.upol.cz>, Pavel Machek <pavel@ucw.cz>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, drangon.zhou@gmail.com
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061103091645.GA935@2ka.mipt.ru>
References: <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com> <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com> <4549A261.9010007@cosmosbay.com> <aaf959cb0611021842m2a4e73d9w874f6334d4d9a25a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <aaf959cb0611021842m2a4e73d9w874f6334d4d9a25a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 03 Nov 2006 12:16:48 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 10:42:04AM +0800, zhou drangon (drangon.mail@gmail.com) wrote:
> As for the VFS system, when we introduce the AIO machinism, we add aio_read,
> aio_write, etc... to file ops, and then we make the read, write op to
> call aio_read,
> aio_write, so that we only remain one implement in kernel.
> Can we do event machinism the same way?
> when kevent is robust enough, can we implement epoll/select/io_submit etc...
> base on kevent ??
> In this way, we can simplified the kernel, and epoll can gain
> improvement from kevent.

There is AIO implementaion on top of kevent, although it was confirmed
that it has a good design, except minor API layering changes, it was
postponed for a while.

-- 
	Evgeniy Polyakov
