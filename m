Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWB0Lby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWB0Lby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWB0Lbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:31:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26166 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751198AbWB0Lbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:31:53 -0500
Date: Mon, 27 Feb 2006 12:20:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: neilb@suse.de
Subject: Re: Linux v2.6.16-rc5
Message-ID: <20060227112022.GK12886@suse.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227072844.GA15638@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227072844.GA15638@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27 2006, Dave Jones wrote:
> On Sun, Feb 26, 2006 at 09:27:28PM -0800, Linus Torvalds wrote:
> 
>  > Have I missed anything? Holler. And please keep reminding about any 
>  > regressions since 2.6.15.
> 
> We seem to have a nasty bio slab leak.
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=183017
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182970
> 
> Two seperate reports, both using raid1, sata_via and firewire
> Curiously, they're both on x86-64 too.
> 
> Will keep an eye open for other reports of this as they come in.
> 
> (The kernels they mention in those reports are fairly recent.
>  2.6.15-1.1977_FC5 is ctually based on 2.6.16rc4-git6)

This smells very much like a raid1 bio leak, I thought Neil had
diagnosed and fixed that already though - Neil?

-- 
Jens Axboe

