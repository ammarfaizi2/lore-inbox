Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268009AbUHFA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268009AbUHFA7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHFA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:59:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4754 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268009AbUHFA7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:59:09 -0400
Date: Thu, 5 Aug 2004 20:59:07 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
In-Reply-To: <20040805175334.47f3054b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408052056160.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Andrew Morton wrote:

> Good question.  What I'm groping for here is some definition of what we
> actually want the feature to _do_.  Once we have that, and have suitably
> argued about it, we can then go off and see if the patch actually does it.

What I want the feature to do is allow users to set an
RSS rlimit to prevent a process from hogging up all the
machine's memory.

I am not looking for a hard memory limit, since that
would just cause extra IO, which has bad consequences
for the rest of the system.

In addition, I would like the patch to be relatively
low impact, not giving us much maintenance overhead or
much runtime overhead.

If anybody has good reasons for needing hard per-process
RSS limits, let us know.  So far I haven't seen anybody
with a workload that somehow requires a hard limit.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

