Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSETFWX>; Mon, 20 May 2002 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315793AbSETFWW>; Mon, 20 May 2002 01:22:22 -0400
Received: from violet.setuza.cz ([194.149.118.97]:39180 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S315792AbSETFWV>;
	Mon, 20 May 2002 01:22:21 -0400
Subject: Re: counters
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020517075235.A1680@p3.attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 May 2002 07:22:22 +0200
Message-Id: <1021872142.250.5.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that's right, but it would give one a picture how much a process --let's
say-- requests I/O.

Regards
Frank

On Fri, 2002-05-17 at 16:52, Jerry Cooperstein wrote:
> This is doable (some other OS's do it) but:
> 
> 1) It requires some changes to the basic read/write call to gather
> the statistics.  It also requires stashing the counters somewhere
> such as in the task_struct and thus requires modifying it.
> 
> 2) It doesn't directly tell you about I/O statistics themselves
> (which are available under  /proc/stat) because the I/O request
> may be gotten from cache, or may never be flushed from cache
> to disk depending on subsequent events, so it will always
> tend to overestimate the amount of real I/O done on the device.
> 
>  Jerry Cooperstein       <coop@axian.com>
>  Axian, Inc.      Software Consulting and Training
>  4800 SW Griffith Dr., Ste. 202, Beaverton, OR  97005 USA
>  http://www.axian.com/ 
> 
> 
> On Thu, May 16, 2002 at 07:44:35PM +0530, Manik Raina wrote:
> > anyone knows if there are counters in the linux kernel
> > which can be read via /proc like mechanism for the
> > following :
> > 
> > 1. total number of bytes read by process by syscalls
> > like read()
> > 
> > 2. total number of bytes written by each process by
> > syscalls like write()
> > 
> > thanks
> > -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


