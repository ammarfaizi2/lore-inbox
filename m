Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTIDQxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTIDQxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:53:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19647 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S265285AbTIDQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:53:51 -0400
Date: Thu, 4 Sep 2003 17:55:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309040837560.580-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309041750410.4038-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Linus Torvalds wrote:
> 
> However, the thing is, the case really can be a totally writable
> MAP_PRIVATE that just hasn't been modified (and thus not COW'ed) _yet_.
> 
> But sure, we could just require that futex pages are dirty in this case.

There's no problem here in Jamie's implementation, no need to demand that;
but the previous implementation did make COWing problems for itself, yes.

Hugh 

