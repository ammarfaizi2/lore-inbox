Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbRE3QlN>; Wed, 30 May 2001 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbRE3QlD>; Wed, 30 May 2001 12:41:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50962 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261550AbRE3Qkz>;
	Wed, 30 May 2001 12:40:55 -0400
Date: Wed, 30 May 2001 18:40:47 +0200
From: Jens Axboe <axboe@kernel.org>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy NBD
Message-ID: <20010530184047.J17136@suse.de>
In-Reply-To: <200105301639.RAA21383@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105301639.RAA21383@gw.chygwyn.com>; from steve@gw.chygwyn.com on Wed, May 30, 2001 at 05:39:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Steve Whitehouse wrote:
> +	if (PageHighMem(page))
> +		offset = (int)bh->b_data;
> +	else
> +		offset = (int)bh->b_data - (int)page_address(page);

Side note:

	offset = bh_offset(bh);

will handle this nicely for you. No need for (nasty) casting and
checking for highmem pages.

-- 
Jens Axboe

