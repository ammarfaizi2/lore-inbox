Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTKZDkX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 22:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTKZDkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 22:40:23 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:1712 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263956AbTKZDkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 22:40:19 -0500
Date: Tue, 25 Nov 2003 22:39:10 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jack Steiner <steiner@sgi.com>
cc: Anton Blanchard <anton@samba.org>, Jes Sorensen <jes@trained-monkey.org>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       "William Lee Irwin, III" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>, <jbarnes@sgi.com>
Subject: Re: hash table sizes
In-Reply-To: <20031125231108.GA5675@sgi.com>
Message-ID: <Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Jack Steiner wrote:

> That was a concern to me too. However, on IA64, all page structs are in
> the vmalloc region

Which you'll probably want to fix eventually.  At least
PAGE_VALID() doesn't seem to work as advertised currently...

(occasionally leading to "false positives", with PAGE_VALID()
saying that a page exists while it really doesn't)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

