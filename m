Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbTH0HZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbTH0HZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:25:36 -0400
Received: from holomorphy.com ([66.224.33.161]:29109 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263247AbTH0HZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:25:27 -0400
Date: Wed, 27 Aug 2003 00:26:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Peter Chubb <peterc@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827072633.GW4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030826181807.1edb8c48.akpm@osdl.org> <16204.3686.972704.91444@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16204.3686.972704.91444@wombat.chubb.wattle.id.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 11:50:30AM +1000, Peter Chubb wrote:
> I'm actually intested in getting most of the rusage fields filled in
> properly, at least the ones that make sense for Linux.

Me too.


On Wed, Aug 27, 2003 at 11:50:30AM +1000, Peter Chubb wrote:
> Things to do are:
>        -- Track maxrss and report it.

That's easy.


On Wed, Aug 27, 2003 at 11:50:30AM +1000, Peter Chubb wrote:
>        -- Track and integrate rss.
>        -- Fix the page fault accounting (currently some minor faults
>           are counted as major faults)

Hmm, I don't remember this offhand. I thought the bigger issue was with
threads.


On Wed, Aug 27, 2003 at 11:50:30AM +1000, Peter Chubb wrote:
>        -- add signal accounting

Sounds easy.


On Wed, Aug 27, 2003 at 11:50:30AM +1000, Peter Chubb wrote:
> Block I/O isn't that important -- it almost all goes through the page
> cache anyway, and it's a bit difficult to assign a particular I/O to a
> particular process.  Likewise, message I.O isn't that important AFAIK.

Well, ignoring the background io issue and just ticking per-task counters
in the read/write syscalls sounds good enough to me.


On Wed, Aug 27, 2003 at 11:50:30AM +1000, Peter Chubb wrote:
> The stack, data and unshared data sizes aren't currently
> accounted for separately at all, so it'd be a bit difficult to track
> the integral of those numbers.

I've got some stuff to keep the derivatives of these going on the back
burner, and integrating isn't hard.


-- wli
