Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUCDMMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 07:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCDMMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 07:12:46 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:6583 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261861AbUCDMMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 07:12:43 -0500
Date: Thu, 4 Mar 2004 07:12:23 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>,
       <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040304045212.GG4922@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403040711020.32706-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Andrea Arcangeli wrote:
> On Wed, Mar 03, 2004 at 08:07:04PM -0800, Andrew Morton wrote:

> > A kernel profile would be interesting.  As would an optimisation effort,
> > which, as far as I know, has never been undertaken.
> 
> yes, though I doubt you'll find anything interesting in the kernel,

Oh, but there is a big bottleneck left, at least in RHEL3.

All the CPUs use the _same_ mm_struct in kernel space, so
all VM operations inside the kernel are effectively single 
threaded.

Ingo had a patch to fix that, but it wasn't ready in time.
Maybe it is in the 2.6 patch set, maybe not ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

