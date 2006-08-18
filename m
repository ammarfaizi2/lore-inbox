Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWHRPog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWHRPog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWHRPog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:44:36 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:52609
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161035AbWHRPof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:44:35 -0400
Subject: Re: Serial issue
From: Paul Fulghum <paulkf@microgate.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1155862076.24907.5.camel@mindpipe>
References: <1155862076.24907.5.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 10:44:11 -0500
Message-Id: <1155915851.3426.4.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 20:47 -0400, Lee Revell wrote:
> I've found a weird serial bug.  My host is a Via EPIA M-6000 running
> 2.6.17 connected to a PPC Yosemite board running 2.6.13. 
> 
> In all cases the serial console works great.  But, with the default
> setting of IRQ 4, Kermit file transfers via the serial interface simply
> time out.  However if I use polling mode (setserial /dev/ttyS0 irq 0 on
> the host), file transfers work.
> 
> When set to IRQ 4, the interrupt count does increase.
> 
> # cat /proc/tty/driver/serial 
> serinfo:1.0 driver revision:
> 0: uart:16550A port:000003F8 irq:4 tx:267 rx:667 DSR|CD
> [...]
> 
> Any ideas?  I'm guessing it might be a quirk of the VIA chipset?

You mention serial console. Hasn't there been some changes
related to reenabling the THRE interrupt after sending
console data? IIRC the changes fixed transmit stalls on
some machines but broke things on other machine.

Can you try disabling the serial console and see
if the file transfer starts working?

-- 
Paul Fulghum
Microgate Systems, Ltd

