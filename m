Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVCCCKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVCCCKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCCCAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:00:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:58775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261353AbVCCCAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:00:24 -0500
Date: Wed, 2 Mar 2005 17:59:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, linuxram@us.ibm.com, slpratt@austin.ibm.com
Subject: Re: [PATCH 1/2] readahead: simplify ra->size testing
Message-Id: <20050302175947.6f1e6b5f.akpm@osdl.org>
In-Reply-To: <42260F2C.FCAA1915@tv-sign.ru>
References: <42260F2C.FCAA1915@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> On top of "readahead: cleanup blockable_page_cache_readahead()",
>  see http://marc.theaimsgroup.com/?l=linux-kernel&m=110927049500942
> 
>  Currently page_cache_readahead() treats ra->size == 0 (first read)
>  and ra->size == -1 (ra_off was called) separately, but does exactly
>  the same in both cases.
> 
>  With this patch we may assume that the reading starts in 'ra_off()'
>  state, so we don't need to consider the first read as a special case.

So...  the big "how it all works" comment needs an update..
