Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273002AbTHPOyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273018AbTHPOyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:54:13 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:13019
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S273002AbTHPOyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:54:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] O16.2int
Date: Sun, 17 Aug 2003 01:00:34 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030816130735.3ec67ac9.lista1@telia.com> <200308170009.06461.kernel@kolivas.org> <3F3E4293.4080408@cyberone.com.au>
In-Reply-To: <3F3E4293.4080408@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308170100.34866.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 00:41, Nick Piggin wrote:
> Hi Con,
> Up late fixing the scheduler? ;)

Sigh.. yeah it was killing me slowly before and now it's killing me more 
rapidly. Seems I age a year with each patch release. Very occasionally I wish 
I was doing this in daylight hours instead of starting all my hacking at 10pm 
when the family has gone to bed.

> Quick question: have you been Contest-ing your patches much? Would
> you like me to if you haven't the time?

Not as frequently as I'd like no. If you can do nice repeatable runs it would 
be very nice of you thanks. I like to spend as much time as I can testing 
them locally on real world usage, and each time I planned to do some 
benchmarking there was always something else I needed to try after others 
responded. 2.6.0-test3-mm2 #85 doesn't even begin to tell you how many 
kernels I've booted. I've almost rebooted enough to install windows.

If you're interested, this is the script I ran for maximum repeatability in 
minimum timespace of the tests that varied a lot. I had a separate ext3 
partition on another hard disk called /ext3 (explains the command)

oops just noticed you cc'ed lkml. ah what the heck I'll cc it as well
Con

#!/bin/sh
contest -k $1 -o /ext3/dump -n 1 no_load cacherun process_load ctar_load \
xtar_load io_load io_other read_load list_load mem_load dbench_load
contest -k $1 -o /ext3/dump -n 1 process_load ctar_load \
xtar_load io_load io_other read_load list_load mem_load dbench_load
contest -k $1 -o /ext3/dump -n 1 ctar_load \
xtar_load io_load dbench_load
contest -k $1 -o /ext3/dump -n 1 io_load dbench_load
contest -r


