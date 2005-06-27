Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVF0PCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVF0PCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVF0O4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:56:19 -0400
Received: from kanga.kvack.org ([66.96.29.28]:63892 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262048AbVF0NPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:15:45 -0400
Date: Mon, 27 Jun 2005 09:17:10 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
Message-ID: <20050627131710.GC13945@kvack.org>
References: <42BF9CD1.2030102@yahoo.com.au> <20050627004624.53f0415e.akpm@osdl.org> <42BFB287.5060104@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BFB287.5060104@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 06:02:15PM +1000, Nick Piggin wrote:
> However I think for Oracle and others that use shared memory like
> this, they are probably not doing linear access, so that would be a
> net loss. I'm not completely sure (I don't have access to real loads
> at the moment), but I would have thought those guys would have looked
> into fault ahead if it were a possibility.

Shared memory overhead doesn't show up on any of the database benchmarks 
I've seen, as they tend to use huge pages that are locked in memory, and 
thus don't tend to access the page cache at all after ramp up.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
