Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWJPWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWJPWEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWJPWEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:04:45 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:34524 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161129AbWJPWEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:04:44 -0400
Date: Tue, 17 Oct 2006 00:02:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Sparc64 kernel message: BUG: soft lockup detected on CPU#3!
In-Reply-To: <20061016.135400.112621150.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0610162358270.30479@yvahk01.tjqt.qr>
References: <20061016141127.GB9350@pelagius.h-e-r-e-s-y.com>
 <20061016164124.GC9350@pelagius.h-e-r-e-s-y.com> <20061016.135400.112621150.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >  [0000000000525990] prom_putchar+0x2c/0x34
>> 
>> I wonder; could this be a timeout during boot because the prom console
>> is hardware limited to 9600baud and its buffer is full ??
>
>PROM console is just slower than anything else for whatever
>reason.
>
>Even though PROM console drives the same output, using the
>native CONFIG_SERIAL_SUNHV is much faster and does not generate
>the timeouts.
>
>That's why I told the original poster to simply disable
>CONFIG_PROM_CONSOLE, it should never be used.

I have not seen this soft lockup so far, though I run a 2.6.16, most 
likely using CONFIG_PROM_CONSOLE (redirected to ttya by prom) because
the machine is not a SUN4V (which SUNHV seems to be for).


	-`J'
-- 
