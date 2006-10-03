Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWJCEXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWJCEXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWJCEXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:23:12 -0400
Received: from ozlabs.org ([203.10.76.45]:62120 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965092AbWJCEXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:23:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17697.58794.113796.925995@cargo.ozlabs.ibm.com>
Date: Tue, 3 Oct 2006 14:23:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/6] From: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061003010933.392428107@goop.org>
References: <20061003010842.438670755@goop.org>
	<20061003010933.392428107@goop.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge writes:

> When my test machine hits a BUG, it simply returns from the exception handler
> after a second or so and reexecutes the bug.
> 
> This is independent of the use-generic-bug changes and might be related to
> XMON.
> 
> So it's some unknonw bug, and this change makes the powerpc kernel behave
> better when that bug hits.

NACK as to this part:

> +			if (btt == BUG_TRAP_TYPE_BUG)
> +				do_exit(SIGSEGV);

since it makes the kernel behave distinctly *worse* for me.

Paul.
