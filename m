Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVACRLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVACRLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVACRLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:11:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2531 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261505AbVACRLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:11:18 -0500
Date: Mon, 3 Jan 2005 12:10:59 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
In-Reply-To: <Pine.LNX.4.61.0501031130310.25392@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0501031209560.25392@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com>
 <20050102172929.GL5164@dualathlon.random> <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com>
 <20050103122241.GE29158@logos.cnet> <20050103162500.GX5164@dualathlon.random>
 <Pine.LNX.4.61.0501031130310.25392@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Rik van Riel wrote:

>> And did they apply Con's patch? (i.e. my 3/4 I posted few days ago)
>
> Con's patch is not relevant for this bug, since there are so few
> mapped pages (and those almost certainly live in highmem, which
> the VM is not scanning).

To quantify this, literally 99.8% of the inactive lowmem
pages are in writeback stage.  Yet the VM is OOM killing.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
