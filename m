Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUERO3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUERO3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 10:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUERO3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 10:29:16 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:34111 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263389AbUERO3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 10:29:11 -0400
In-Reply-To: <1084884150.20437.1391.camel@watt.suse.com>
References: <200405132232.01484.elenstev@mesatop.com> <200405172142.52780.elenstev@mesatop.com> <Pine.LNX.4.58.0405172056480.25502@ppc970.osdl.org> <200405172319.38853.elenstev@mesatop.com> <1084884150.20437.1391.camel@watt.suse.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B7B1F01E-A8D7-11D8-A7EA-000A95CC3A8A@lanl.gov>
Content-Transfer-Encoding: 7bit
Cc: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, support@bitmover.com,
       Linus Torvalds <torvalds@osdl.org>, adi@bitmover.com,
       wli@holomorphy.com
From: Steven Cole <scole@lanl.gov>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Tue, 18 May 2004 08:29:06 -0600
To: Chris Mason <mason@suse.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 18, 2004, at 6:42 AM, Chris Mason wrote:

> On Tue, 2004-05-18 at 01:19, Steven Cole wrote:
>
>> 2nd reply:
>> I've made four successful rather large bk pulls with Chris' patch.
>> Two were into two repos on my /home reiserfs, and I did
>> a pull, unpull, and pull again on the new reiserfs on the second disk.
>> No problems, and with PREEMPT of course.
>> The last two pulls even survived a ppp failure occuring during 
>> resolve.
>
> Good news, thank you.
>
>> So, I take it that I should revert that one-liner if I want to get 
>> any failure data?
>> With it, ext3 was pretty solid for this testing.
>
> Yes, please test ext3 again without Andrew's one liner.
>
> -chris
>

With Andrew's one-liner backed out (and your patch for reiserfs
left in), I made one successful test on my /usr ext3 fs (which
was created with default block size) and one attempt on my
new 1k block ext3 fs on my second disk.  Unfortunately, that
new fs is too small for this testing, and I got a not enough
space error while doing the first test. I plan on reformatting
the 3.9G reiserfs on my second disk to ext3 with 1k blocks
to try again tonight.

I attempted to run a script to do successive bk pulls/unpulls on
the larger ext3 fs overnight, but ppp kept failing, so I gave up
after turning into a tired pumpkin.

	Steven

