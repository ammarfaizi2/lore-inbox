Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSBYNMz>; Mon, 25 Feb 2002 08:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293401AbSBYNMq>; Mon, 25 Feb 2002 08:12:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16141 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S293400AbSBYNMk>;
	Mon, 25 Feb 2002 08:12:40 -0500
Date: Mon, 25 Feb 2002 14:12:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Stephen Lord <lord@sgi.com>
Cc: Andrew Morton <akpm@zip.com.au>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020225131218.GO11837@suse.de>
In-Reply-To: <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au> <3C7A35FF.5040508@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7A35FF.5040508@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25 2002, Stephen Lord wrote:
> Andrew Morton wrote:
> 
> >
> >
> >Unfortunately I seem to have found a bug in existing ext2, a bug
> >in existing block_write_full_page, a probable bug in the aic7xxx
> >driver, and an oops in the aic7xxx driver.  So progress has slowed
> >down a bit :(
> >
> 
> Try this for the aic driver:

Steve,

DaveM's alternate fix has been in the 2.4 and 2.5 kernels for some time,
so given that Andrew is testing 2.5.5 this can't be the problem.

> We hit this once bio got introduced and we maxed out the request size
> for the driver. Justin has the  code in his next aic version.

Just for the record, this was/is not a bio bug, it was an aic7xxx bug
that could trigger with or without bio.

-- 
Jens Axboe

