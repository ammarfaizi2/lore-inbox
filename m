Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVAMS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVAMS3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVAMSZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:25:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:55267 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261348AbVAMSYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:24:22 -0500
Date: Thu, 13 Jan 2005 10:24:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       clameter@sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for prep_zero_page
Message-ID: <20050113102420.A469@build.pdx.osdl.net>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org> <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com> <20050109125212.330c34c1.akpm@osdl.org> <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com> <20050109144840.W2357@build.pdx.osdl.net> <Pine.LNX.4.61.0501092117040.20477@montezuma.fsmlabs.com> <Pine.LNX.4.61.0501122203350.4941@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501122203350.4941@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Wed, Jan 12, 2005 at 10:05:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> It looks like it's still not happy with CONFIG_DEBUG_PAGEALLOC under load.
> 
> Unable to handle kernel paging request at virtual address ec5d97f4

Is that in vmalloc space?

>  printing eip:
> c014a882
> *pde = 0083e067
> Oops: 0000 [#1]
> PREEMPT SMP DEBUG_PAGEALLOC
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c014a882>]    Not tainted VLI
> EFLAGS: 00010002   (2.6.10-mm2)
> EIP is at check_slabuse+0x52/0xf0

Hmm, isn't that from Manfred's patch to periodically scan?  Doesn't look
to me like it's related to the page prep fixup.  What kind of load, etc?

thanks,
-chris
