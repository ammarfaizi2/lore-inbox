Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTARHm7>; Sat, 18 Jan 2003 02:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbTARHm7>; Sat, 18 Jan 2003 02:42:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:41097 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263228AbTARHm7>;
	Sat, 18 Jan 2003 02:42:59 -0500
Date: Fri, 17 Jan 2003 23:53:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
Message-Id: <20030117235317.01ad6b7b.akpm@digeo.com>
In-Reply-To: <15913.1396.22808.83238@napali.hpl.hp.com>
References: <20030118060522.GE7800@krispykreme>
	<20030117224444.08c48290.akpm@digeo.com>
	<15913.1396.22808.83238@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 07:51:52.0941 (UTC) FILETIME=[7704F1D0:01C2BEC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Fri, 17 Jan 2003 22:44:44 -0800, Andrew Morton <akpm@digeo.com> said:
> 
>   Andrew> Looks like ia64 needs work, too...
> 
> Yes, should be the same problem there.  The fix looks fine to me.
> (Let's just hope I remember it when Linus puts it in his tree...).
> 

I've updated that patch to cover ia64, but I think we'll run with the other
approach - just remove those calls to SET_PERSONALITY().

They just seem illogical anyway - why are we switching into the new image's
personality prior to unmapping the old image's memory?

