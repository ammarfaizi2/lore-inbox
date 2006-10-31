Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965524AbWJaHWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965524AbWJaHWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965525AbWJaHWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:22:09 -0500
Received: from junsun.net ([66.29.16.26]:58122 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S965524AbWJaHWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:22:07 -0500
Date: Mon, 30 Oct 2006 23:22:03 -0800
From: Jun Sun <jsun@junsun.net>
To: linux-kernel@vger.kernel.org
Subject: reserve memory in low physical address - possible?
Message-ID: <20061031072203.GA10744@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This question is specific to i386 architecture.  While I am fairly 
comfortable with Linux kernel, I am not familiar with i386 arch. 

My objective is to reserve, or hide from kernel, some memory space in low
physical address range starting from 0.  The memory amount is in the order
of 100MB to 200MB.  The total memory is assumed to be around 512MB.

Is this possible?

I understand it is possible to reserve some memory at the end by
specifying "mem=xxxM" option in kernel command line.  I looked into
"memmap=xxxM" option but it appears not helpful for what I want.

While searching on the web I also found things like DMA zone and loaders
etc that all seem to assume the existence low-addressed physical
memory.  True?

I can certainly workaround the loader issue.  I can also re-code the real-mode
part of kernel code to migrate to higher addresses.  The DMA zone might be
a thorny one.  Any clues?  Are modern PCs still subject to
the 16MB DMA zone restriction?

Am I too far off from what I want to do?

Thanks.

Jun
