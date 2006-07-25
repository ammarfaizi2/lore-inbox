Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWGYU1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWGYU1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWGYU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:27:46 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:33710 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751562AbWGYU1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:27:45 -0400
Date: Tue, 25 Jul 2006 13:18:45 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 TIF flags for debug regs and io bitmap in ctxsw (v2)
Message-ID: <20060725201845.GH19928@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200607251522_MC3-1-C616-70EB@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607251522_MC3-1-C616-70EB@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Tue, Jul 25, 2006 at 03:19:49PM -0400, Chuck Ebbert wrote:
> 
> > As for TIF_DEBUG, my patch is not clearing it. I don't think you can
> > have HW breakpoints be inherited from one task to the other.
> 
> Looks like the debug regs get copied on fork and only cleared on exec
> in flush_thread().  So this should be OK.  Please doublecheck.
> 
How is this supposed to work? You can set debug registers via ptrace().
So A is ptracing B and sets up breakpoints in B. Now, if B forks C,
C inherits the breakpoints of B. But what about the ptracing and re-parenting
that is associated with this? If A does not know about C, I wonder how this
could be work and be useful?

> (The new TIF_DEBUG flag went into 2.8.18-rc, in case you didn't notice.)

I did not keep track but thanks or this update. That's great!

-- 
-Stephane
