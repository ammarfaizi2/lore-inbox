Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWFOXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWFOXDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWFOXDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 19:03:51 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:49794 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750736AbWFOXDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 19:03:50 -0400
Date: Thu, 15 Jun 2006 18:58:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC PATCH 0/4] utrace: new modular infrastructure for
  user debug/tracing
To: Roland McGrath <roland@redhat.com>
Cc: "Charles P. Wright" <cwright@cs.sunysb.edu>,
       Renzo Davoli <renzo@cs.unibo.it>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Message-ID: <200606151900_MC3-1-C293-BD30@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060613231000.38B76180072@magilla.sf.frob.com>

On Tue, 13 Jun 2006 16:10:00 -0700, Roland McGrath wrote:

> I have been working on for a while, and imagining for much longer,
> replacing ptrace from the ground up.  This is what I've come up with so
> far, and I'm looking for some reactions on the direction.

At least three different sets of people want to extend the syscall
tracing.  Jeff Dike posted a patch that lets you supply a bitmask of
syscalls to trace.  Renzo Davoli posted one that lets you decide, after
trapping entrance to a syscall, whether to skip the trap that would
normally be done on exit from the same call.  Charles P. Wright also
had a similar patch.  I think this needs to be done at the utrace
level -- a tracing engine couldn't add that on its own (could it?)

Renzo Davoli also posted a patch to allow "batching" of ptrace requests
and Systemptap really needs this, too.  AFAICT this can be done by writing
a custom engine.

And BTW patches 1 and 2 never made it to the list.  The ones on your
server (http://redhat.com/~roland/utrace/) don't apply cleanly due to
whitespace damage but that can be fixed by stripping trailing whitespace
from the kernel files patch(1) complains about.

-- 
Chuck
