Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQLMWeX>; Wed, 13 Dec 2000 17:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131190AbQLMWeN>; Wed, 13 Dec 2000 17:34:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15621 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129757AbQLMWeA>; Wed, 13 Dec 2000 17:34:00 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: test12: innd bug came back?
Date: 13 Dec 2000 14:03:01 -0800
Organization: Transmeta Corporation
Message-ID: <918rml$53u$1@penguin.transmeta.com>
In-Reply-To: <918pmt$q9s$1@osiris.storner.dk> <Pine.GSO.4.21.0012131646070.5045-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0012131646070.5045-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>
>
>On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:
>
>> Just to add a "me too" on this. I didn't report when I saw it last week,
>> because I was uncertain of exactly what might have caused it - I was
>> booting several different kernels at the time, including one from a
>> rescue disk (I was trying to salvage bits of a Win9x disk at the time -
>> don't ask for details!)
>> 
>> Alas, I lost the test program someone wrote to test for the truncate
>> problem, and due to moving I will not be able to test anything until 
>> next Monday. But if needed, I can do some testing then. Something 
>> definitely went wrong with innd during the test12 pre-patches.
>
>It may be a side effect of removing partial_clear() in test12-final.

No. If you read the code, partial_clear() has been a no-op for the
longest time (the "start & ~PAGE_MASK" thing could never trigger, as
"start" has been page-aligned for a long long while now.

So it must be something else.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
