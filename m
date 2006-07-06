Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWGFPJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWGFPJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGFPJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:09:37 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:42659 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030300AbWGFPJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:09:36 -0400
Date: Thu, 6 Jul 2006 08:01:18 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: perfmon@napali.hpl.hp.com, Stephane Eranian <eranian@hpl.hp.com>
Subject: cpuinfo_x86 and apicid
Message-ID: <20060706150118.GB10110@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


In the context of the perfmon2 subsystem for processor with HyperThreading,
we need to know on which thread we are currently running. This comes from
the fact that the performance counters are shared between the two threads.

We use the thread id (smt_id) because we split the counters in half
between the two threads such that two threads on the same core can run
with monitoring on.  We are currently computing the smt_id from the
apicid as returned by a CPUID instruction. This is not very efficient.

I looked through the i386 code and could not find a function nor 
structure that would return this smt_id. In the cpuinfo_x86 structure
there is an apicid field that looks good, yet it does not seem to be
initialized nor used.

Is cpuinfo_x86->apicid field obsolete? 
If so, what is replacing it?

Thanks.

-- 
-Stephane
