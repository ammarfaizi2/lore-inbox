Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSKCQRP>; Sun, 3 Nov 2002 11:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSKCQRP>; Sun, 3 Nov 2002 11:17:15 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:7946 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262137AbSKCQRO>; Sun, 3 Nov 2002 11:17:14 -0500
Date: Sun, 3 Nov 2002 16:23:56 +0000
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Patch(2.5.45): move io_restrictions to blkdev.h
Message-ID: <20021103162356.GA2158@fib011235813.fsnet.co.uk>
References: <200211030848.AAA07537@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211030848.AAA07537@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:48:30AM -0800, Adam J. Richter wrote:
> 	Great.  The only thing I was going to do that might depend
> on this patch is try to port /dev/loop to device mapper, and I may
> be able to eliminate the affected code anyhow.

This makes me uneasy, do you mean you want to:

i) make a 'loop' target, if so why ?

ii) or that you want to rewrite loop so that it sits on top of dm -
    ie. you create a set of linear mappings that correspond to the
    file ?   This would only be sensible if there is significant
    simplification/reduction of the loop code, and probably would
    never work because of tail packing.

I'm not keen on either of these ideas.

- Joe
