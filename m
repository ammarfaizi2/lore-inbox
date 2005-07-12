Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVGLVO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVGLVO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVGLVO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:14:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1219 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262437AbVGLVOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:14:05 -0400
Date: Tue, 12 Jul 2005 16:14:01 -0500
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 07/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050712211401.GF26607@austin.ibm.com>
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB6961.2060508@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CB6961.2060508@jp.fujitsu.com>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:17:21PM +0900, Hidetoshi Seto was heard to remark:
> 
> Touching poisoned data become a MCA, so now it directly means

Several questions: 

Is MCA an exception or fault of some sort, so at some point, 
the kernel would catch a fault?

So when you say "Touching poisoned data become a MCA", you mean that
if the CPU attempts to read poisoned data through the pci-to-host
bridge, it will (at some point) catch an exception?

> +	ia64_mca_barrier(ret);

I assume that the point of this barrier is to make sure that the fault,
if any, is delivered before this routine returns?

--linas

