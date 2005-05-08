Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVEHV7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVEHV7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 17:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVEHV7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 17:59:19 -0400
Received: from mail.dif.dk ([193.138.115.101]:3807 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261828AbVEHV7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 17:59:15 -0400
Date: Mon, 9 May 2005 00:03:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, eokerson@quicknet.net, joe@perches.com
Subject: Re: [PATCH] kfree cleanups (remove redundant NULL checks) in
 drivers/telephony/ (actually ixj.c only)
In-Reply-To: <Pine.LNX.4.62.0505070407260.2384@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0505082359530.2440@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505070254180.2384@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.62.0505070345430.2384@dragon.hyggekrogen.localhost>
 <20050506190212.0d6a5300.akpm@osdl.org> <Pine.LNX.4.62.0505070407260.2384@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005, Jesper Juhl wrote:

> On Fri, 6 May 2005, Andrew Morton wrote:
> 
> > 
> > This patch adds behavioural changes:
> > 
[snip]
> > Now we'll zero ->read_buffer_size even if ->read_buffer was already NULL.
> > 
> > It's hard to believe that this could cause any problems, but please check
> > that.
> > 
> When I initially read the code I didn't see any harm that could be done by 
> that, but I'll take a second more careful look and report back - I'm 
> pretty sure it's safe though.
> I'll do this tomorrow since I'm off to catch some sleep now.
> 
Ok, I've taken a second look at the code, and I don't see any places where 
read_buffer_size are used where read_buffer is NULL, so zeroing 
read_buffer_size unconditionally when kfree()'ing read_buffer should be 
quite safe.


--
Jesper


