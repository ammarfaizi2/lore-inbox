Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVDRU56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVDRU56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDRU56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:57:58 -0400
Received: from mail.dif.dk ([193.138.115.101]:22466 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261176AbVDRU5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:57:43 -0400
Date: Mon, 18 Apr 2005 23:00:42 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] new valid_signal function
In-Reply-To: <Pine.LNX.4.62.0504182240390.5362@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0504182259200.5362@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504182240390.5362@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Jesper Juhl wrote:

> This patch adds a new function  valid_signal()  that tests if its argument 
> is a valid signal number. 
> 
> The reasons for adding this new function are:
> - some code currently testing _NSIG directly has off-by-one errors. Using 
> this function instead avoids such errors.
> - some code currently tests unsigned signal numbers for <0 which is 
> pointless and generates warnings when building with gcc -W. Using this 
> function instead avoids such warnings.
> 

Note to observers: I forgot to mention that the prelude to this patch can 
be found in the thread titled 
'[PATCH] fs/fcntl.c : don't test unsigned value for less than zero'


-- 
Jesper 


