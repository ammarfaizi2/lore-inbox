Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbULBOmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbULBOmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbULBOmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:42:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261639AbULBOmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:42:15 -0500
Date: Thu, 2 Dec 2004 15:41:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041202144129.GI10458@suse.de>
References: <20041202130457.GC10458@suse.de> <Pine.LNX.4.58.0412021517070.3471@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412021517070.3471@denise.shiny.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02 2004, Giuliano Pochini wrote:
> 
> 
> On Thu, 2 Dec 2004, Jens Axboe wrote:
> 
> > Case 4: write_files, random, bs=4k
> 
> Just a thought... in this test the results don't look right. Why
> aggregate bandwidth with 8 clients is higher than with 4 and 2 clients ?
> In the cfq test with 8 clients aggregate bw is also higher than with
> a single client.

I don't know what happens with the 4 client case, but it's not that
unlikely that aggregate bandwidth will be higher for more threads doing
random writes, as request coalesching will help minimize seeks.

But I did think it was strange with the 4 client case dip was strange,
it was reproducable though (as are all the results, they have very
little variance).

-- 
Jens Axboe

