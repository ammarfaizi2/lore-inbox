Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRLBKYm>; Sun, 2 Dec 2001 05:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRLBKYb>; Sun, 2 Dec 2001 05:24:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49678 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273261AbRLBKYM>;
	Sun, 2 Dec 2001 05:24:12 -0500
Date: Sun, 2 Dec 2001 11:23:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: PCI scatter gather list change
Message-ID: <20011202112351.K25987@suse.de>
In-Reply-To: <20011202153553.B5130@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011202153553.B5130@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02 2001, Anton Blanchard wrote:
> 
> Hi Jens,
> 
> I got 2.5 booting on ppc64 today and noticed that the behaviour of 
> sglists has changed. Before we would get an array of sg->address,
> sg->length pairs, we now get sg->page, sg->offset, sg->length triplets
> (from blk_rq_map_sg).
> 
> I dont care too much either way, but if this change is here to stay I'll
> let the non intel maintainers know so they can fix up their pci dma
> code.

The change is here to stay, the ->address stuff will die in 2.5.
Consider highmem pages which have no virtual mapping.

-- 
Jens Axboe

