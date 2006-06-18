Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWFRGMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWFRGMn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWFRGMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:12:43 -0400
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:44675 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751100AbWFRGMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:12:42 -0400
Date: Sun, 18 Jun 2006 02:07:54 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 11/16] 2.6.17-rc6 perfmon2 patch for review: new
  i386 files
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephane Eranian <eranian@hpl.hp.com>
Message-ID: <200606180210_MC3-1-C2BF-E5CE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606150907.k5F97e7A008202@frankl.hpl.hp.com>

On Thu, 15 Jun 2006 02:07:40 -0700, Stephane Eranian wrote:

> This patch contains the new i386 files
> 
> 
> 
> 
> --- linux-2.6.17-rc6.orig/arch/i386/perfmon/Kconfig   1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-rc6/arch/i386/perfmon/Kconfig        2006-06-13 06:58:08.000000000 -0700
> @@ -0,0 +1,48 @@
> +menu "Hardware Performance Monitoring support"
> +config PERFMON
> +     bool "Perfmon2 performance monitoring interface"
> +     select X86_LOCAL_APIC
> +     default y
> +     help
> +       include the perfmon2 performance monitoring interface
> +       in the kernel. See <http://perfmon2.sf.net/> for
> +       more details. If you're unsure, say Y.
> +
> + config PERFMON_P6
> +     tristate "Support for P6/Pentium M processor hardware performance counters"
> +     depends on PERFMON
> +     default m
> +     help
> +     Enables support for the P6-style hardware performance counters.
> +     To be used for P6 processors (Pentium III, PentiumPro) and also
> +     for Pentium M.
> +     If unsure, say M.
> +
> +config PERFMON_P4
> +     tristate "Support for 32-bit P4/Xeon hardware performance counters"
> +     depends on PERFMON
> +     default m
> +     help
> +     Enables support for the 32-bit P4/Xeon style hardware performance
> +     counters.
> +     If unsure, say M.
> +
> +config PERFMON_GEN_IA32
> +     tristate "Support for the architected IA-32 PMU"
> +     depends on PERFMON
> +     default m
> +     help
> +     Enables support for the architected IA-32 hardware performance counters.
> +     You need a Core Duo/Solo processor or newer for this work.
> +     If unsure, say M.
> +
> +config PERFMON_P4_PEBS
> +     tristate "Support for Intel P4 PEBS sampling format"
> +     depends on PERFMON_P4
> +     default m
> +     help
> +     Enables support for Precise Event-Based Sampling (PEBS) on the Intel P4
> +     processors which support it.  Does not work with P6 processors.
> +     If unsure, say m.
> +
> +endmenu

What do I pick for i386 kernel on Athlon64 hardware?  P6?  There's no help for
that (or Athlon/Sempron processors.)
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
