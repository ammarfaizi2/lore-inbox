Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWFTJnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWFTJnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFTJnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:43:47 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34691 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S932398AbWFTJnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:43:47 -0400
Date: Tue, 20 Jun 2006 02:42:39 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.21
Message-ID: <20060620094239.GC23467@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.21 kernel.
This has a couple local DoS fixes, and a SCTP fix.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.20 and 2.6.16.21, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                        |    2 -
 arch/powerpc/kernel/signal_32.c |   11 ++++++++-
 arch/powerpc/kernel/signal_64.c |    2 +
 kernel/exit.c                   |    8 -------
 kernel/posix-cpu-timers.c       |   45 +++++++++++++++++++---------------------
 net/netfilter/xt_sctp.c         |    2 -
 6 files changed, 36 insertions(+), 34 deletions(-)

Summary of changes from v2.6.16.20 to v2.6.16.21
================================================

Chris Wright:
      Linux 2.6.16.21

Oleg Nesterov:
      check_process_timers: fix possible lockup
      run_posix_cpu_timers: remove a bogus BUG_ON() (CVE-2006-2445)

Patrick McHardy:
      xt_sctp: fix endless loop caused by 0 chunk length (CVE-2006-3085)

Paul Mackerras:
      powerpc: Fix machine check problem on 32-bit kernels (CVE-2006-2448)

