Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUGMDbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUGMDbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 23:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUGMDbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 23:31:22 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:17661 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263714AbUGMDbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 23:31:21 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Florin Andrei <florin@andrei.myip.org>
To: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
In-Reply-To: <1089677823.10777.64.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1089689478.2523.16.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 20:31:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 17:17, Lee Revell wrote:

> There is an overwhelming consensus amongst Linux audio
> folks that you should use reiserfs for low latency work.

I doubt the "overwhelming consensus" part. ReiserFS is good at
creating/deleting lots of small files and that's not a typical scenario
when doing audio work.
For audio stuff the FS does not seem to matter much. However, when
working with large files (there are audio apps that create large project
files sometimes, especially when working in 96/24 mode and that kind of
stuff) i've seen better results with XFS.

When files get really big (think: video capture) there's no doubt XFS is
best. I've had a video capture app skipping frames no matter what, on
Ext3 and ReiserFS. Switch to XFS, the result: no more frame skipping.

-- 
Florin Andrei

http://florin.myip.org/

