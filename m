Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWHaKka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWHaKka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWHaKka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:40:30 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:60952 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751434AbWHaKka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:40:30 -0400
Date: Thu, 31 Aug 2006 19:35:28 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
Subject: Re: [patch 3/6] fault-injection capability for alloc_pages()
Message-ID: <20060831103528.GA14783@miraclelinux.com>
References: <20060831100756.866727476@localhost.localdomain> <20060831100820.697247381@localhost.localdomain> <200608311225.02101.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608311225.02101.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 12:25:02PM +0200, Andi Kleen wrote:

> I still think this will need some better filters to be useful. At least
> a optional uid filter perhaps (make sure to handle the interrupt case
> correctly, interrupts don't belong to the uid) , and perhaps an option to only 
> fail GFP_ATOMIC.

I wrote process filter. Please patch 6/6. But I forgot to ignore
in_interrupt() case.

> With arbitary failing the system will just be unusable, right? Or would
> you run some system you use this way? @)
> 
> Another possibility would be to look up __builtin_return_address(0) in 
> the module table and allow failing only for a specific module.

That will be useful. Thanks.

