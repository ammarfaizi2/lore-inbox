Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUF0WeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUF0WeI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 18:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUF0WeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 18:34:08 -0400
Received: from ozlabs.org ([203.10.76.45]:1770 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264522AbUF0WeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 18:34:06 -0400
Date: Mon, 28 Jun 2004 08:28:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] __alloc_bootmem_node should not panic when it fails
Message-ID: <20040627222803.GH23589@krispykreme>
References: <20040627052747.GG23589@krispykreme> <200406270827.28310.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406270827.28310.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But allocating from other nodes has performance implications, which
> might be quite big, depending on the specific architecture. So you
> should at least print an KERN_INFO or even KERN_WARNING message, 
> if this happens.

...

> So now the user knows what is going on and that this node might need
> more memory ;-)

Unfortunately nodes without memory is relatively common on ppc64, and I
believe x86-64. From a ppc64 perspective Im fine with best effort, perhaps
someone from the heavily NUMA camp (ia64?) could comment.

Anton
