Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVACEUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVACEUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 23:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVACEUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 23:20:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64397 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261332AbVACEUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 23:20:43 -0500
Date: Sun, 2 Jan 2005 23:20:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
In-Reply-To: <20050102172929.GL5164@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com>
 <20050102172929.GL5164@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Andrea Arcangeli wrote:

> I don't like this one, it's much less obvious than 1/2. After your
> obviously right 1/2 we're already guaranteed at least a percentage of
> the ram will not be dirty. Is the below really needed even after 1/2 +
> Andrew's fix? Are you sure this isn't a workaround for the lack of
> Andrew's fix.

Agreed, Andrew's fix should in theory be enough and only my
1/2 should be needed.

However, in practice people are still generating OOM kills
even with both Andrew's fix and my own patch applied, so I
suspect there's another hole left open somewhere...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
