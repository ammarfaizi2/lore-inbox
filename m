Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVKOQyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVKOQyh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVKOQyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:54:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64904 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964947AbVKOQyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:54:35 -0500
Date: Tue, 15 Nov 2005 08:54:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
In-Reply-To: <20051115163246.GA4959@mail.shareable.org>
Message-ID: <Pine.LNX.4.64.0511150853230.3945@g5.osdl.org>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> <20051115163246.GA4959@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Nov 2005, Jamie Lokier wrote:

> Linus Torvalds wrote:
> > And if it _is_ properly named (ie it really does mean "this entry
> > positively does not exist") then it shouldn't have the same
> > representation as NULL, because NULL really is traditionally used
> > for "unknown" rather than "known to not exist".
> 
> You mean like:
> 
> > a negative dentry (dentry->d_inode = NULL) is another.
> 
> ? :)

The _dentry_ is negative, and it is not NULL. It has an explicit flag 
saying that it's negative.

We do not have negative inode caches.

		Linus
