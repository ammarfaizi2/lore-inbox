Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265614AbTIDWLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbTIDWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:10:56 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8333 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S265614AbTIDWKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:10:39 -0400
Date: Thu, 4 Sep 2003 23:10:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904221011.GJ31590@mail.jlokier.co.uk>
References: <20030904200426.GB31590@mail.jlokier.co.uk> <Pine.LNX.4.44.0309041447590.6676-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309041447590.6676-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >     * A futex on a MAP_PRIVATE must be mm-local: the canonical
> >     * example being MAP_PRIVATE of /dev/zero.
> 
> Actually, /dev/zero is a special case in itself. It is an anonymous 
> mapping, and is equivalent to MAP_ANON for private mappings. For 
> MAP_SHARED it is something _totally_ different.

Well yes, but conceptually it's behaviour is that of a private mapping
of a file-like object.  But fine, let's not get sidetracked by /dev/zero.

I'll restate it:

	* A futex on a MAP_PRIVATE must be mm-local.  The canonical
	example being the data section of your executable.

> > Unfortunately I think the above 5 conditions do not have a consistent
> > solution.  Please prove me wrong :)
> 
> I don't think there is any inconsistency.

I can't think of a behaviour which satisfies all 5 conditions, so
you'll have to help me out. :/

-- Jamie

