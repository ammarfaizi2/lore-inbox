Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266257AbTA2PQB>; Wed, 29 Jan 2003 10:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbTA2PQB>; Wed, 29 Jan 2003 10:16:01 -0500
Received: from [217.167.51.129] ([217.167.51.129]:42199 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266257AbTA2PQA>;
	Wed, 29 Jan 2003 10:16:00 -0500
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid
	b_page.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030129152214.GE31566@suse.de>
References: <1043852266.1690.63.camel@zion.wanadoo.fr>
	 <20030129150000.GD31566@suse.de> <1043853614.1668.70.camel@zion.wanadoo.fr>
	 <20030129152214.GE31566@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043853975.1668.74.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 29 Jan 2003 16:26:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 16:22, Jens Axboe wrote:

> Ehm no, if b_data is < PAGE_SIZE, it's probably an offset and not a
> valid address. So it should be exactly where it is -- for b_page, it's
> _not_ buggy for b_data to be < PAGE_SIZE. That's expected. Submitter
> would have to be buggy for it to trigger, though, so you can just remove
> it if you want.

Ah, I see what you wanted to check now :) Ok, I won't remove it, though
it would still make sense to extend the test to PAGE_OFFSET I beleive,
any b_data < PAGE_OFFSET is wrong.

Anyway, let's leave 2.4 as it is now.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
