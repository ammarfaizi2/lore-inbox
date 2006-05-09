Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWEIVws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWEIVws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWEIVws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:52:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62402 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751177AbWEIVwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:52:47 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 32/35] Add Xen driver utility functions.
Date: Tue, 9 May 2006 23:50:54 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Jan Beulich <JBeulich@novell.com>,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085200.309814000@sous-sol.org>
In-Reply-To: <20060509085200.309814000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605092350.54692.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 09:00, Chris Wright wrote:
> Allocate/destroy a 'vmalloc' VM area: alloc_vm_area and free_vm_area
> The alloc function ensures that page tables are constructed for the
> region of kernel virtual address space and mapped into init_mm.
> 
> Lock an area so that PTEs are accessible in the current address space:
> lock_vm_area and unlock_vm_area
> The lock function prevents context switches to a lazy mm that doesn't
> have the area mapped into its page tables.  It also ensures that the
> page tables are mapped into the current mm by causing the page fault
> handler to copy the page directory pointers from init_mm into the
> current mm.

Having that in drivers/xen looks wrong.  It should be probably somewhere generic.

-Andi
