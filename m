Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUCONXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUCONXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:23:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262564AbUCONXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:23:45 -0500
Date: Mon, 15 Mar 2004 08:23:24 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       <marcelo.tosatti@cyclades.com>, <j-nomura@ce.jp.nec.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040315114914.GA30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Andrea Arcangeli wrote:

> it is the absolutely worst case since both lru could be of around the same
> size (800M zone-normal-lru and 1.2G zone-highmem-lru), maximizing the
> loss of "age" information needed for optimal reclaim decisions.

You only lose age information if you don't put equal aging
pressure on both zones.  If you make sure the allocation and
pageout pressure are more or less in line with the zone sizes,
why would you lose any aging information ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

