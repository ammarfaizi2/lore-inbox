Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVEGCGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVEGCGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 22:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVEGCGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 22:06:16 -0400
Received: from mail.dif.dk ([193.138.115.101]:14550 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261505AbVEGCGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 22:06:00 -0400
Date: Sat, 7 May 2005 04:09:38 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       eokerson@quicknet.net, joe@perches.com
Subject: Re: [PATCH] kfree cleanups (remove redundant NULL checks) in
 drivers/telephony/ (actually ixj.c only)
In-Reply-To: <20050506190212.0d6a5300.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505070407260.2384@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505070254180.2384@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.62.0505070345430.2384@dragon.hyggekrogen.localhost>
 <20050506190212.0d6a5300.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005, Andrew Morton wrote:

> 
> This patch adds behavioural changes:
> 
> -		if (j->read_buffer) {
> -			kfree(j->read_buffer);
> -			j->read_buffer = NULL;
> -			j->read_buffer_size = 0;
> -		}
> +		j->read_buffer = NULL;
> +		j->read_buffer_size = 0;
> 
> Now we'll zero ->read_buffer_size even if ->read_buffer was already NULL.
> 
> It's hard to believe that this could cause any problems, but please check
> that.
> 
When I initially read the code I didn't see any harm that could be done by 
that, but I'll take a second more careful look and report back - I'm 
pretty sure it's safe though.
I'll do this tomorrow since I'm off to catch some sleep now.

-- 
Jesper

