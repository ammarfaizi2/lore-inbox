Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTJQSGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTJQSGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:06:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56712 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263415AbTJQSGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:06:13 -0400
Date: Fri, 17 Oct 2003 20:06:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031017180612.GB8230@suse.de>
References: <3F902E0A.5060908@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F902E0A.5060908@colorfullife.com>
X-OS: Linux 2.4.22aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17 2003, Manfred Spraul wrote:
> Jens wrote:
> 
> >The problem is that as far as I can see the best way to make fsync
> >really work is to make the last write a barrier write. That
> >automagically gets everything right for you - when the last block goes
> >to disk, you know the previous ones have already. And when the last
> >block completes, you know the whole lot is on platter.
> >
> Are you sure?
> What prevents the io scheduler from writing the last block before other 
> blocks?

Very sure, the io scheduler will never put the barrier write before
previously comitted writes. So yes, it will work as described.

Jens

