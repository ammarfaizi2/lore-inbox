Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270961AbUJVDwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270961AbUJVDwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270960AbUJVDvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:51:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45976 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S270858AbUJVDtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:49:40 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Date: Thu, 21 Oct 2004 22:49:36 -0500
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       linux-kernel@vger.kernel.org
References: <20041021011714.GQ24619@dualathlon.random> <200410212155.52264.jbarnes@sgi.com> <417880C3.4000807@yahoo.com.au>
In-Reply-To: <417880C3.4000807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410212249.36535.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 21, 2004 10:38 pm, Nick Piggin wrote:
> That problem shouldn't exist any more, so your one zone per node (?)
> NUMA systems, incremental min won't have any effect at all.

Well, it used to affect us, since as the allocator iterated over nodes, the 
incremental min would increase, and so by the time we hit the 3rd or so node, 
we were leaving quite a bit of memory unused.  I just don't want to return to 
the bad old days.

> That said, it isn't something that we should just turn on and see
> who yells.

Agreed.

Thanks,
Jesse
