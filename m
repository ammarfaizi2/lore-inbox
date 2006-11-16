Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161942AbWKPG7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161942AbWKPG7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161947AbWKPG7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:59:21 -0500
Received: from brick.kernel.dk ([62.242.22.158]:45375 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161942AbWKPG7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:59:20 -0500
Date: Thu, 16 Nov 2006 07:58:47 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Edward Falk <efalk@google.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Introduce block I/O performance histograms
Message-ID: <20061116065846.GE32394@kernel.dk>
References: <455BD7E8.9020303@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455BD7E8.9020303@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15 2006, Edward Falk wrote:
> This patch introduces performance histogram record keeping for block 
> I/O, used for performance tuning.  It is turned off by default.
> 
> When turned on, you simply do something like:
> 
> # cat /sys/block/sda/read_request_histo
> rows = bytes columns = ms
>         10      20      50      100     200     500     1000    2000
>    2048 5       0       0       0       0       0       0       0
>    4096 0       0       0       0       0       0       0       0
>    8192 17231   135     41      10      0       0       0       0
>   16384 4400    24      6       2       0       0       0       0
>   32768 2897    34      4       4       0       0       0       0
>   65536 7089    87      5       1       2       0       0       0

I don't see the point at all for including this piece of code in the
kernel. You can do the same from user space. Your help entry said it
even grows the kernel size about 21k, that's pretty nasty.

So NAK.

-- 
Jens Axboe

