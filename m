Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWAIRl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWAIRl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWAIRl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:41:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45281 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030210AbWAIRlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:41:53 -0500
From: Russ Anderson <rja@efs.americas.sgi.com>
Message-Id: <200601091741.k09Hf4gI477712@efs.americas.sgi.com>
Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
To: yanmin.zhang@intel.com (Zhang, Yanmin)
Date: Mon, 9 Jan 2006 11:41:03 -0600 (CST)
Cc: ntl@pobox.com (Nathan Lynch), ymzhang@unix-os.sc.intel.com (Yanmin Zhang),
       greg@kroah.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, suresh.b.siddha@intel.com (Siddha Suresh B),
       rajesh.shah@intel.com (Shah Rajesh),
       venkatesh.pallipadi@intel.com (Pallipadi Venkatesh)
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E840469321C@pdsmsx404> from "Zhang, Yanmin" at Jan 09, 2006 02:35:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote:
> 
> >>In practice does the division of bits between core and thread in the
> >>apic id differ between cpus in the same system?
>
> 2) On ia64, ia64 manual says that cpu physical id/core id/thread id are got by pal call. It doesn't mention how to divide apic id to get physical id/core id/thread id.

The socket_id, core_id, and thread_id are part of cpuinfo_ia64.
They are set up in arch/ia64/kernel/smpboot.c: identify_siblings()

You cannot make assumptions about "the division of bits", but must rely on
the values returned by pal.


-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
