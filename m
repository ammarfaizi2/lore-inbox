Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVBRKEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVBRKEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 05:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVBRKEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 05:04:11 -0500
Received: from one.firstfloor.org ([213.235.205.2]:12942 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261169AbVBRKEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 05:04:09 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Sparse Memory Handling (hot-add foundation)
References: <1108685033.6482.38.camel@localhost>
From: Andi Kleen <ak@muc.de>
Date: Fri, 18 Feb 2005 11:04:06 +0100
In-Reply-To: <1108685033.6482.38.camel@localhost> (Dave Hansen's message of
 "Thu, 17 Feb 2005 16:03:53 -0800")
Message-ID: <m1zmy2b2w9.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> The attached patch, largely written by Andy Whitcroft, implements a
> feature which is similar to DISCONTIGMEM, but has some added features.
> Instead of splitting up the mem_map for each NUMA node, this splits it
> up into areas that represent fixed blocks of memory.  This allows
> individual pieces of that memory to be easily added and removed.

[...]

I'm curious - how does this affect .text size for a i386 or x86-64 NUMA
kernel? One area I wanted to improve on x86-64 for a long time was
to shrink the big virt_to_page() etc. inline macros. Your new code
actually looks a bit smaller.

-Andi
