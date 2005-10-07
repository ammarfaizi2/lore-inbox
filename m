Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVJGM0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVJGM0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVJGM0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:26:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:56469 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932425AbVJGM0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:26:19 -0400
Date: Fri, 7 Oct 2005 15:26:17 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] vm - swap_prefetch-15
In-Reply-To: <200510072208.01357.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.58.0510071511040.6755@sbz-30.cs.Helsinki.FI>
References: <200510070001.01418.kernel@kolivas.org> <200510072054.11145.kernel@kolivas.org>
 <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
 <200510072208.01357.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005, Con Kolivas wrote:
> Makes sense but it is only used in the CONFIG_SWAP_PREFETCH case so it would 
> end up as a static inline in swap.h to avoid ending being #ifdefed in 
> page_alloc.c. Do you think that's preferable to having it in 
> swap_prefetch.c ?

But then you would still have to open up buffered_rmqueue() and 
zone_statistics() to everyone, no? How about you implement a new gfp flag 
__GFP_NEVER_RECLAIM similar to __GFP_NORECLAIM instead so you don't have 
to duplicate __page_alloc()?

				Pekka
