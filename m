Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265570AbTIDVuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbTIDVuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:50:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:35726 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265570AbTIDVuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:50:06 -0400
Date: Thu, 4 Sep 2003 14:49:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <20030904200426.GB31590@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.44.0309041447590.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Jamie Lokier wrote:
> 
>     * A futex on a MAP_PRIVATE must be mm-local: the canonical
>     * example being MAP_PRIVATE of /dev/zero.

Actually, /dev/zero is a special case in itself. It is an anonymous 
mapping, and is equivalent to MAP_ANON for private mappings. For 
MAP_SHARED it is something _totally_ different.

So /dev/zero isn't even an interesting case.

> Unfortunately I think the above 5 conditions do not have a consistent
> solution.  Please prove me wrong :)

I don't think there is any inconsistency.

		Linus

