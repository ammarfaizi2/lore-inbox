Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWH2PTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWH2PTA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWH2PTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:19:00 -0400
Received: from science.horizon.com ([192.35.100.1]:32312 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965018AbWH2PTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:19:00 -0400
Date: 29 Aug 2006 11:18:56 -0400
Message-ID: <20060829151856.10441.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, tytso@mit.edu
Subject: Re: Linux time code
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, theotso@us.ibm.com,
       zippel@linux-m68k.org
In-Reply-To: <20060829131533.GC31760@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The Posix-mandated behaviour *requires* diverging from UTC for some
>> time period around the leap second.  All you can do is decide how
>> to schedule the divergence.

> POSIX mandates this for gettimeofday() and CLOCK_REALTIME.  

> However, a conforming implementation, could (either in userspace or in
> the kernel) provide access to other time bases, include TAI or the
> proposed UTS time scales.

The suggestion is to use UTS to implement CLOCK_REALTIME and
gettimeofday().

Since CLOCK_REALTIME has no specified accuracy bounds, it's a legal
realization, but UTS provides defined behavior when you have better time
sync than the 1s uncertainty inherent in the POSIX spec.

time() is more interesting, since it's so quantized already.  Is it better
to have a 2-second second, or to keep it in sync with gettimeofday()
and have 1000 1.001-second seconds?
