Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVACWIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVACWIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACWFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:05:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55966 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261888AbVACWCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:02:13 -0500
Date: Mon, 3 Jan 2005 17:01:50 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
In-Reply-To: <20050103185110.GF14886@logos.cnet>
Message-ID: <Pine.LNX.4.61.0501031700240.25392@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com>
 <20050102172929.GL5164@dualathlon.random> <Pine.LNX.4.61.0501022319180.10640@chimarrao.boston.redhat.com>
 <20050103122241.GE29158@logos.cnet> <20050103162500.GX5164@dualathlon.random>
 <Pine.LNX.4.61.0501031130310.25392@chimarrao.boston.redhat.com>
 <20050103185110.GF14886@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Marcelo Tosatti wrote:

> Yes - Andrew's throttle_vm_writeout() should be handling that.

> You sure the above logic is working on RH kernels?

Exactly the same code.

> I can't see how it could fail with this in place.

Neither can I, except perhaps the IO subsystem is sized
to handle more IO than all the lowmem pages simultaneously ?

The patch I just posted to lkml ([5/?]) should fix another
issue related to this problem, and might just fix the problem.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
