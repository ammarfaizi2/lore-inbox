Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTLLEJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 23:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTLLEJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 23:09:23 -0500
Received: from holomorphy.com ([199.26.172.102]:44775 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264470AbTLLEJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 23:09:22 -0500
Date: Thu, 11 Dec 2003 20:09:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] -tiny tree for small systems (2.6.0-test11)
Message-ID: <20031212040918.GM8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20031212033734.GG23787@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212033734.GG23787@waste.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 09:37:34PM -0600, Matt Mackall wrote:
> To get the ball rolling, I've thrown in about 50 patches that trim
> various bits of the kernel, almost all configurable, and a fair number
> may eventually be appropriate for mainline. All the config options are
> currently thrown under CONFIG_EMBEDDED and many of the minor tweaks
> are covered under a set of config options called CONFIG_CORE_SMALL,
> CONFIG_NET_SMALL, and CONFIG_CONSOLE_SMALL.

A small trimming for you:

diff -prauN linux-2.6.0-test11/include/linux/sched.h wli-2.6.0-test11-30/include/linux/sched.h
--- linux-2.6.0-test11/include/linux/sched.h	2003-11-26 12:42:58.000000000 -0800
+++ wli-2.6.0-test11-30/include/linux/sched.h	2003-12-04 08:57:22.000000000 -0800
@@ -205,7 +208,6 @@ struct mm_struct {
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
 	cpumask_t cpu_vm_mask;
-	unsigned long swap_address;
 
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
