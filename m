Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265055AbRF0SnF>; Wed, 27 Jun 2001 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265366AbRF0Smz>; Wed, 27 Jun 2001 14:42:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265055AbRF0Smm>; Wed, 27 Jun 2001 14:42:42 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PCI Power Management / Interrupt Context
Date: Wed, 27 Jun 2001 18:41:26 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9hd9cm$vv5$1@penguin.transmeta.com>
In-Reply-To: <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu>
X-Trace: palladium.transmeta.com 993667336 29475 127.0.0.1 (27 Jun 2001 18:42:16 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Jun 2001 18:42:16 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SOL.4.21.0106262208240.3824-100000@oscar.cc.gatech.edu>,
David T Eger  <eger@cc.gatech.edu> wrote:
>
>So I'm writing some code for a PCI card that is a framebuffer device, and
>happily filling in the functions for the probe() and remove() functions
>when I read documentation (Documentation/pci.txt) which mentions that
>remove() can be called from interrupt context.

This used to be true for a short while for hot-plug CardBus. I don't
think it is true any more - and if it is, that would be a bug.

So I think it's the documentation that is in error, and we should just
fix that.

Jeff?

		Linus
