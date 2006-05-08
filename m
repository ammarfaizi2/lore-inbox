Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWEHMpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWEHMpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 08:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWEHMpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 08:45:09 -0400
Received: from silver.veritas.com ([143.127.12.111]:18527 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932095AbWEHMpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 08:45:08 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,101,1146466800"; 
   d="scan'208"; a="37955239:sNHT23262276"
Date: Mon, 8 May 2006 13:45:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] fix can_share_swap_page() when !CONFIG_SWAP
In-Reply-To: <445ED495.3020401@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605081335030.7003@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605071525550.2515@localhost.localdomain>
 <445ED495.3020401@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 May 2006 12:45:08.0222 (UTC) FILETIME=[3CCE41E0:01C6729D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Nick Piggin wrote:
> Hua Zhong wrote:
> >
> >I'm not sure if it's the best fix. Maybe we should rename
> >can_share_swap_page() and move it out of swapfile.c. Comments?
> 
> Looks like a good patch, nice catch. You should run it past Hugh but tend to
> agree it would be nice to reuse the out of line can_share_swap_page, which
> would fold beautifully with PageSwapCache a constant 0.

True; but I think Hua's patch is good as is for now, to fix
that inefficiency.  I do agree (as you know) that there's scope for
cleanup there, and that that function is badly named; but I'm still
unprepared to embark on the cleanup, so let's just get the fix in.

Hugh
