Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTDFJa3 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 05:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTDFJa3 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 05:30:29 -0400
Received: from holomorphy.com ([66.224.33.161]:52377 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262885AbTDFJa1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 05:30:27 -0400
Date: Sun, 6 Apr 2003 01:41:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, andrea@suse.de, mbligh@aracnet.com,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406094128.GK993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
	andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
	dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405232524.GD1828@holomorphy.com> <20030406052603.A4440@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406052603.A4440@redhat.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 03:25:24PM -0800, William Lee Irwin III wrote:
>> I apparently erred when I claimed this kind of test would not provide
>> useful figures of merit for page replacement algorithms. There appears
>> to be more to life than picking the right pages.

On Sun, Apr 06, 2003 at 05:26:03AM -0400, Benjamin LaHaise wrote:
> This is precisely the conclusion which davem and myself came to, and 
> explained at the beginning of this whole ordeal.  It all boils down to 
> the complexity of the algorithm, and the fact that the number of cache 
> misses scales with that.
> Can we get on with merging pgcl to mitigate some of the rmap costs now?  ;-)

No!

You do _not_ want me to merge it now unless you're speaking of drivers/
and arch code from the standpoint of "advance notice", "version skew",
or "compatibility API's". I am not done and the core impacts of the
current source are unacceptable (even to me, who wrote the 2.5 stuff)
and furthermore the antifragmentation bits are so grossly incomplete
it's not worthy of being called a full implementation. I am willing to
accept "help" but would prefer it not be given; yes I am being slow,
but unless it's a true emergency I would much prefer to do my own
homework as it were, if only for my own edification.

This _may_ sound like it's "anti-open", but it isn't really. The fact
is this is important, so even intermediate steps need discussion, but
at the same time, I am working hard, learning, and absolutely must not
be "bailed out" except if this becomes truly critical, for otherwise I
won't learn enough to maintain it myself and as I've taken on this
myself, I need to be able to take up the burden of maintaining it even
after it's merged -- that is, by learning the hard way, not bailouts.

Even beyond this general statement, the supposed pte_chain space
reductions owing to page clustering are an open question with respect
to effectiveness. I myself would need better a priori evidence and/or
empirical evidence of this to add it to my list of claimed benefits.

All this said, the drivers and the arch code bits are actually largely
trivial substitions. If the discussion is truly limited to that, I'm
okay with sending in pieces; still it makes me uneasy to do anything
while the code I have now is so far from working as it truly should.


-- wli
