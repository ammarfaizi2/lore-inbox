Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUIOMnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUIOMnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUIOMnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:43:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7136 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264980AbUIOMnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:43:02 -0400
Date: Wed, 15 Sep 2004 14:41:25 +0200
From: Jens Axboe <axboe@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040915124124.GC4111@suse.de>
References: <20040913015003.5406abae.akpm@osdl.org> <20040915113635.GO9106@holomorphy.com> <20040915113833.GA4111@suse.de> <20040915122852.GQ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915122852.GQ9106@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, William Lee Irwin III wrote:
> On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> >>> +cfq-iosched-v2.patch
> >>>  Major revamp of the CFQ IO scheduler
> 
> On Wed, Sep 15 2004, William Lee Irwin III wrote:
> >> While editing some files while booted into 2.6.9-rc1-mm5:
> >> # ----------- [cut here ] --------- [please bite here ] ---------
> >> Kernel BUG at cfq_iosched:1359
> 
> On Wed, Sep 15, 2004 at 01:38:34PM +0200, Jens Axboe wrote:
> > Hmm, ->allocated is unbalanced. What is your io setup like (adapter,
> > etc)?
> 
> 2 Maxtor Atlas10K 10Krpm U320 disks attached to some aic7902's. No
> binary or 3rd-party modules anywhere near the box' fs or even the
> network the thing is on. lspci output follows.

Hmm, I can only see this happening if rq->flags has its direction bit
changed between the allocation time and the time of freeing. I'll look
over scsi and see if I can find any traces of that, don't see any
immediately.

-- 
Jens Axboe

