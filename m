Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUCEXNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUCEXNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:13:10 -0500
Received: from ns.suse.de ([195.135.220.2]:14747 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261463AbUCEXNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:13:08 -0500
To: Stuart_Hayes@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI stack overflow
References: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Mar 2004 00:13:06 +0100
In-Reply-To: <CE41BFEF2481C246A8DE0D2B4DBACF4F128AA1@ausx2kmpc106.aus.amer.dell.com.suse.lists.linux.kernel>
Message-ID: <p731xo651ml.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart_Hayes@Dell.com writes:

> Hello...
> 
> I think I am getting a stack overflow when Linux is parsing the ACPI tables (initializing all the devices and running all the _STA methods).  I am using the x86_64 architecture.  I would like to try increasing the kernel stack size, but I'm not sure how to go about doing this.  Could someone tell me how to increase the kernel stack size?  (And, has anyone else seen a problem with stack overflows with ACPI?)

Increasing THREAD_ORDER to 2 in include/asm-x86_64/page.h should do 
the trick in theory (not tested). There is also an old 2.4 exact stack
overflow checking patch at ftp://ftp.x86-64.org/pub/linux/debug/stackcheck-1
that could be probably ported to newer kernels.

I haven't heard of ACPI stack overflows before.

-Andi
