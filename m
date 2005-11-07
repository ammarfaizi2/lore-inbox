Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVKGFP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVKGFP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVKGFP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:15:59 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:39044 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbVKGFP6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:15:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2laoGLzIEx+5Jz31u0iA1E++JqnyboYilCNNySPxx9UFUUA7P58ySzI7ybgVvv3I9ouwwfCyWsfV/4vpKX5NPf5FFq+0UMYH//7XeOlpQrP7/45cC3PhKwKk+LkHMhj3LCQAKungQpkcVtj/14ptSk33ONAK3+d4XrPigiMbIY=
Message-ID: <2cd57c900511062115n5975fba7v@mail.gmail.com>
Date: Mon, 7 Nov 2005 13:15:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + swap-migration-v5-lru-operations-tweaks.patch added to -mm tree
Cc: akpm@osdl.org, clameter@sgi.com
In-Reply-To: <200511010521.jA15Lpsm016996@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511010521.jA15Lpsm016996@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/1, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      swap-migration-v5-lru-operations-tweaks
>
> has been added to the -mm tree.  Its filename is
>
>      swap-migration-v5-lru-operations-tweaks.patch
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> Cc: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  include/linux/mm_inline.h |    4 +---
>  mm/vmscan.c               |    6 +++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff -puN include/linux/mm_inline.h~swap-migration-v5-lru-operations-tweaks include/linux/mm_inline.h
> --- devel/include/linux/mm_inline.h~swap-migration-v5-lru-operations-tweaks     2005-10-31 21:21:48.000000000 -0800
> +++ devel-akpm/include/linux/mm_inline.h        2005-10-31 21:21:48.000000000 -0800
> @@ -44,8 +44,7 @@ del_page_from_lru(struct zone *zone, str
>   *
>   * - zone->lru_lock must be held
>   */
> -static inline int
> -__isolate_lru_page(struct zone *zone, struct page *page)
> +static inline int __isolate_lru_page(struct zone *zone, struct page *page)
>  {
>         if (TestClearPageLRU(page)) {
>                 if (get_page_testone(page)) {

My curiosity, why we do this when the former is friendly to grep? Any
coding style document about this?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
