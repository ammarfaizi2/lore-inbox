Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTDGVip (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTDGVip (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:38:45 -0400
Received: from [12.47.58.221] ([12.47.58.221]:57664 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263680AbTDGVip (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 17:38:45 -0400
Date: Mon, 7 Apr 2003 13:49:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] Kernel won't release cache unless pushed
Message-Id: <20030407134902.4a25c3bf.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.43.0304071615000.3052-100000@morpheus>
References: <Pine.LNX.4.43.0304071615000.3052-100000@morpheus>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 21:50:14.0436 (UTC) FILETIME=[ABAE3640:01C2FD4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle <bwindle@fint.org> wrote:
>
> Hello. In both the 2.5 and 2.4 kernel series, if I do an 'ls -lR' on a
> directory with several gigs of data, the kernel will cache all of the
> metadata (in dentry_cache, I think), which is fine (we don't want ram to
> go to waste).
> 
> However, large malloc's then fail, returning ENOMEM, because the kernel
> won't give up the memory.

Does

	echo 1  > /proc/sys/vm/overcommit_memory

fix it?

There's something borked in the overcommit crystal ball gazing.  It's on
my todo list somewhere.
