Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269455AbUIRLmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269455AbUIRLmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 07:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUIRLmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 07:42:19 -0400
Received: from holomorphy.com ([207.189.100.168]:54450 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269455AbUIRLmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 07:42:18 -0400
Date: Sat, 18 Sep 2004 04:41:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix missing unlock_page in mm/rmap.c
Message-ID: <20040918114159.GM9106@holomorphy.com>
References: <414C1390.6050802@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414C1390.6050802@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 08:53:04PM +1000, Nick Piggin wrote:
> Please apply.
> A required unlock_page will be missed in a very rare (but possible) race
> condition. Acked by Hugh, who says:
> 	It'll be hard to hit because of the additional page_mapped test above,
> 	with truncate unmapping ptes from mms before it advances to removing
> 	pages from cache; but nothing to prevent it happening.
> Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

I've hit a missing unlock_page(). I'll see if this fixed it.


-- wli
