Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVDFHTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVDFHTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVDFHTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:19:42 -0400
Received: from orb.pobox.com ([207.8.226.5]:52393 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262129AbVDFHTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:19:39 -0400
Date: Wed, 6 Apr 2005 00:19:34 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050406071934.GA5211@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405175600.644e2453.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 05:56:00PM -0700, Andrew Morton wrote:
> Odd.

Yes, it is odd...

> > 2.6.11-bk9 works (actually it takes under 2 seconds, not 5-10).
> > 2.6.11-bk10 has the weird slowdown.
> 
> Unfortunately that's a pretty bug diff (2 megs).

Yeah, I know. *sigh*

[snip]
> but you'd be getting a printk storm if that was triggering.

I'm not seeing a printk storm, at least, none that I can discern...

> > I'll see if I can isolate it any further.
> 
> Please, that would help.

I'm working on it right now.

2.6.11 + linus.patch from 2.6.11-mm3 works.
2.6.11 + approx. 292 patches from 2.6.11-mm3 is broken.
2.6.11 + approx. 130 patches (a proper subset of the 292 patches) works.

(this is counting each subsystem bk tree as a single patch)

The diff between the latter two trees is still larger than the
2.6.11-bk9 -> -bk10 diff, but after one or two more iterations of
(psuedo-)binary search, it should be much smaller.

I'm planning to go as far as I can before going to bed tonight.

-Barry K. Nathan <barryn@pobox.com>
