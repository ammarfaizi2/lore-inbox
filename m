Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUGMAsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUGMAsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUGMAsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:48:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:57987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264367AbUGMAr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:47:59 -0400
Date: Mon, 12 Jul 2004 17:46:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040712174639.38c7cf48.akpm@osdl.org>
In-Reply-To: <1089677823.10777.64.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> > resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
>  > fixes ended up breaking the fs in subtle ways and I eventually gave up.
>  > 
> 
>  Interesting.  There is an overwhelming consensus amongst Linux audio
>  folks that you should use reiserfs for low latency work.

It seems to be misplaced.  A simple make-a-zillion-teeny-files test here
exhibits a 14 millisecond holdoff.

>  Should I try ext3?

ext3 is certainly better than that, but still has a couple of potential
problem spots.  ext2 is probably the best at this time.

