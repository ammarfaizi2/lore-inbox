Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269162AbUIYBGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269162AbUIYBGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUIYBGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:06:06 -0400
Received: from mail0.ewetel.de ([212.6.122.10]:1259 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S269162AbUIYBGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:06:02 -0400
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
In-Reply-To: <2I7Zd-1TK-11@gated-at.bofh.it>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it> <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it>
Date: Sat, 25 Sep 2004 03:05:40 +0200
Message-Id: <E1CB10O-0000HL-FJ@localhost>
From: Pascal Schmidt <pascal.schmidt@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 01:50:08 +0200, you wrote in linux.kernel:

> The problem isn't really that you're out of memory. Rather, the memory
> is so fragmented that swsusp is unable to get an order 8 allocation in
> which to store its metadata. There isn't really anything you can do to
> avoid this issue apart from eating memory (which swsusp is doing
> anyway).

That's one megabyte, right? Can't we preallocate that on boot, while
there's still chance to get that much contiguous memory? If the
user has swsusp compiled into his kernel, he probably wants it to
function, so it's not really "wasted".

-- 
Ciao,
Pascal
