Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUKCDH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUKCDH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKCDHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:07:25 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:51137 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261348AbUKCDHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:07:08 -0500
Date: Wed, 3 Nov 2004 04:05:58 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041103030558.GK3571@dualathlon.random>
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random> <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random> <418846E9.1060906@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418846E9.1060906@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 06:48:09PM -0800, Dave Hansen wrote:
> It should be enough, but I don't think we want to waste a bitflag for 
> something that's only needed for debugging anyway.  They're getting 
> precious these days.  Might as well just bloat the kernel some more when 
> the alloc debugging is on.

You can leave the bitflag the end (number 31) under the #ifdef. Using
the bitflag is less likely to create an heisenbug (due different layout
of the ram ;).

> I'll see what I can do to get some backtraces of the __pg_prot(0) &&
> page->mapped cases.

thanks!
