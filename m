Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWHCH4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWHCH4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWHCH4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:56:46 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:22948 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932382AbWHCH4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:56:45 -0400
Date: Thu, 3 Aug 2006 09:55:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Can someone explain under what condition inode cache pages can
 be swapped out?
In-Reply-To: <4ae3c140608022315y675eed20hcefbb8fb0407f4a3@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608030951270.32738@yvahk01.tjqt.qr>
References: <4ae3c140608022315y675eed20hcefbb8fb0407f4a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>
> Specifically, how a swaping system determine which page should be
> swapped out when memory is tight?

LRU, f.ex.

> Intuitively, I think inode cache
> pages should be swapped out as late as possible.

I believe they are not swapped at all - they are shrunk when memory becomes 
a premium. (If this was a math class I'd say the cache size will be zero, 
although that's not too realistic in practice)

> But how Linux mkae
> decision on this? Why linux does not pin inode pages in the memory?

Ugh hell no. Then you could trigger OOM by simply walking a big filesystem. 


Jan Engelhardt
-- 
