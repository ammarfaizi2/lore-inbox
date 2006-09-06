Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWIFNn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWIFNn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWIFNnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:43:52 -0400
Received: from brick.kernel.dk ([62.242.22.158]:21800 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750945AbWIFNnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:43:25 -0400
Date: Wed, 6 Sep 2006 15:46:43 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/21] block: elevator selection and pinning
Message-ID: <20060906134642.GC14565@kernel.dk>
References: <20060906131630.793619000@chello.nl>> <20060906133954.673752000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906133954.673752000@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06 2006, Peter Zijlstra wrote:
> Provide an block queue init function that allows to set an elevator. And a 
> function to pin the current elevator.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Daniel Phillips <phillips@google.com>
> CC: Jens Axboe <axboe@suse.de>
> CC: Pavel Machek <pavel@ucw.cz>

Generally I don't think this is the right approach, as what you really
want to do is let the driver say "I want intelligent scheduling" or not.
The type of scheduler is policy that is left with the user, not the
driver.

And this patch seems to do two things, and you don't explain what the
pinning is useful for at all.

So that's 2 for 2 currently, NAK from me.

-- 
Jens Axboe

