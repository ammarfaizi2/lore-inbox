Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVCOBPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVCOBPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVCOBPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:15:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:34180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVCOBOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:14:54 -0500
Date: Mon, 14 Mar 2005 17:08:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, davidm@hpl.hp.com, hch@lst.de
Subject: Re: Fix irq_affinity write from /proc for IPF
Message-Id: <20050314170826.26c1a7f4.akpm@osdl.org>
In-Reply-To: <20050314162330.A22861@unix-os.sc.intel.com>
References: <20050314155004.A22573@unix-os.sc.intel.com>
	<20050314155923.4847aea3.akpm@osdl.org>
	<20050314162330.A22861@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> > Is it not possible for ia64's ->set_affinity() handler to do this deferring?
> > 
> 
> There are other places where we re-program, and its fine to call the 
> current version of set_affinity directly, like when we are doing cpu offline
> and trying to force migrate irqs for ia64.
> 
> Changing the default set_affinity() for ia64 would result in many changes, 
> this still keeps the same purpose of those access functions, and 
> differentiates the proc write cases alone without changing the meaning 
> of those handler functions. (and a smaller patch)
> 
> this would further complicate the force migrate irq's when we consider 
> MSI interrupts as well. Since it would have its own set_affinity, and we need
> to hack into MSI's set affinity handler as well which would complicate things.

OK, just checking.

I'll include this change in the next batch, probably post-2.6.12-rc1, thanks.
