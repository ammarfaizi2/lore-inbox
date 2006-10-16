Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWJPUyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWJPUyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWJPUyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:54:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52898
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161066AbWJPUx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:53:59 -0400
Date: Mon, 16 Oct 2006 13:54:00 -0700 (PDT)
Message-Id: <20061016.135400.112621150.davem@davemloft.net>
To: andrew@walrond.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061016164124.GC9350@pelagius.h-e-r-e-s-y.com>
References: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
	<20061016164124.GC9350@pelagius.h-e-r-e-s-y.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: andrew@walrond.org
Date: Mon, 16 Oct 2006 16:41:24 +0000

> 
> >  [0000000000525990] prom_putchar+0x2c/0x34
> 
> I wonder; could this be a timeout during boot because the prom console
> is hardware limited to 9600baud and its buffer is full ??

PROM console is just slower than anything else for whatever
reason.

Even though PROM console drives the same output, using the
native CONFIG_SERIAL_SUNHV is much faster and does not generate
the timeouts.

That's why I told the original poster to simply disable
CONFIG_PROM_CONSOLE, it should never be used.
