Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWF2LxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWF2LxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWF2LxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:53:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15625 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964791AbWF2LxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:53:12 -0400
Date: Thu, 29 Jun 2006 12:53:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Milan Svoboda <msvoboda@ra.rockwell.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
Message-ID: <20060629115301.GA9709@flint.arm.linux.org.uk>
Mail-Followup-To: Milan Svoboda <msvoboda@ra.rockwell.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Esben Nielsen <nielsen.esben@googlemail.com>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 12:17:50PM +0200, Milan Svoboda wrote:
> BUG: scheduling with irqs disabled: softirq-net-rx//0x00000000/6
> caller is schedule+0x10/0x114
> [<c0024e24>] (dump_stack+0x0/0x28) from [<c01ae528>] (schedule+0xf8/0x114)
> [<c01ae430>] (schedule+0x0/0x114) from [<c01afb60>] 
> (rt_lock_slowlock+0x100/0x240)
>  r5 = C01F070C  r4 = C4150000
> [<c01afa60>] (rt_lock_slowlock+0x0/0x240) from [<c01aff28>] 
> (__lock_text_start+0x18/0x1c)
> [<c01aff10>] (__lock_text_start+0x0/0x1c) from [<c0078b08>] 
> (kfree+0x2c/0x84)
> [<c0078adc>] (kfree+0x0/0x84) from [<c002aab0>] 
> (dma_unmap_single+0x110/0x1a8)
>  r5 = C4124BE0  r4 = C7C4B6E0
> [<c002a9a0>] (dma_unmap_single+0x0/0x1a8) from [<c012766c>] 
> (e100_poll+0x2e0/0x59c)

Might be fixed in the latest kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
