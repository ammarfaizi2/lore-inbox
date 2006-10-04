Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030748AbWJDKMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030748AbWJDKMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030788AbWJDKMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:12:49 -0400
Received: from brick.kernel.dk ([62.242.22.158]:45109 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030748AbWJDKMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:12:48 -0400
Date: Wed, 4 Oct 2006 12:12:24 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH take2 0/5] dio: clean up completion phase of direct_io_worker()
Message-ID: <20061004101223.GF7778@kernel.dk>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net> <20061003152004.ca255c33.akpm@osdl.org> <4522EB94.1040708@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522EB94.1040708@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03 2006, Zach Brown wrote:
> > I trust a lot of testing was done on blocksize<pagesize filesystems?
> 
> I haven't, no.
> 
> > And did you test direct-io into and out of hugepages?
> 
> No, though..
> 
> > `odread' and `odwrite' from
> > http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz can be
> > used to test that.
> 
> .. I'll definitely give those a spin, thanks.
> 
> I'll see if I can get some real resources dedicated to collecting the N
> different piles of tests that are kicking around into something
> coherent.  It'll take a while, but I'm sure I'm not alone in being
> frustrated by this disorganized collaborative works-for-me approach.

fio can do most (all?) of this already, might be a good idea to create a
fio job file that has a proper range of regressions like tests for aio.

-- 
Jens Axboe

