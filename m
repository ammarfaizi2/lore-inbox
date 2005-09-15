Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbVIOEGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVIOEGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 00:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVIOEGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 00:06:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19625
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965246AbVIOEGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 00:06:45 -0400
Date: Wed, 14 Sep 2005 21:06:40 -0700 (PDT)
Message-Id: <20050914.210640.63539596.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: sonny@burdell.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43267A00.1010405@cosmosbay.com>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	<20050913063359.GA29715@kevlar.burdell.org>
	<43267A00.1010405@cosmosbay.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Tue, 13 Sep 2005 09:04:32 +0200

> And if your process has many files opened, the cost (read : latency)
> of open() can be very high, finding a zero bit in a large bit array.
 ...
> I wish a process param could allow open() to take any free fd
> available, not > the lowest one. One can always use fcntl(fd, F_DUPFD,
> slot) to move a fd on a > specific high slot and always keep the 64
> first fd slots free to speedup the > kernel part at
> open()/dup()/socket() time.

Why not just remember the lowest available free slot and start each
bitmap search there?  This is a quite common technique.
