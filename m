Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264624AbUD2OcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbUD2OcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUD2OcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:32:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264665AbUD2Oa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:30:28 -0400
Date: Thu, 29 Apr 2004 10:29:20 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       <brettspamacct@fastclick.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <40907D23.7000103@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0404291027050.9152-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Nick Piggin wrote:

> I'm not very impressed with the pagecache use-once logic, and I
> have a patch to remove it completely and treat non-mapped touches
> (IMO) more sanely.

The basic idea of use-once isn't bad (search for LIRS and
ARC page replacement), however the Linux implementation
doesn't have any of the checks and balances that the
researched replacement algorithms have...

However, adding the checks and balancing required for LIRS,
ARC and CAR(S) isn't easy since it requires keeping track of
a number of recently evicted pages.  That could be quite a 
bit of infrastructure, though it might be well worth it.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

