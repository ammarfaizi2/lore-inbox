Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEZXcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEZXcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 19:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEZXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 19:32:39 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:45215 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261205AbUEZXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 19:32:37 -0400
In-Reply-To: <200405261658.i4QGwiYX000121@81-2-122-30.bradfords.org.uk>
References: <MDEHLPKNGKAHNMBLJOLKMEAEMEAA.davids@webmaster.com> <200405261658.i4QGwiYX000121@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F81057AD-AF6C-11D8-AF0E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, David Schwartz <davids@webmaster.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: why swap at all?
Date: Wed, 26 May 2004 19:32:36 -0400
To: John Bradford <john@grabjohn.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 26, 2004, at 12:58, John Bradford wrote:
>> 	A lot of people feel subjectively that swap makes a system slow. 
>> There's
>> anecdotal evidence that swap does horrible things or "must be badly 
>> broken
>> because the machine gets slow" on almost every operating system that
>> supports swapping. In most cases, it's just a case where the real 
>> working
>> set has exceeded physical memory, and in that case, swap is just 
>> doing what
>> it's supposed to be doing.
> It's true that physical RAM or swap, over and above the minimum needed 
> for
> the working set is usually beneficial.  However where there is 
> physical RAM
> which will never be touched during normal usage, adding swap will not 
> be
> beneficial.

If your RAM happens to be large enough to contain not only everything 
on disk
you ever want to even read *and* all the space you need for 
calculations, then
you have nothing to gain from using swap.  On the other hand, if you 
are say,
grepping through a kernel source tree, the first time it is read from 
disk, but after
that it is stored in cache in your RAM.  If you have swap, anonymous 
pages of
RAM that are not in use can be paged out while you do your grepping, 
even if
you are grepping through a 900MB+ dataset and only have 1GB RAM.  Swap
allows non-filesystem-backed pages to be pushed to disk for some 
filesystem
backed pages to be loaded and used.

Cheers,
Kyle Moffett

