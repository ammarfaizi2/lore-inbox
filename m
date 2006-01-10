Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWAJPCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWAJPCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWAJPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:02:42 -0500
Received: from cabal.ca ([134.117.69.58]:6813 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751096AbWAJPCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:02:41 -0500
Date: Tue, 10 Jan 2006 10:01:41 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, carlos@parisc-linux.org, willy@parisc-linux.org,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [PATCH 1/5] Add generic compat_siginfo_t
Message-ID: <20060110150141.GE28306@quicksilver.road.mcmartin.ca>
References: <20060108193755.GH3782@tachyon.int.mcmartin.ca> <20060109141355.GA22296@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109141355.GA22296@lst.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 03:13:55PM +0100, Christoph Hellwig wrote:
> -mm already has a much better implementation for compat_sys_timer_create
> that doesn't require all the sigevent churn in this patch (which btw
> doesn't seem to be mentioned in the changelog at all).  

Ok, I see it in -mm now, and it does seem to be nicer code, I'll
try it out on parisc64.

> But even with
> that remove there seems to be a lot of useless ifdef and indirection
> in this patch.  

I agree, I'm really just trying to shepard this home so we don't have
to maintain it out of tree. I'm not overly attached to the code, if
I can make parisc64 work with your compat signal bits, I'll be
just as happy.

The one thing from this patchset I'd like to keep is the is_compat_task()
as it does provide nice cleanups 

Cheers, Kyle

> Over the next days I'll send out my generic compat
> singal bits which don't require all this, but otoh require every
> architecture to supply helpers.  If you can make those generic without
> all the ifdef an additional header bits all power to you!
