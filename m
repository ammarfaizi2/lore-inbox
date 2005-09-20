Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbVITGcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbVITGcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVITGcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:32:33 -0400
Received: from are.twiddle.net ([64.81.246.98]:44700 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S932739AbVITGcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:32:32 -0400
Date: Mon, 19 Sep 2005 23:31:58 -0700
From: Richard Henderson <rth@twiddle.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Willy Tarreau <willy@w.ods.org>, Robert Love <rml@novell.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050920063158.GA3171@twiddle.net>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Willy Tarreau <willy@w.ods.org>, Robert Love <rml@novell.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> <20050918174549.GN19626@ftp.linux.org.uk> <Pine.LNX.4.61.0509182222030.3743@scrub.home> <20050918211225.GP19626@ftp.linux.org.uk> <20050918215257.GA29417@ftp.linux.org.uk> <Pine.LNX.4.58.0509181513440.9106@g5.osdl.org> <20050918230733.GA29869@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918230733.GA29869@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 12:07:33AM +0100, Al Viro wrote:
> What's happening might be (and no, I haven't looked into the gcc codegenerator
> yet) as simple as too early conversion of assignment to memcpy() call, losing
> the "we don't really use the address of this sucker after initialization"
> in process.

Not quite.  But failure to copy-propagate structures is a known problem.
It's on the to-do list.  Hopefully the improved alias analysis to be done
for gcc 4.2 will make this task not suck.

*shrug*


r~
