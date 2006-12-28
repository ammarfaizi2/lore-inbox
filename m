Return-Path: <linux-kernel-owner+w=401wt.eu-S1753653AbWL1SpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbWL1SpR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754924AbWL1SpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:45:17 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2471 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbWL1SpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:45:15 -0500
Date: Thu, 28 Dec 2006 18:44:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       David Miller <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228184440.GC20596@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Gordon Farquharson <gordonfarquharson@gmail.com>,
	David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
	tbm@cyrius.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com> <20061228101311.GA9672@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612280917000.4473@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612280917000.4473@woody.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 09:27:12AM -0800, Linus Torvalds wrote:
> On Thu, 28 Dec 2006, Russell King wrote:
> > and if you look at glibc's memset() function, you'll notice that's exactly
> > what you expect if you pass a non-8bit value to it.  Ergo, what you're
> > seeing is utterly expected given glibc's memset() implementation on ARM.
> 
> Guys, you _really_ should fix memset(). What you describe is a _bug_. 

Yup, but I have nothing to do with glibc because I refuse to do that
silly copyright assignment FSF thing.  Hopefully someone else can
resolve it, but...

> > Fixing Linus' test program to pass nr & 255 to memset
> 
> No. I'm almost certain that that is not a "fix", it's a workaround for a 
> serious bug in your glibc crap.

_is_ a fix whether _you_ like it or not to work around the issue so
people can at least run your test program.  I'm not saying it's a
proper fix though.

Of course, if you prefer to be mislead by incorrect bug reports...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
