Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbULKRW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbULKRW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbULKRW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:22:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11964 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261971AbULKRWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:22:53 -0500
Date: Sat, 11 Dec 2004 18:22:03 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI -rc fixes for 2.6.10-rc3
Message-ID: <20041211172202.GD3033@suse.de>
References: <1102650988.3814.13.camel@mulgrave> <20041210201115.GD12581@suse.de> <41BA2948.4030906@osdl.org> <1102776407.5688.4.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102776407.5688.4.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11 2004, James Bottomley wrote:
> On Fri, 2004-12-10 at 14:55 -0800, Randy.Dunlap wrote:
> > I have a drive, but I'm not near a highmem machine atm.
> > I can test it next week if no one else does so.
> 
> So would you be amenable to fixing it properly?  It looks like what
> needs to happen is that it needs to accept its commands into the
> scsi_pointer with page and offset (scsi_pointer doesn't have these
> fields, but you could probably cast in ptr and dma_handle).  Then do a
> kmap/kunmap around imm_in() and imm_out() when it's operating on
> SCp.ptr.

Yep, that would be the optimal. But still, given the hardware, I feel
the hacky workaround would be acceptable. If Randy wants to fix it
properly being able to test it, perfect.

-- 
Jens Axboe

