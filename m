Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280915AbRKORpQ>; Thu, 15 Nov 2001 12:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280931AbRKORpD>; Thu, 15 Nov 2001 12:45:03 -0500
Received: from www.wen-online.de ([212.223.88.39]:18703 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S280915AbRKORoZ>;
	Thu, 15 Nov 2001 12:44:25 -0500
Date: Thu, 15 Nov 2001 18:44:18 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: janne <sniff@xxx.ath.cx>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <Pine.LNX.4.10.10111151104360.17267-100000@ebola.baana.suomi.net>
Message-ID: <Pine.LNX.4.33.0111151811310.618-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2001, janne wrote:

> to followup to my previous post: i don't know how the current code
> works, but perhaps there should be some logic added to check the
> percentage of total mem used for cache before swapping out.

No.

> like, if memory is full and there's less than 10% of total mem used for
> cache, then start swapping out. not if ~90% is already used for cache.. :)

Numbers like this don't work.  You may have a very large and very hot
cache.. you may also have a very large and hot gob of anonymous pages.

	-Mike

