Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSFMKzO>; Thu, 13 Jun 2002 06:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSFMKzN>; Thu, 13 Jun 2002 06:55:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17361 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317568AbSFMKzN>;
	Thu, 13 Jun 2002 06:55:13 -0400
Date: Thu, 13 Jun 2002 12:53:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@suse.de>, Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.21] compile error
Message-ID: <20020613105359.GX1117@suse.de>
In-Reply-To: <20020611213324.19589.qmail@linuxmail.org> <20020612012904.B30504@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12 2002, Dave Jones wrote:
> On Wed, Jun 12, 2002 at 05:33:24AM +0800, Paolo Ciarrocchi wrote:
>  > Hi all,
>  > I've just tried to compile the 2.5.21,
>  > but I got these errors:
>  > 
>  >    ataraid.c:101: dereferencing pointer to incomplete type
> 
> Old news. ataraid hasn't been touched since the block layer
> first started getting mangling in 2.5, and hence needs quite
> a bit of work.

I've fixed the ataraid stuff + hpt and pdc, however it needs two pieces
of infrastructure that are currently missing (independent bi_voffset so
we don't screw with the bio_vec->bv_offset members, and a nice bio_split
interface (currently done with bio_clone + driver mess)).

I'll post it soon.

-- 
Jens Axboe

