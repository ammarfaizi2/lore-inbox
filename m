Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754426AbWKHIXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbWKHIXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbWKHIXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:23:06 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52133 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754426AbWKHIXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:23:04 -0500
Date: Wed, 8 Nov 2006 11:21:48 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
Message-ID: <20061108082147.GA2447@2ka.mipt.ru>
References: <1154985aa0591036@2ka.mipt.ru> <11629182482886@2ka.mipt.ru> <20061107141718.f7414b31.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061107141718.f7414b31.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 08 Nov 2006 11:21:49 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 02:17:18PM -0800, Andrew Morton (akpm@osdl.org) wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> If kevent_user_wait() gets -EFAULT on the attempt to copy the first event, it
> will return 0, which is indistinguishable from "no events pending".
> 
> It can and should return EFAULT in this case.

Correct, I missed that.
Thanks Andrew, I will put into my tree, -mm seems to have it already.

-- 
	Evgeniy Polyakov
