Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUC1UV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUC1UV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:21:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262441AbUC1UVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:21:53 -0500
Message-ID: <406733D1.2060009@pobox.com>
Date: Sun, 28 Mar 2004 15:21:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <20040328140807.GD24370@suse.de>
In-Reply-To: <20040328140807.GD24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> So you could change ->max_sectors to be 'max allowable io, hardware
> limitation' and add ->optimal_sectors to be 'best sized io'. I don't see
> tha it buys you anything, since you'd be going for optimal_sectors all
> the time anyways.


In terms of implementation, I imagine we would add a ->max_hw_sectors, 
once the IO scheduler and VM (or userland?) are smart enough to tune 
->max_sectors dynamically.

	Jeff



