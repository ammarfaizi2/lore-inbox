Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUBVRAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUBVRAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:00:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:63149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261698AbUBVRAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:00:17 -0500
Date: Sun, 22 Feb 2004 09:05:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <piggin@cyberone.com.au>, cw@f00f.org, mfedyk@matchmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
In-Reply-To: <20040221220927.198749d4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402220903360.3301@ppc970.osdl.org>
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com>
 <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
 <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
 <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au>
 <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au>
 <20040221220927.198749d4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Andrew Morton wrote:
>
> yeah.  We should have made that change when making shrink_slab() ignore
> highmem scanning.
> 
> Something like this (the function needs a rename)

Why not just pass in the list of zones? That way the _caller_ determines 
what zones he is interested in.

So just add a "struct zonelist *zonelist" as the argument, the same way 
"__alloc_pages()" has..

		Linus
