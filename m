Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274997AbRJJHLb>; Wed, 10 Oct 2001 03:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275003AbRJJHLL>; Wed, 10 Oct 2001 03:11:11 -0400
Received: from [195.66.192.167] ([195.66.192.167]:7942 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274997AbRJJHLJ>; Wed, 10 Oct 2001 03:11:09 -0400
Date: Wed, 10 Oct 2001 10:09:31 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <89177059197.20011010100931@port.imtp.ilyichevsk.odessa.ua>
To: Dan Maas <dmaas@dcine.com>, Bryan Mayland <bmayland@leoninedev.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <07d601c15140$f07c2870$1a01a8c0@allyourbase>
In-Reply-To: <fa.efssf0v.146031s@ifi.uio.no>
 <07d601c15140$f07c2870$1a01a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've run several LMbench tests against both 686-optimized
>> and Athlon-optimized kernels.  The results waver across multiple
>> tests, one kernel winning some tests one time and losing the next,
>> but the values are all close.

DM> The benefits of the kernel Athlon optimizations are higher memory bandwidth
DM> for bulk copies/clears and less cache pollution. But LMbench isn't going to
DM> show any difference, because its tests use generic x86 mem*() functions, not
DM> Athlon-optimized SSE memory routines like in the Athlon kernel.

There are no SSE optimizations (yet).
There are prefetch/movntq tricks.
Optimized fast_clear_page() is 3x faster than normal one,
optimized fast_copy_page() is 1.5x faster than normal one.
(roughly, it depends on your mem and CPU MHz)

I can mail a test program to you if you are curious.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


