Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUBMXL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUBMXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:11:56 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:60708 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S267295AbUBMXLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:11:54 -0500
Date: Fri, 13 Feb 2004 18:11:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: RANDAZZO@ddc-web.com
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlocks dont work
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F6F@DDCNYNTD>
Message-ID: <Pine.LNX.4.44.0402131810450.26101-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 RANDAZZO@ddc-web.com wrote:

> On my uniprocessor system, I have two LKM's
        ^^^^^^^^^^^^

> how come spin locks don't work?????

The spinlock code is compiled to NOPs on uniprocessor
systems.  That is ok because the second driver cannot
run while the first driver is holding the lock.

You cannot reschedule while holding a spinlock.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

