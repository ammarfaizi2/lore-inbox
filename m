Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbTCQO7g>; Mon, 17 Mar 2003 09:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbTCQO7g>; Mon, 17 Mar 2003 09:59:36 -0500
Received: from holomorphy.com ([66.224.33.161]:14042 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261726AbTCQO7f>;
	Mon, 17 Mar 2003 09:59:35 -0500
Date: Mon, 17 Mar 2003 07:10:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@surriel.com>
Cc: Paul Albrecht <palbrecht@uswest.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317151004.GR20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@surriel.com>,
	Paul Albrecht <palbrecht@uswest.net>, linux-kernel@vger.kernel.org
References: <002401c2eb78$cca714e0$d5bb0243@oemcomputer> <Pine.LNX.4.44.0303171001030.2571-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303171001030.2571-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, Paul Albrecht wrote:
>> ... Why does the kernel page fault on text pages, present in the page
>> cache, when a program starts? Couldn't the pte's for text present in the
>> page cache be resolved when they're mapped to memory?

On Mon, Mar 17, 2003 at 10:02:21AM -0500, Rik van Riel wrote:
> The mmap() syscall only sets up the VMA info, it doesn't
> fill in the page tables. That only happens when the process
> page faults.
> Note that filling in a bunch of page table entries mapping
> already present pagecache pages at exec() time might be a
> good idea.  It's just that nobody has gotten around to that
> yet...

SVR4 did and saw an improvement wrt. page fault rate, according to
Vahalia.

I'd like to see whether this is useful for Linux.


-- wli
