Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTE3UQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTE3UQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:16:55 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:47576 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264012AbTE3UQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:16:54 -0400
Date: Fri, 30 May 2003 13:30:15 -0700
From: Andrew Morton <akpm@digeo.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
Message-Id: <20030530133015.4f305808.akpm@digeo.com>
In-Reply-To: <16087.47491.603116.892709@gargle.gargle.HOWL>
References: <20030529012914.2c315dad.akpm@digeo.com>
	<20030529042333.3dd62255.akpm@digeo.com>
	<16087.47491.603116.892709@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 20:30:14.0356 (UTC) FILETIME=[4680E140:01C326EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> wrote:
>
> >>>>> "Andrew" == Andrew Morton <akpm@digeo.com> writes:
> 
> >> . A couple more locking mistakes in ext3 have been fixed.
> 
> Andrew> But not all of them.  The below is needed on SMP.
> 
> Any hint on when -mm3 will be out,

About ten hours hence, probably.

> and if it will include the RAID1 patches?

I have a raid0 patch from Neil, but no raid1 patch.  I saw one drift past,
from Zwane (I think), but wasn't sure that it worked.  If someone has a
raid1 fix, please send it.

> I haven't had time to play with -mm2, and all the stuff
> floating by about problems has made me a bit hesitant to try it out.

Welll ext3 has been a bit bumpy of course.  It's getting better, but I
haven't yet been able to give it a 12-hour bash on the 4-way.  Last time I
tried a circuit breaker conked; it lasted three hours but even ext3 needs
electricity.  But three hours is very positive - it was hard testing.

I'm not testing RAID at present, partly because I'm too stoopid to
understand mdadm and partly because the box-with-18-disks heats the room up
too much.  This needs to change, because of possible interaction between
the IO scheduler work and software RAID.

