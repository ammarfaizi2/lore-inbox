Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWBXJPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWBXJPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWBXJPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:15:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932079AbWBXJPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:15:50 -0500
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <43FEA97D.2000609@yahoo.com.au>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>
	 <200602231041.00566.ak@suse.de> <20060223124152.GA4008@elte.hu>
	 <200602231406.43899.ak@suse.de> <43FDB55E.7090607@yahoo.com.au>
	 <20060223132954.GA16074@elte.hu>  <43FEA97D.2000609@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 10:15:42 +0100
Message-Id: <1140772543.2874.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Arjan, just to get an idea of your workload: obviously it is a mix of
> read and write on the mmap_sem (read only will not really benefit from
> reducing lock width because cacheline transfers will still be there).

yeah it's threads that each allocate, use and then free memory with
mmap()

> Is it coming from brk() from the allocator? Someone told me a while ago
> that glibc doesn't have a decent amount of hysteresis in its allocator
> and tends to enter the kernel quite a lot... that might be something
> to look into.

we already are working on that angle; I just posted the kernel stuff as
a side effect basically 


