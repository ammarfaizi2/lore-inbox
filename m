Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbUCTTCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCTTCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:02:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57048
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263508AbUCTTCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:02:17 -0500
Date: Sat, 20 Mar 2004 20:03:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320190308.GF9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <20040320155739.GQ9009@dualathlon.random> <20040320161538.C6726@flint.arm.linux.org.uk> <20040320162534.GU9009@dualathlon.random> <20040320174857.GA9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320174857.GA9009@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 06:48:57PM +0100, Andrea Arcangeli wrote:
> be needed to hide the bug). This untested patch should make it working
> with non-ram too, so it sounds safer for the short term. I will test it

btw, that works only if NUMA is disabled. there's no way to do
page_to_pfn with a non-ram page with numa enabled since page_zone starts
by reading page->flags, only pte_pfn works (as I found from Martin's
oops).
