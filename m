Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbVKOTMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbVKOTMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVKOTMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:12:33 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:63406 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965004AbVKOTMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:12:32 -0500
Subject: Re: Timer idea
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: evan@coolrunningconcepts.com, linux-kernel@vger.kernel.org
In-Reply-To: <437A2FDA.6090204@mvista.com>
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
	 <437A2FDA.6090204@mvista.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 11:12:20 -0800
Message-Id: <1132081941.2906.5.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 10:58 -0800, George Anzinger wrote:
> evan@coolrunningconcepts.com wrote:
> > I was thinking about benchmarking, profiling, and various other applications
> > that might need frequent access to the current time.  Polling timers or
> > frequent timer signal delivery both seem like there would be a lot of overhead.
> >  I was thinking it would be nice if you could just read the time information
> > without making an OS call.
> > 
> > I figure the kernel keeps accurate records of current time information and the
> > values of various timers.  I then had the idea that one could have a /dev or
> > maybe a /proc entry that would allow you to mmap() the kernel records (read
> > only) and then you could read this information right from the kernel without
> > any overhead.
> > 
> 
> Your are describing the vsyscall.  John Stultz and company are actively working on this as we speak. 
>   If memory serves, it is already available on some platforms.

Yep. x86-64 already supports this as does ppc64 via vsyscall/VDSOs. ia64
has a different variant on it as well (fast syscalls).

thanks
-john

