Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWERGkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWERGkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 02:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWERGkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 02:40:15 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:21663 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751159AbWERGkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 02:40:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] swap-prefetch, fix lru_cache_add_tail()
Date: Thu, 18 May 2006 16:39:53 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <1147884867.22400.9.camel@lappy>
In-Reply-To: <1147884867.22400.9.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181639.53546.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 02:54, Peter Zijlstra wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
> lru_cache_add_tail() uses the inactive per-cpu pagevec. This causes
> normal inactive and intactive tail inserts to end up on the wrong end
> of the list.
>
> When the pagevec is completed by lru_cache_add_tail() but still contains
> normal inactive pages, all pages will be added to the inactive tail and
> vice versa.
>
> Also *add_drain*() will always complete to the inactive head.
>
> Add a third per-cpu pagevec to alleviate this problem.

Thanks!

> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Signed-off-by: Con Kolivas <kernel@kolivas.org>

-- 
-ck
