Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUC1Rl2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUC1RlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:41:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46532 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262272AbUC1RkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:40:21 -0500
Date: Sun, 28 Mar 2004 19:40:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328174013.GJ24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40670A36.3000005@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> Jamie Lokier wrote:
> >Jeff Garzik wrote:
> >
> >>TCQ-on-write for ATA disks is yummy because you don't really know what 
> >>the heck the ATA disk is writing at the present time.  By the time the 
> >>Linux disk scheduler gets around to deciding it has a nicely merged and 
> >>scheduled set of requests, it may be totally wrong for the disk's IO 
> >>scheduler.  TCQ gives the disk a lot more power when the disk integrates 
> >>writes into its internal IO scheduling.
> >
> >
> >Does TCQ-on-write allow you to do ordered write commits, as with barriers,
> >but without needing full cache flushes, and still get good performance?
> 
> Nope, TCQ is just a bunch of commands rather than one.  There are no 
> special barrier indicators you can pass down with a command.

What would be nice (and I seem to recall that Andre also pushed for
this) would be the FUA bit doubling as an ordered tag indicator when
using TCQ. It's one of those things that keep ATA squarely outside of
the big machine uses. That other OS had a differing opinion of what to
do with that, so...

-- 
Jens Axboe

