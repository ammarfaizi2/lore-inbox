Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSIYH3f>; Wed, 25 Sep 2002 03:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbSIYH3f>; Wed, 25 Sep 2002 03:29:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62637 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261934AbSIYH3e>;
	Wed, 25 Sep 2002 03:29:34 -0400
Date: Wed, 25 Sep 2002 09:34:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Luben Tuikov <luben@splentec.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: struct page question
Message-ID: <20020925073430.GG15479@suse.de>
References: <3D90D4AB.B0BDF702@splentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D90D4AB.B0BDF702@splentec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24 2002, Luben Tuikov wrote:
> Is it possible to build a struct page *page, where
> page_address(page) == some virtual address (not high mem of course)?
> 
> The reason I want to do this is so that I can pass it to
> generic_make_request(), having only a pointer to a buffer
> and size to a buffer, and the fact that not all devices
> have request_fn() exposed (e.g. md).
> 
> Apparently I cannot just set b_data and b_size, b_page
> also has to be set and it also seems that it will
> not work if page_address(b_page) != b_data...

bh->b_page = virt_to_page(va);
bh->b_data = va;

-- 
Jens Axboe

