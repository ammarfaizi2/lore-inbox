Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVAXOT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVAXOT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVAXOT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:19:27 -0500
Received: from ozlabs.org ([203.10.76.45]:38083 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261512AbVAXOTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:19:25 -0500
Date: Tue, 25 Jan 2005 00:50:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, akpm@osdl.org, paulus@samba.org,
       tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Problems disabling SYSCTL
Message-ID: <20050124135001.GC27258@krispykreme.ozlabs.ibm.com>
References: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com> <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk> <20050123191743.GB6784@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123191743.GB6784@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is there any reason to not move the sys32_sysctl code to kernel/sysctl.c?
> 
> iirc it relies on a unified address space (= user pointers still
> work in KERNEL_DS) 

Yeah the sys32_sysctl code is pretty awful, perhaps we could do a better
job now we have compat_alloc_userspace.

Anton
