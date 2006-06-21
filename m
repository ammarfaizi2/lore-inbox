Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWFUNxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWFUNxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWFUNxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:53:04 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:4255 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932137AbWFUNxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:53:03 -0400
Date: Wed, 21 Jun 2006 09:49:18 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Roland McGrath <roland@redhat.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Charles P. Wright" <cwright@cs.sunysb.edu>,
       Renzo Davoli <renzo@cs.unibo.it>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [RFC PATCH 0/4] utrace: new modular infrastructure for user debug/tracing
Message-ID: <20060621134918.GA1361@nevyn.them.org>
Mail-Followup-To: "Frank Ch. Eigler" <fche@redhat.com>,
	Roland McGrath <roland@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	"Charles P. Wright" <cwright@cs.sunysb.edu>,
	Renzo Davoli <renzo@cs.unibo.it>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
References: <200606151900_MC3-1-C293-BD30@compuserve.com> <y0mlkrxupqf.fsf@ton.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y0mlkrxupqf.fsf@ton.toronto.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 10:42:00AM -0400, Frank Ch. Eigler wrote:
> Indeed, I like what I see (at least those parts I understand) in
> roland's utrace code.  One missed opportunity bit appears to be any
> new support for something like per-thread breakpoints.
> 
> If I correctly understand how gdb etc. work, a hit breakpoint involves
> stoppage of all other threads of a process, then the breakpoint
> instruction is replaced by the original one, then the thread is
> single-stepped, then the breakpoint is put back, then finally all
> threads are resumed.  Could utrace API provide short-lived per-thread
> page copies to execute the single-stepped original instruction out of,
> and avoid stopping & resuming all other threads?

FYI: I talked with Roland about this a while ago, and got the
impression that he was interested in implementing it, but wanted to get
utrace going first.  It doesn't really relate to utrace; but it would
need a new interface however it was implemented.

GDB really does crave this feature.

-- 
Daniel Jacobowitz
CodeSourcery
