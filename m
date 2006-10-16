Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWJPGCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWJPGCr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWJPGCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:02:46 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55747 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1030300AbWJPGCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:02:46 -0400
Date: Mon, 16 Oct 2006 08:02:27 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Neil Brown <neilb@suse.de>
Cc: vherva@vianova.fi, linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061016060227.GA3090@apps.cwi.nl>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <20061015082921.GC22674@vianova.fi> <17714.51511.845336.721450@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17714.51511.845336.721450@cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 09:50:15AM +1000, Neil Brown wrote:
> On Sunday October 15, vherva@vianova.fi wrote:

> > I wonder if there's ever a change the kernel partition detection code could
> > _write_ on the disk, even when there's really no partition table?
> 
> No, kernel partition detection never writes.

There is something else that writes, however, that I have gotten complaints about.
(But I have not investigated.)
People doing forensics take a copy of a disk and want to preserve
that copy as-is, never changing a single bit, only looking at it.
But it is reported that also when a partition is mounted read-only,
the journaling code of ext3 will write to the journal.

Andries
