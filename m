Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUHQEQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUHQEQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268093AbUHQEQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:16:50 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:15203 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268092AbUHQEQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:16:48 -0400
Message-ID: <412186AC.60104@yahoo.com.au>
Date: Tue, 17 Aug 2004 14:16:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.8.1-mm1
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <20040817030748.GH11200@holomorphy.com> <20040817030957.GI11200@holomorphy.com> <20040816201915.544df590.akpm@osdl.org> <20040817034131.GJ11200@holomorphy.com>
In-Reply-To: <20040817034131.GJ11200@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>William Lee Irwin III <wli@holomorphy.com> wrote:
>
>>>How did you compile on ia64? I get:
>>>
>
>On Mon, Aug 16, 2004 at 08:19:15PM -0700, Andrew Morton wrote:
>
>>I suspect I got lucky.
>>People are saying that `make -j1' will work around this.
>>
>
>Comes up fine on Altix, so it appears kill-clone_idletask-fix.patch
>took care of everything.
>
>

Can the sched stuff in -mm go to Linus soon then? The earlier in
this cycle the better, I think.

Any boot problems introduced by the cleanup stuff shouldn't be too
hard to track down, and the simplifications are worth the possible
breakage IMO.

The scheduler behavioural change is restricted to introducing child
runs last for CLONE_VM clones, and removing balance-on-clone. Both
should be improvements on most real world threaded apps, and have
been in -mm long enough to get as much test coverage as they ever
will.

