Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267324AbRGKXxR>; Wed, 11 Jul 2001 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbRGKXxH>; Wed, 11 Jul 2001 19:53:07 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11538 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267259AbRGKXw7>; Wed, 11 Jul 2001 19:52:59 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Date: Wed, 11 Jul 2001 23:51:35 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9iioq7$43o$1@penguin.transmeta.com>
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com> <01071116375404.29517@frumious.unidec.co.uk> <003f01c10a63$08f50540$0301a8c0@rpnet.com>
X-Trace: palladium.transmeta.com 994895561 12166 127.0.0.1 (11 Jul 2001 23:52:41 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 11 Jul 2001 23:52:41 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <003f01c10a63$08f50540$0301a8c0@rpnet.com>,
Richard Purdie <rpurdie@bigfoot.com> wrote:
>
>Now I'm back to the kerenel panic below which takes down the system at the
>same point as before:

Looks like a "cmovne" that traps - are you sure you've compiled your
module with the right CPU flags? In particular, maybe you compiled it
for a i686, and are running it on a Pentium?

		Linus
