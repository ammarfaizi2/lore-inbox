Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbUKQBG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUKQBG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 20:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUKQBG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 20:06:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:37058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262151AbUKQBFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:05:36 -0500
Date: Tue, 16 Nov 2004 17:05:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, linux-kernel@vger.kernel.org, dev@sw.ru, wli@holomorphy.com,
       steiner@sgi.com, sandeen@sgi.com
Subject: Re: 21 million inodes is causing severe pauses.
Message-Id: <20041116170521.52d9bc6b.akpm@osdl.org>
In-Reply-To: <20041117005400.GA11322@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com>
	<20041115145714.3f757012.akpm@osdl.org>
	<20041116162859.GA5594@lnx-holt.americas.sgi.com>
	<20041116111321.36a6cd06.akpm@osdl.org>
	<20041116194858.GA2549@lnx-holt.americas.sgi.com>
	<20041116163310.34580297.akpm@osdl.org>
	<20041117005400.GA11322@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
>  > > At this point, I have checked the entire code path and see no reason the
>  > > BKL is held for the first call to invalidate_inodes.
>  > 
>  > No, the above change looks fine.  And I have no problem merging up
>  > invalidate_inodes-speedup.patch, really - it's been in -mm for over a year.
>  > I've just been waiting for a decent reason to merge it.
> 
>  I would strongly encourage merging the three patches we have talked about
>  here.  I understand you would typically keep my BKL patch in your tree for
>  awhile and think that would be just fine.  The changes only affect systems
>  that have filesystems being unmounted with a large number of inodes.
> 
>  With the two patches already in your tree, the pauses are greatly reduced
>  for the autofs case that originally got me looking.

OK.  It's a bit late for 2.6.10 but I was planning on slurping the whole
lot into 2.6.11 anyway.

