Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUCIRWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbUCIRWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:22:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261969AbUCIRWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:22:18 -0500
Date: Tue, 9 Mar 2004 12:22:07 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, <andrea@suse.de>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to
 avoid 4:4 in <=16G machines)
In-Reply-To: <20040309114924.GA4581@elte.hu>
Message-ID: <Pine.LNX.4.44.0403091220360.7125-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Ingo Molnar wrote:

> i think they make a forward progress so it's more of a DoS - but a very
> effective one, especially considering that i didnt even try hard ...

Ugh.  I kind of like objrmap and things may be fixable...

> what worries me is that there are apps that generate such vma patterns
> (for various reasons).
> 
> I do believe that scanning ->i_mmap & ->i_mmap_shared is fundamentally
> flawed.

Andrea may want to try a kd-tree instead of the linked
lists, that could well fix the problem you're running
into.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

