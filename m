Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbRG0DOW>; Thu, 26 Jul 2001 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268764AbRG0DON>; Thu, 26 Jul 2001 23:14:13 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:63499 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267018AbRG0DOA>; Thu, 26 Jul 2001 23:14:00 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
Date: Fri, 27 Jul 2001 03:12:23 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9jqm6n$163$1@penguin.transmeta.com>
In-Reply-To: <9C117960438@vcnet.vc.cvut.cz> <20010726175735.A20320@twiddle.net>
X-Trace: palladium.transmeta.com 996203644 771 127.0.0.1 (27 Jul 2001 03:14:04 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Jul 2001 03:14:04 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010726175735.A20320@twiddle.net>,
Richard Henderson  <rth@twiddle.net> wrote:
>On Thu, Jul 26, 2001 at 08:28:32PM +0000, Petr Vandrovec wrote:
>> Just adding '-finline-limit=150' fixes all of them (critical limit
>> is somewhere between 120 and 150 on my kernel). As '-finline-limit'
>> is documented as being 10000 by default, it looks like that someone
>> changed default value to some really unreasonable value (probably 100).
>
>Yes.  The higher value resulted in much compile-time lossage on
>heavily templated c++ code, as it proceeded to inline everything
>in sight.

Having seen the discussion on the gcc lists, I can only heartily
approve.

I did some repmacement of "extern" into "static" in 2.4.8-pre1, but I
don't have gcc-3.0.x on my machines (too many headaches, too little
time). 

		Linus
