Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUFOUjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUFOUjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUFOUjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:39:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:646 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265943AbUFOUie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:38:34 -0400
Date: Tue, 15 Jun 2004 22:38:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Nigel Rantor <wiggly@wiggly.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom ripping / dropping to dingle frame dma
Message-ID: <20040615203828.GA12504@suse.de>
References: <40CF594C.30109@wiggly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CF594C.30109@wiggly.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2004, Nigel Rantor wrote:
> 
> Hi all,
> 
> Sorry if this is a completely redundant post but I have not been 
> subscribed recently and missed the thread on this.
> 
> I have had cdparanoia ripping blank sound off of my cdrom, looking in 
> the syslog gives the following just before stuff goes weird.
> 
> kernel: cdrom: dropping to single frame dma
> 
> Whilst trying to find others with the same problem I have seen an 
> archived LKML thread where Jens Axboe provided a patch against 2.6.4-rc1
> 
> I am currently running 2.6.5 and am wondering if this patch made it in 
> or not, and if not, where I can grab it from.
> 
> Alternatively, if this patch should be in 2.6.5 then I have a machine 
> that still fails with it, if so I'll be happy to post system specs etc 
> and try to find a test CD that exhibits the problem for testing.

It did not, and it didn't fix the issue completely. My plan is to add a
counter just checking if we succeeded doing some dma ripping already,
in which case there's no point to falling back to lesser methods. That
should be way more reliable than checking sense and making up our on
rules based on that.

I'll get a patch out tomorrow.

-- 
Jens Axboe

