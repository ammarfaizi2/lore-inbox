Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWBGHUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWBGHUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWBGHUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:20:24 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:14514 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964985AbWBGHUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:20:23 -0500
Date: Tue, 7 Feb 2006 09:20:13 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH] block: undeprecate ll_rw_block()
In-Reply-To: <20060206210705.GC5276@suse.de>
Message-ID: <Pine.LNX.4.58.0602070909370.25555@sbz-30.cs.Helsinki.FI>
References: <1139254591.17774.5.camel@localhost> <20060206210705.GC5276@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2006, Pekka Enberg wrote:
> > This patch removes the DEPRECATED comment from ll_rw_block(). The function
> > is still in active use and there isn't any real replacement for it.

On Mon, 6 Feb 2006, Jens Axboe wrote:
> It is still deprecated, so I think the comment should stay. There are
> plenty ways to accomplish what ll_rw_block does (and more efficiently,
> array of bh's is not very nice to say the least) and the buffer_head
> isn't even an io unit anymore.

To clarify, what ways are there? When we need to access the data, use 
submit_bh() and when we just want the I/O to be done, generic_make_request()?

			Pekka
