Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTJLOL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 10:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTJLOL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 10:11:58 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:9739 "EHLO
	cluless.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263189AbTJLOL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 10:11:57 -0400
Date: Sun, 12 Oct 2003 10:11:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cluless.boston.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, <Matt_Domsch@Dell.com>,
       <marcelo.tosatti@cyclades.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310121213080.4598-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310121009560.30191-100000@cluless.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003, Hugh Dickins wrote:

> I agree on that too: I think Rik did it for atomicity throughout,
> to make the safety obvious; but in practice it was already safe.

Also to keep this fix future proof.  Who knows whether
a super-optimised patch that masks just this particular
race condition will still be safe when XFS is merged ?

I really don't like keeping the code fragile and making
it easy to reintroduce bugs.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

