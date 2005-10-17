Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVJQAqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVJQAqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 20:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVJQAqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 20:46:24 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:475 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932107AbVJQAqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 20:46:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc4-mm1
Date: Mon, 17 Oct 2005 10:46:12 +1000
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051016154108.25735ee3.akpm@osdl.org>
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171046.13005.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005 08:41, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.
>6.14-rc4-mm1/
> +mm-implement-swap-prefetching.patch
> +mm-implement-swap-prefetching-default-y.patch
> +mm-implement-swap-prefetching-tweaks.patch
> +mm-implement-swap-prefetching-tweaks-2.patch
>
>  Con's swap prefetching code

Thanks.

For users testing this, could you please also try larger values in: 
/proc/sys/vm/swap_prefetch
Read the current value (it should be in the range of 1-10) and try a value ten 
times larger.

It is currently quite gentle in the amount it prefetches, but the code is now 
extremely cautious about when to prefetch and I suspect it can prefetch much 
more by default, thus intensifying the effect and benefit. 

Cheers,
Con
