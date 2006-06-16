Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWFPOml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWFPOml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWFPOmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:42:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9356 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751431AbWFPOmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:42:40 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "Charles P. Wright" <cwright@cs.sunysb.edu>,
       Renzo Davoli <renzo@cs.unibo.it>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [RFC PATCH 0/4] utrace: new modular infrastructure for user debug/tracing
References: <200606151900_MC3-1-C293-BD30@compuserve.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 16 Jun 2006 10:42:00 -0400
In-Reply-To: <200606151900_MC3-1-C293-BD30@compuserve.com>
Message-ID: <y0mlkrxupqf.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chuck Ebbert <76306.1226@compuserve.com> writes:

> [...]  Renzo Davoli also posted a patch to allow "batching" of
> ptrace requests and Systemptap really needs this, too.  AFAICT this
> can be done by writing a custom engine. [...]

Indeed, I like what I see (at least those parts I understand) in
roland's utrace code.  One missed opportunity bit appears to be any
new support for something like per-thread breakpoints.

If I correctly understand how gdb etc. work, a hit breakpoint involves
stoppage of all other threads of a process, then the breakpoint
instruction is replaced by the original one, then the thread is
single-stepped, then the breakpoint is put back, then finally all
threads are resumed.  Could utrace API provide short-lived per-thread
page copies to execute the single-stepped original instruction out of,
and avoid stopping & resuming all other threads?

- FChE
