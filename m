Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVCPSYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVCPSYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVCPSYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:24:23 -0500
Received: from fmr22.intel.com ([143.183.121.14]:7887 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262729AbVCPSXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:23:22 -0500
Date: Wed, 16 Mar 2005 10:22:40 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, rohit.seth@intel.com
Subject: Re: [Patch] x86, x86_64: Intel dual-core detection
Message-ID: <20050316102239.A10250@unix-os.sc.intel.com>
References: <20050315173624.A2100@unix-os.sc.intel.com> <20050316170412.GA51070@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050316170412.GA51070@muc.de>; from ak@muc.de on Wed, Mar 16, 2005 at 06:04:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 06:04:12PM +0100, Andi Kleen wrote:
> On Tue, Mar 15, 2005 at 05:36:25PM -0800, Siddha, Suresh B wrote:
> > It adds two new fields "core id" and "cpu cores" to x86 /proc/cpuinfo
> > and the "core id" field for x86_64("cpu cores" field is already present in
> > x86_64).
> 
> Thanks. I have a similar patch for AMD CPUs, unfortuntely it uses 
> different names ("shared cores" etc.)

2.6.11 already has "cpu cores" for x86_64. I would like to retain that.

> > 
> > This patch also adds cpu_core_map similar to cpu_sibling_map.
> Called cpu_sharecore_map in my patch.

cpu_sharecore_map sounds like HT logical siblings sharing the core. Initially 
I was calling it as cpu_coresibling_map but later thought cpu_core_map is 
a smaller name.

> 
> Hmm, which names should be chosen?

For /proc/cpuinfo, I want to stick with "cpu cores" and "core id"
But I am open for kernel variable names.

Depending on what we decide on kernel variable names, I will see if I have 
to make any changes to the IPF patch we posted last week.

thanks,
suresh
