Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316254AbSEQOwW>; Fri, 17 May 2002 10:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316255AbSEQOwV>; Fri, 17 May 2002 10:52:21 -0400
Received: from 12-225-96-71.client.attbi.com ([12.225.96.71]:12160 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S316254AbSEQOwU>;
	Fri, 17 May 2002 10:52:20 -0400
Date: Fri, 17 May 2002 07:52:35 -0700
From: Jerry Cooperstein <coop@axian.com>
To: Manik Raina <EED@ail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: counters
Message-ID: <20020517075235.A1680@p3.attbi.com>
In-Reply-To: <3CE3BECB.FF1AE6A@ail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is doable (some other OS's do it) but:

1) It requires some changes to the basic read/write call to gather
the statistics.  It also requires stashing the counters somewhere
such as in the task_struct and thus requires modifying it.

2) It doesn't directly tell you about I/O statistics themselves
(which are available under  /proc/stat) because the I/O request
may be gotten from cache, or may never be flushed from cache
to disk depending on subsequent events, so it will always
tend to overestimate the amount of real I/O done on the device.

 Jerry Cooperstein       <coop@axian.com>
 Axian, Inc.      Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202, Beaverton, OR  97005 USA
 http://www.axian.com/ 


On Thu, May 16, 2002 at 07:44:35PM +0530, Manik Raina wrote:
> anyone knows if there are counters in the linux kernel
> which can be read via /proc like mechanism for the
> following :
> 
> 1. total number of bytes read by process by syscalls
> like read()
> 
> 2. total number of bytes written by each process by
> syscalls like write()
> 
> thanks
> -
