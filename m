Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUKTD75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUKTD75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 22:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUKTD6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 22:58:19 -0500
Received: from holomorphy.com ([207.189.100.168]:38273 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263120AbUKTDzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 22:55:18 -0500
Date: Fri, 19 Nov 2004 19:55:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120035510.GH2714@holomorphy.com>
References: <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EBBE0.4010303@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Unprivileged triggers for full-tasklist scans are NMI oops material.

On Sat, Nov 20, 2004 at 02:37:04PM +1100, Nick Piggin wrote:
> Hang on, let's come back to this...
> We already have unprivileged do-for-each-thread triggers in the proc
> code. It's in do_task_stat, even. Rss reporting would basically just
> involve one extra addition within that loop.
> So... hmm, I can't see a problem with it.

/proc/ triggering NMI oopses was a persistent problem even before that
code was merged. I've not bothered testing it as it at best aggravates it.

And thread groups can share mm's. do_for_each_thread() won't suffice.


-- wli
