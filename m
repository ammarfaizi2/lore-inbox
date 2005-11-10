Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVKJIaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVKJIaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKJIaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:30:19 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:44678 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750918AbVKJIaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:30:17 -0500
Date: Thu, 10 Nov 2005 16:30:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 04/16] radix-tree: look-aside cache
Message-ID: <20051110083019.GA5797@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051109134938.757187000@localhost.localdomain> <20051109141448.974675000@localhost.localdomain> <437286BD.4000107@yahoo.com.au> <20051110052538.GA6585@mail.ustc.edu.cn> <4372EDA1.3000103@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4372EDA1.3000103@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 05:50:09PM +1100, Nick Piggin wrote:
> But it isn't *really* constant time lookups? I mean you'll
> always have the O(logn) lookup. Amortised I guess that
> becomes insignificant?

For sequential scan, I get 64*O(1) + 1*O(logn), that's pretty much gain.

> Briefly: is there a reason why you couldn't use gang lookups
> instead? (Sorry I haven't been able to read and understand your
> actual readahead code).

Because they have different semantics, one cannot replace the another.

> Profile numbers would be great for the cached / non-cached cases.

Ok, I'll do it, but at some time later. Currently I have several tasks that
need immediate handling, and that will take about a week. See you then :)

Regards,
Wu
