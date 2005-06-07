Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVFGNmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVFGNmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFGNmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:42:09 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:18866 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261867AbVFGNla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:41:30 -0400
Message-ID: <42A5A400.90003@yahoo.com.au>
Date: Tue, 07 Jun 2005 23:41:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_user_pages: kill get_page_map
References: <Pine.LNX.4.61.0506062054170.5000@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0506062054170.5000@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> Since its birth, get_user_pages has been calling a misguided get_page_map
> function.  follow_page has already returned NULL if the pfn is invalid,
> we cannot reach an invalid pfn from a validated struct page.
> 
> Remove get_page_map, and the messy rewind in get_user_pages to cope with
> its failure.  Oh, and could we please call that "struct page *page" like
> everywhere else, instead of "struct page *map"?
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

This is the same as the one I've had around (from you, of course)
for ages. Been through a fair bit of testing here, and I like it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
