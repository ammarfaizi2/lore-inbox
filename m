Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTGVNTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbTGVNTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:19:23 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:41483 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262385AbTGVNTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:19:22 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22pre6aa1
Date: Tue, 22 Jul 2003 15:34:16 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
References: <20030717102857.GA1855@dualathlon.random> <200307180024.17523.m.c.p@wolk-project.de> <20030717225002.GY1855@dualathlon.random>
In-Reply-To: <20030717225002.GY1855@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307221427.01519.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 00:50, Andrea Arcangeli wrote:

Hi Andrea,

> Can you try to change include/linux/blkdev.h like this:
> -#define MAX_QUEUE_SECTORS (4 << (20 - 9)) /* 4 mbytes when full sized */
> +#define MAX_QUEUE_SECTORS (16 << (20 - 9)) /* 4 mbytes when full sized */
> This will raise the queue from 4 to 16M. That is the first(/only) thing
> that can explain a drop in performnace while doing contigous I/O.
> However I didn't expect it to make a difference, or at least not so
> relevant.
> If this doesn't help at all, it might not be an elevator/blkdev thing.
> At least on my machines the contigous I/O still at the same speed.
well, it doesn't help at all. I/O gets more worse with that change. (8mb/s 
less). How can this happen? *wondering*

> You also where the only one reporting a loss of performance with
> elevator-lowlatency, it could be still the same problem that you've
> seen at that time.
The only one? Surely not. Also Con tested your elevator-lowlatency and we both 
saw performance degration :)

> can you try with data=writeback (or ext2) or hdparm -W1 and see if you
> can still see the same delta between the two kernels? (careful with -W1
> as it invalidates journaling)
Yes, I'll do it later this day.

Sorry for my late reply. I've been very busy.

ciao, Marc


