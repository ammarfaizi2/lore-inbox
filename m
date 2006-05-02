Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWEBIJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWEBIJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWEBIJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:09:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:800 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932504AbWEBIJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:09:00 -0400
Date: Tue, 2 May 2006 10:09:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502080935.GS3814@suse.de>
References: <20060502075049.GA5000@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502075049.GA5000@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02 2006, Wu Fengguang wrote:
> I'd like to know whether the two proposed kernel components would be
> acceptable for the mainline kernel, and any recommends to improve them.

I tried something very similar to this years ago, except I made it
explicit instead of hiding it in the blk_run_backing_dev() which we
didn't have at that time. My initial results showed that you would get a
load of requests for different pages so would end up doing io randomly
instead again.

Your patch isn't exactly pretty, but that is fixable. I'm more
interested in how you'd control that sanely.

-- 
Jens Axboe

