Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWJCEew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWJCEew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbWJCEew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:34:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965147AbWJCEev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:34:51 -0400
Date: Mon, 2 Oct 2006 21:33:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/6] From: Andrew Morton <akpm@osdl.org>
Message-Id: <20061002213347.8229b6fc.akpm@osdl.org>
In-Reply-To: <17697.58794.113796.925995@cargo.ozlabs.ibm.com>
References: <20061003010842.438670755@goop.org>
	<20061003010933.392428107@goop.org>
	<17697.58794.113796.925995@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 14:23:06 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Jeremy Fitzhardinge writes:
> 
> > When my test machine hits a BUG, it simply returns from the exception handler
> > after a second or so and reexecutes the bug.
> > 
> > This is independent of the use-generic-bug changes and might be related to
> > XMON.
> > 
> > So it's some unknonw bug, and this change makes the powerpc kernel behave
> > better when that bug hits.
> 
> NACK as to this part:
> 
> > +			if (btt == BUG_TRAP_TYPE_BUG)
> > +				do_exit(SIGSEGV);
> 
> since it makes the kernel behave distinctly *worse* for me.
> 

It makes it heaps better here.

Did you try my .config on the g5?


