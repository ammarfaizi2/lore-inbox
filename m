Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbTD1QsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbTD1QsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:48:23 -0400
Received: from ns.suse.de ([213.95.15.193]:3859 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261209AbTD1QsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:48:22 -0400
To: Jeffrey Baker <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia32 kernel on amd64 box?
References: <20030428164248.GA25416@heat.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Apr 2003 19:00:35 +0200
In-Reply-To: <20030428164248.GA25416@heat.suse.lists.linux.kernel>
Message-ID: <p73znma36bw.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Baker <jwbaker@acm.org> writes:

> I was wondering the same thing about peripherals.  The
> README in aic79xx driver from adaptec states that the driver
> is supported on x86 only.  So I was wary to spec model 39320
> HBAs in x86-64 machines.  I'm sure Adaptec is using the term
> "support" in the most corporate sense possible, but what if
> it really does scribble the disk under SuSE 64-bit kernel?

The AIC 7xxx driver works fine. It should work on the same hardware as
79xx. 

The biggest AMD64 issue with drivers is normally IOMMU support, but
that only needs to concern you when you have more than 4GB of memory
and the hardware does not support 64bit Addresses. The Adaptec 
hardware supports 64bit addresses.

What's a problem is the "Adaptec RAID" - which uses the dpt_i2o driver.
That driver is not 64bit safe and doesn't work and is disabled.

-Andi
