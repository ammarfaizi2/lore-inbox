Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbULNVus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbULNVus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULNVur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:50:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43196 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261683AbULNVua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:50:30 -0500
Date: Tue, 14 Dec 2004 13:50:19 -0800
Message-Id: <200412142150.iBELoJc0011582@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
X-Fcc: ~/Mail/linus
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: Ulrich Drepper's message of  Tuesday, 14 December 2004 13:38:09 -0800 <41BF5D41.6030001@redhat.com>
X-Shopping-List: (1) Lunatic pig potions
   (2) Perfidious dice
   (3) Apocalyptic stoic lieutenant circumcisions
   (4) Comical swindlers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe Christoph may have been referring exclusively to the per-process
clocks, not the per-thread clocks.  I'm not entirely sure since he used the
term "process" exclusively, but quoted my paragraph about the per-thread
clock access.  Ulrich's reply is apropos to the individual thread clocks.

It was about the per-process clocks that I raised the question.  For those,
POSIX says it's implementation-defined what process can see the CPU clock
of another process.  That means we can make it as restricted or as free as
we like, but we are obliged to document up front for the users what the
semantics are.  That's why I would like to make sure we have thought a
little about the choices now, rather than someone coming along later and
deciding we really ought to impose security on it (which might be be
changing the story after developers reasonably coded to the
implementation-defined behavior we documented in the first place).


Thanks,
Roland
