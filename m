Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUBRAdY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBRAdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:33:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:4325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266815AbUBRAb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:31:26 -0500
Date: Tue, 17 Feb 2004 16:33:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-Id: <20040217163312.729c951f.akpm@osdl.org>
In-Reply-To: <20040218000315.GN16881@smtp.west.cox.net>
References: <20040217220249.GB16881@smtp.west.cox.net>
	<20040217155036.33e37c67.akpm@osdl.org>
	<20040218000315.GN16881@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> By my read of Andi's email, the kern_do_schedule() gunk is "I really
> don't like this change. It is completely useless because you can get the
> pt_regs as well from the stack.  Please don't add it. George's stub also
> didn't need it."
> 
> But I don't see how it does.  But I'll look again tomorrow.

OK, thanks.  That would be appreciated, if only because the sched.c and
entry.S changes have caused significant patch-conflict hassles in the past,
and they're pretty ugly.

Plus the little fact that the patch which you sent broke all other
architectures: they call schedule() from assembly code, and schedule()
ain't there any more.

I'll have a play with the patches which you sent, and if they don't break
I'll add them to -mm and I'll kludgily fix ppc64 and ia64 (if needed).  Be
aware that I removed the (large amount of) trailing whitespace which they
added.

