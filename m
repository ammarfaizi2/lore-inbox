Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTAFFEz>; Mon, 6 Jan 2003 00:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTAFFEz>; Mon, 6 Jan 2003 00:04:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:18857 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266285AbTAFFEy>;
	Mon, 6 Jan 2003 00:04:54 -0500
Message-ID: <3E191074.994DCB2F@digeo.com>
Date: Sun, 05 Jan 2003 21:13:24 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] md: Make sure yielding thread actually yields cpu when 
 waiting for turn at reconstruct.
References: <200301060505.h0655X402236@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 05:13:24.0713 (UTC) FILETIME=[56B77D90:01C2B542]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> 
> ChangeSet 1.897, 2003/01/05 19:45:48-08:00, neilb@cse.unsw.edu.au
> 
>         [PATCH] md: Make sure yielding thread actually yields cpu when waiting for turn at reconstruct.
> 

Be aware that yield() has changed a _lot_ since 2.4.   It can
now go away for hundreds of milliseconds.

I suggest you test this change while running `make -j6 bzImage'
on the same machine, make sure it doesn't do horrid things.
