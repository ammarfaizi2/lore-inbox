Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVCaK5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCaK5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCaK5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:57:19 -0500
Received: from cantor.suse.de ([195.135.220.2]:57755 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261266AbVCaK5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:57:15 -0500
Date: Thu, 31 Mar 2005 12:57:03 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
Message-ID: <20050331105703.GK1623@wotan.suse.de>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> <20050324122637.GK895@wotan.suse.de> <Pine.LNX.4.61.0503292233080.18131@goblin.wat.veritas.com> <20050330150813.GF28472@wotan.suse.de> <Pine.LNX.4.61.0503301804240.21508@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503301804240.21508@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok. I will change it to a VMA.
> 
> Thanks.  (It's only the 32-bit emulation case I'm caring about,

I did the patch now and it works, but due to some technical problems I can only
upload it next week. Surprisingly the new code is actually shorter
than the old one and cleaner too.

> that poses a problem for free_pgtables: I'm not sure whether you're
> meaning to VMA-ize the 64-bit one too, that's entirely up to you.)

64bit is beyond __PAGE_OFFSET and mapped by the kernel, there are no page 
tables to free. I dont see any sense in making it a VMA.


-Andi
