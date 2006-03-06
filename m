Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWCFPZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWCFPZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCFPZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:25:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWCFPZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:25:29 -0500
Date: Mon, 6 Mar 2006 07:25:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #3] 
In-Reply-To: <29932.1141646154@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603060723120.13139@g5.osdl.org>
References: <20060304041647.6894ca62.akpm@osdl.org> 
 <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
 <29932.1141646154@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, David Howells wrote:
>
> > The kernel won't compile with just patch #1 applied.  Patches shouldn't go
> > into git in that manner.
> 
> It's easier to review them in that manner. If you don't think git is up to it,
> then combine them.

It's not that git isn't up to it, it's that it's unacceptable to have a 
series that doesn't compile half-way.

They are NOT easier to review - part of review is whether the damn thing 
works or not. If it doesn't compile, it doesn't work. 

The "git issue" is that git makes it really really easy to find bugs by 
automated means through bisection, and if a series doesn't compile 
half-way, that measn that the series cannot be tested half-way and it's 
much much harder to say which part of the series actually broke anything.

		Linus
