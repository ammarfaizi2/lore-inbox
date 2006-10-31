Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423465AbWJaPOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423465AbWJaPOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423482AbWJaPOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:14:24 -0500
Received: from junsun.net ([66.29.16.26]:9483 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1423465AbWJaPOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:14:23 -0500
Date: Tue, 31 Oct 2006 07:14:09 -0800
From: Jun Sun <jsun@junsun.net>
To: Mark Hounschell <markh@compro.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reserve memory in low physical address - possible?
Message-ID: <20061031151409.GB14272@srv.junsun.net>
References: <20061031072203.GA10744@srv.junsun.net> <45474585.2070607@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45474585.2070607@compro.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 07:45:57AM -0500, Mark Hounschell wrote:
> Jun Sun wrote:
> > This question is specific to i386 architecture.  While I am fairly 
> > comfortable with Linux kernel, I am not familiar with i386 arch. 
> > 
> > My objective is to reserve, or hide from kernel, some memory space in low
> > physical address range starting from 0.  The memory amount is in the order
> > of 100MB to 200MB.  The total memory is assumed to be around 512MB.
> > 
> > Is this possible?
> > 
> > I understand it is possible to reserve some memory at the end by
> > specifying "mem=xxxM" option in kernel command line.  I looked into
> > "memmap=xxxM" option but it appears not helpful for what I want.
> > 
> > While searching on the web I also found things like DMA zone and loaders
> > etc that all seem to assume the existence low-addressed physical
> > memory.  True?
> > 
> > I can certainly workaround the loader issue.  I can also re-code the real-mode
> > part of kernel code to migrate to higher addresses.  The DMA zone might be
> > a thorny one.  Any clues?  Are modern PCs still subject to
> > the 16MB DMA zone restriction?
> > 
> > Am I too far off from what I want to do?
> > 
> > Thanks.
> > 
> > Jun
> 
> Maybe the bigphysarea patch is what you want?
>

I took a look.  The patch will allocate (actually pre-allocate) a big chunk
at boot time, which is arguably more friendly to MM subsystem.  However,
you cannot specify the location of the memory chunk which is what I want.

Thanks.

Jun
