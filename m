Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266955AbUBRApo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266968AbUBRAmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:42:23 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:17607 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266152AbUBRAjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:39:24 -0500
Date: Tue, 17 Feb 2004 17:39:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-ID: <20040218003917.GO16881@smtp.west.cox.net>
References: <20040217220249.GB16881@smtp.west.cox.net> <20040217155036.33e37c67.akpm@osdl.org> <20040218000315.GN16881@smtp.west.cox.net> <20040217163312.729c951f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217163312.729c951f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 04:33:12PM -0800, Andrew Morton wrote:
> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > By my read of Andi's email, the kern_do_schedule() gunk is "I really
> > don't like this change. It is completely useless because you can get the
> > pt_regs as well from the stack.  Please don't add it. George's stub also
> > didn't need it."
> > 
> > But I don't see how it does.  But I'll look again tomorrow.
> 
> OK, thanks.  That would be appreciated, if only because the sched.c and
> entry.S changes have caused significant patch-conflict hassles in the past,
> and they're pretty ugly.
> 
> Plus the little fact that the patch which you sent broke all other
> architectures: they call schedule() from assembly code, and schedule()
> ain't there any more.

Oh yeah, that, damnit.

> I'll have a play with the patches which you sent, and if they don't break
> I'll add them to -mm and I'll kludgily fix ppc64 and ia64 (if needed).  Be
> aware that I removed the (large amount of) trailing whitespace which they
> added.

I guess I forgot to Lindent everything.  I'll probably have new drop-in
patches a few more times (as opposed to incremental to the previous) a
few more times, so I'll make sure to fix that for next time.

-- 
Tom Rini
http://gate.crashing.org/~trini/
