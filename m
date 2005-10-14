Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVJNGwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVJNGwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 02:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVJNGwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 02:52:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10325 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750771AbVJNGwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 02:52:44 -0400
Date: Fri, 14 Oct 2005 08:53:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexander Viro <aviro@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: BLKSECTGET userland API breakage (2.4 and 2.6 incompatible)
Message-ID: <20051014065302.GP6603@suse.de>
References: <20051013234934.GB6711@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013234934.GB6711@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, Alexander Viro wrote:
> [that had started as "BLKSECTGET 32bit compat is broken"]
> 
> Situation:
> 
> all 2.4:      BLKSECTGET takes long * and is supported by several block drivers
> bio-14-pre9:  Takes BLKSECTGET to drivers/block/blkpg.c, defining it for all
>               block drivers *AND* making it take unsigned short *
> 2.5.1-pre2:   bio merge
> all 2.[56] kernels since then: BLKSECTGET takes unsigned short *
> 32bit compat: unchanged since 2.4 and thus broken on 2.[56]
> applications: we have seen ones using 2.6 ABI and getting buggered in
>               32bit compat.  Most likely there are some using 2.4 ABI...

Unfortunate situation :(

> IMO the least painful variant is to switch 2.6 compat code to match
> 2.6 native (i.e. use COMPATIBLE_IOCTL()), leave 2.4 as-is and live
> with the fact of userland ABI change between 2.4 and 2.6...

Agree.

-- 
Jens Axboe

