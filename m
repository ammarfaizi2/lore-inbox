Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVAWTR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVAWTR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 14:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAWTR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 14:17:57 -0500
Received: from ns.suse.de ([195.135.220.2]:50825 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261343AbVAWTR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 14:17:56 -0500
Date: Sun, 23 Jan 2005 20:17:43 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org, paulus@samba.org,
       tony.luck@intel.com, ak@suse.de, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Problems disabling SYSCTL
Message-ID: <20050123191743.GB6784@wotan.suse.de>
References: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com> <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 02:35:00PM +0000, Matthew Wilcox wrote:
> On Sun, Jan 23, 2005 at 04:01:02PM +1100, Anton Blanchard wrote:
> > Create a cond_syscall for sys32_sysctl and make all architectures use
> > it. Also fix the architectures that dont wrap their 32bit compat sysctl
> > code.
> 
> Is there any reason to not move the sys32_sysctl code to kernel/sysctl.c?

iirc it relies on a unified address space (= user pointers still
work in KERNEL_DS) 

-Andi
