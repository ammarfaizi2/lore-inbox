Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVCPREQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVCPREQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVCPREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:04:16 -0500
Received: from colin2.muc.de ([193.149.48.15]:7947 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261308AbVCPREN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:04:13 -0500
Date: 16 Mar 2005 18:04:12 +0100
Date: Wed, 16 Mar 2005 18:04:12 +0100
From: Andi Kleen <ak@muc.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rohit.seth@intel.com
Subject: Re: [Patch] x86, x86_64: Intel dual-core detection
Message-ID: <20050316170412.GA51070@muc.de>
References: <20050315173624.A2100@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315173624.A2100@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 05:36:25PM -0800, Siddha, Suresh B wrote:
> Appended patch adds the support for Intel dual-core detection and displaying
> the core related information in /proc/cpuinfo. 
> 
> It adds two new fields "core id" and "cpu cores" to x86 /proc/cpuinfo
> and the "core id" field for x86_64("cpu cores" field is already present in
> x86_64).

Thanks. I have a similar patch for AMD CPUs, unfortuntely it uses 
different names ("shared cores" etc.)
> 
> Number of processor cores in a die is detected using cpuid(4) and this
> is documented in IA-32 Intel Architecture Software Developer's Manual (vol 2a)
> (http://developer.intel.com/design/pentium4/manuals/index_new.htm#sdm_vol2a)
> 
> This patch also adds cpu_core_map similar to cpu_sibling_map.
Called cpu_sharecore_map in my patch.

Hmm, which names should be chosen?
-Andi
