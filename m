Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWJFSCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWJFSCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJFSCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:02:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13972 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932107AbWJFSCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:02:23 -0400
Date: Fri, 6 Oct 2006 11:01:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <20061006164211.GA15321@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610061055490.3952@g5.osdl.org>
References: <20061002132116.2663d7a3.akpm@osdl.org>
 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
 <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
 <20061006164211.GA15321@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Russell King wrote:
> 
> If it's obvious and trivial, it should be easy for anyone to fix, even
> the person who broke it.  Especially as there are build logs automatically
> generated for every -git tree at http://armlinux.simtec.co.uk/kautobuild/

Ok, I just committed a rough first cut at fixing up arm/.

I don't have a cross-build environment, and am too lazy to set one up, but 
that should likely fix 99% of the issues, and any missing things should be 
fairly obvious from the compiler warnings and errors that are bound to 
remain.

Somebody with an arm environment, please test and send in any remaining 
missing parts, and we'll get it all sorted out long before rmk comes back 
from holidays ;)

		Linus
