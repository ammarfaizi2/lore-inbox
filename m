Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268966AbTGJGwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 02:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbTGJGwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 02:52:11 -0400
Received: from a3hr6fay45cl.bc.hsia.telus.net ([216.232.206.119]:787 "EHLO
	cyclops.implode.net") by vger.kernel.org with ESMTP id S268992AbTGJGvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 02:51:55 -0400
Date: Thu, 10 Jul 2003 00:06:34 -0700
From: John Wong <kernel@implode.net>
To: linux-kernel@vger.kernel.org
Subject: Re: USB stops working with any of 2.4.22-pre's after 2.4.21
Message-ID: <20030710070634.GA400@gambit.implode.net>
References: <20030710065801.GA351@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710065801.GA351@gambit.implode.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, forgot to mention that I've tried 2.4.22-pre1, pre2, pre3, and
pre4.  All incur this problem.

On Wed, Jul 09, 2003 at 11:58:01PM -0700, John Wong wrote:
> On any of the 2.4.22-pre's, after a bit of time, my USB mouse stops
> responding.  It is using the usb-ohci driver.  2.4.22-pre1 included the
> new ACPI base.  Even before this ACPI was merged into mainstream, I had
> tried patching the system with the newer ACPI on 2.4.21-pre, and rc's
> and I also ran into the same problem that I am now getting with
> 2.4.22-pre's.  I'm suspecting the new ACPI is behind this.  Stopping gpm
> and removing usb-ohci and then reloading it doesn't seem to get it
> working again.  A reboot does the trick.  Strange though is that the one 
> USB 2.0 device I have plugged in still continues to work (at least for a 
> while as I normally reboot when the problem arises) when I start having 
> the problems with USB mouse.  But then, it uses the ehci-hcd driver.
> 
> Some hardware info.  I'm using a nForce2 board with an ATI Radeon video
> card.
> 
> Jul  9 23:39:29 gambit kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jul  9 23:39:29 gambit kernel: eth0: transmit timed out, tx_status 00
> status e601.
> Jul  9 23:39:29 gambit kernel:   diagnostics: net 0cc0 media 8080 dma
> 0000003a.
> Jul  9 23:39:29 gambit kernel: eth0: Interrupt posted but not delivered
> -- IRQ blocked by another device?
> Jul  9 23:39:29 gambit kernel:   Flags; bus-master 1, dirty 5538(2)
> current 5538(2)
> Jul  9 23:39:29 gambit kernel:   Transmit list 00000000 vs. f7c40280.
> Jul  9 23:39:29 gambit kernel:   0: @f7c40200  length 80000036 status
> 80010036
> Jul  9 23:39:29 gambit kernel:   1: @f7c40240  length 80000036 status
> 80010036
> Jul  9 23:39:29 gambit kernel:   2: @f7c40280  length 80000042 status
> 00010042
> Jul  9 23:39:29 gambit kernel:   3: @f7c402c0  length 8000004a status
> 0001004a
> Jul  9 23:39:29 gambit kernel:   4: @f7c40300  length 800005ea status
> 000105ea
> Jul  9 23:39:29 gambit kernel:   5: @f7c40340  length 800001be status
> 000101be
> Jul  9 23:39:29 gambit kernel:   6: @f7c40380  length 800005ea status
> 000105ea
> Jul  9 23:39:29 gambit kernel:   7: @f7c403c0  length 800001be status
> 000101be
> Jul  9 23:39:29 gambit kernel:   8: @f7c40400  length 800001be status
> 000101be
> Jul  9 23:39:29 gambit kernel:   9: @f7c40440  length 800005ea status
> 000105ea
> Jul  9 23:39:29 gambit kernel:   10: @f7c40480  length 8000004a status
> 0001004a
> Jul  9 23:39:29 gambit kernel:   11: @f7c404c0  length 80000187 status
> 00010187
> Jul  9 23:39:29 gambit kernel:   12: @f7c40500  length 8000004a status
> 0001004a
> Jul  9 23:39:29 gambit kernel:   13: @f7c40540  length 80000042 status
> 00010042
> Jul  9 23:39:29 gambit kernel:   14: @f7c40580  length 8000004a status
> 0001004a
> Jul  9 23:39:29 gambit kernel:   15: @f7c405c0  length 8000004a status
> 0001004a
> Jul  9 23:39:29 gambit kernel: eth0: Resetting the Tx ring pointer.
> Jul  9 23:39:44 gambit kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jul  9 23:39:44 gambit kernel: eth0: transmit timed out, tx_status 00
> status e601.
> Jul  9 23:39:44 gambit kernel:   diagnostics: net 0cc0 media 8080 dma
> 0000003a.
> Jul  9 23:39:44 gambit kernel: eth0: Interrupt posted but not delivered
> -- IRQ blocked by another device?
> Jul  9 23:39:44 gambit kernel:   Flags; bus-master 1, dirty 5554(2)
> current 5554(2)
> Jul  9 23:39:44 gambit kernel:   Transmit list 00000000 vs. f7c40280.
> Jul  9 23:39:44 gambit kernel:   0: @f7c40200  length 80000036 status
> 80010036
> Jul  9 23:39:44 gambit kernel:   1: @f7c40240  length 80000036 status
> 80010036
> Jul  9 23:39:44 gambit kernel:   2: @f7c40280  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   3: @f7c402c0  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   4: @f7c40300  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   5: @f7c40340  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   6: @f7c40380  length 80000042 status
> 00010042
> Jul  9 23:39:44 gambit kernel:   7: @f7c403c0  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   8: @f7c40400  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   9: @f7c40440  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   10: @f7c40480  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   11: @f7c404c0  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   12: @f7c40500  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   13: @f7c40540  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   14: @f7c40580  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel:   15: @f7c405c0  length 80000036 status
> 00010036
> Jul  9 23:39:44 gambit kernel: eth0: Resetting the Tx ring pointer.
> Jul  9 23:39:51 gambit kernel: usb-ohci.c: unlink URB timeout
> Jul  9 23:39:54 gambit kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jul  9 23:39:54 gambit kernel: eth0: transmit timed out, tx_status 00
> status e601.
> Jul  9 23:39:54 gambit kernel:   diagnostics: net 0cc0 media 8080 dma
> 0000003a.
> Jul  9 23:39:54 gambit kernel: eth0: Interrupt posted but not delivered
> -- IRQ blocked by another device?
> Jul  9 23:39:54 gambit kernel:   Flags; bus-master 1, dirty 5570(2)
> current 5570(2)
> Jul  9 23:39:54 gambit kernel:   Transmit list 00000000 vs. f7c40280.
> Jul  9 23:39:54 gambit kernel:   0: @f7c40200  length 80000078 status
> 80010078
> Jul  9 23:39:54 gambit kernel:   1: @f7c40240  length 80000036 status
> 80010036
> Jul  9 23:39:54 gambit kernel:   2: @f7c40280  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   3: @f7c402c0  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   4: @f7c40300  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   5: @f7c40340  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   6: @f7c40380  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   7: @f7c403c0  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   8: @f7c40400  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   9: @f7c40440  length 80000078 status
> 00010078
> Jul  9 23:39:54 gambit kernel:   10: @f7c40480  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   11: @f7c404c0  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   12: @f7c40500  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   13: @f7c40540  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel:   15: @f7c405c0  length 80000036 status
> 00010036
> Jul  9 23:39:54 gambit kernel: eth0: Resetting the Tx ring pointer.
> Jul  9 23:40:04 gambit kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jul  9 23:40:04 gambit kernel: eth0: transmit timed out, tx_status 00
> status e601.
> Jul  9 23:40:04 gambit kernel:   diagnostics: net 0cc0 media 8080 dma
> 0000003a.
> Jul  9 23:40:04 gambit kernel: eth0: Interrupt posted but not delivered
> -- IRQ blocked by another device?
> Jul  9 23:40:04 gambit kernel:   Flags; bus-master 1, dirty 5586(2)
> current 5586(2)
> Jul  9 23:40:04 gambit kernel:   Transmit list 00000000 vs. f7c40280.
> Jul  9 23:40:04 gambit kernel:   0: @f7c40200  length 80000036 status
> 80010036
> Jul  9 23:40:04 gambit kernel:   1: @f7c40240  length 80000036 status
> 80010036
> Jul  9 23:40:04 gambit kernel:   2: @f7c40280  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   3: @f7c402c0  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   4: @f7c40300  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   5: @f7c40340  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   6: @f7c40380  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   7: @f7c403c0  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   8: @f7c40400  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   9: @f7c40440  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   10: @f7c40480  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   11: @f7c404c0  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   12: @f7c40500  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   13: @f7c40540  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   14: @f7c40580  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel:   15: @f7c405c0  length 80000036 status
> 00010036
> Jul  9 23:40:04 gambit kernel: eth0: Resetting the Tx ring pointer.
> 
> I am not subscribed to LKML, but I do check the archives regularly.
> 
> John
