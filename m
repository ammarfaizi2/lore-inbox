Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031369AbWKUT7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031369AbWKUT7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031372AbWKUT7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:59:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44201 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031370AbWKUT7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:59:15 -0500
Date: Tue, 21 Nov 2006 20:04:47 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Ray Lee <ray-lk@madrabbit.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
Message-ID: <20061121200447.25152d2e@localhost.localdomain>
In-Reply-To: <200611211931.53802.ak@suse.de>
References: <455B63EC.8070704@madrabbit.org>
	<200611211746.39173.ak@suse.de>
	<20061121182726.7d31451f@localhost.localdomain>
	<200611211931.53802.ak@suse.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it did like you're recommending a huge number of drivers
> in the tree wouldn't work anymore (just think about what pci_alloc_consistent
> does) 

There are very few drivers who actually request less than 32bit DMA
and those would (and should) fail or be forced to do their own fallbacks.

Alan
