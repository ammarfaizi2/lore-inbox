Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbSIZF2K>; Thu, 26 Sep 2002 01:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262192AbSIZF2K>; Thu, 26 Sep 2002 01:28:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16571 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262191AbSIZF2K>;
	Thu, 26 Sep 2002 01:28:10 -0400
Date: Thu, 26 Sep 2002 07:33:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Luben Tuikov <luben@splentec.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: struct page question
Message-ID: <20020926053309.GD8665@suse.de>
References: <3D90D4AB.B0BDF702@splentec.com> <20020925073430.GG15479@suse.de> <3D922313.24B59088@splentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D922313.24B59088@splentec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25 2002, Luben Tuikov wrote:
> Jens Axboe wrote:
> > 
> > > Apparently I cannot just set b_data and b_size, b_page
> > > also has to be set and it also seems that it will
> > > not work if page_address(b_page) != b_data...
> > 
> > bh->b_page = virt_to_page(va);
> > bh->b_data = va;
> 
> Thanks Jens again.
> 
> My doubts are that va might not point to page->virtual,
> but may point ``in the middle'' of the page, in which case
> md will cough up since it does the page_address(b_page) != b_data
> then BUG()...

It's quite legal for b_data to point to somewhere in the middle of the
page. See usage of bh_offset(). What coughs up and where?

-- 
Jens Axboe

