Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUJOJJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUJOJJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 05:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUJOJJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 05:09:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:31117 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267536AbUJOJJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 05:09:06 -0400
Date: Fri, 15 Oct 2004 02:07:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mateusz.Blaszczyk@nask.pl, rml@tech9.net, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, torvalds@osdl.org
Subject: Re: [patch, 2.6.9-rc4-mm1] fix oops in sched_setscheduler
Message-Id: <20041015020712.1514f48c.akpm@osdl.org>
In-Reply-To: <20041015090336.GA14362@elte.hu>
References: <Pine.GSO.4.58.0410150833330.9897@boromir>
	<20041015090336.GA14362@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Mateusz.Blaszczyk@nask.pl <Mateusz.Blaszczyk@nask.pl> wrote:
> 
> > Running cdrecord caused oops in sched_setscheduler syscall (i think)
> > so i tested with my little setp.c program that follows. It seems that
> > it always oops - no matter what policy I request. It runs ok on
> > 2.6.9-rc2-mm1, same config. Rc3 not tested. I run setp. 3 times. The
> > first I decoded using ksymoops. My .config follows at the end.
> 
> the crash happens if 1) someone doesnt have profiling enabled 2) uses an
> UP kernel and 3) does setscheduler. The patch below fixes 3 problems:
> finishes and fixes the consolidation and fixes the profile=schedule
> feature. Against 2.6.9-rc4-mm1. Tested.

I ended up dropping
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch
so I guess this problem isn't there any more?

> also it seems that some serious mismerge happened of the
> profile=schedule feature. Wli or akpm merge damage?

If you say so - I'd need more details to comment.

> in the next mail i will send a patch against 2.6.9-rc4 too (which
> luckily doesnt have the crash bug, but has the feature mismerge).

OK.  So it sounds like no additional patch will be needed for -mm?
