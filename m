Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266536AbRGTETE>; Fri, 20 Jul 2001 00:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbRGTESz>; Fri, 20 Jul 2001 00:18:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59915 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266536AbRGTESp>; Fri, 20 Jul 2001 00:18:45 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bitops.h ifdef __KERNEL__ cleanup.
Date: 19 Jul 2001 21:18:41 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9j8bf1$1at$1@cesium.transmeta.com>
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz> <11472.995579612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Followup to:  <11472.995579612@redhat.com>
By author:    David Woodhouse <dwmw2@infradead.org>
In newsgroup: linux.dev.kernel
> 
> It has been stated many times that kernel headers should not be used in
> apps. Renaming or moving them should not be necessary - and people would
> probably only start to use them again anyway. We'd see autoconf checks to 
> find whether it's linux/private.h or xunil/private.h :)
> 
> In the absence of any expectation that userspace developers will ever obey
> the simple and oft-repeated rule that you don't use kernel headers from
> userspace, the #ifdef __KERNEL__ approach would seem to be the best on
> offer.
> 

Note that the rule is at least in part theoretical; even glibc include
kernel headers or -derivatives.

I think the idea with <asm/bitops.h> is that they are protected by
#ifdef __KERNEL__ if they are kernel-only; however, if they work in
user space then there is no #ifdef and autoconf can detect their
presence.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
