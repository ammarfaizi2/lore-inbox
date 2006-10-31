Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423492AbWJaPk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423492AbWJaPk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423495AbWJaPk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:40:27 -0500
Received: from junsun.net ([66.29.16.26]:9995 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1423492AbWJaPk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:40:27 -0500
Date: Tue, 31 Oct 2006 07:40:19 -0800
From: Jun Sun <jsun@junsun.net>
To: "Richard B. Johnson" <jmodem@abominablefirebug.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reserve memory in low physical address - possible?
Message-ID: <20061031154019.GC14272@srv.junsun.net>
References: <20061031072203.GA10744@srv.junsun.net> <02f201c6fce8$a660ece0$0732700a@djlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f201c6fce8$a660ece0$0732700a@djlaptop>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 07:32:37AM -0500, Richard B. Johnson wrote:
> 
> You will not be able to reserve any address space starting at 0 anyway, but 
> your driver or even
> user-space code can memory-map it.
> 

Any reasons or concerns as to why I can't reserve any address space 
starting from 0?

To make my motivation clearer, here is the application scenario.

My system will load an initial OS (could be a strip down Linux or some
simple RTOS) into the low memory starting from address 0.  The initial OS
will then load Linux into higher memory region, say @100M.  Then control jumps
to Linux while the initial OS is still lurking in the RAM for future
use.

> Some early (ISA) boards couldn't access address-space beyoond 16 megabytes, 
> hense the "low" memory
> for DMA.
> 

So if I don't have ISA performing DMA, I should be OK in this regard?

Thanks.

Jun
