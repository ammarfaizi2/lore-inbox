Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUGETCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUGETCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUGETCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:02:42 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:52698 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S266163AbUGETC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:02:29 -0400
Subject: Re: 2.6.7-mm6
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089049369.2483.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 21:04:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 11:31, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
> 
> - Added the DVD-RW/CD-RW packet writing patches.  These need more work.
> 
> - The USB update seems deadlocky.  I fixed one bug but it still causes my
>   ia64 test box to lock up on boot.  If it goes bad, please revert
>   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a report
>   to linux-kernel and linux-usb-devel@lists.sourceforge.net.
> 
OK, a quick test reveals that my EHCI controller still doesn't work
properly but unplugging the USB 2.0 stick doesn't result in a oops
anymore...

The message remains the same:

<snip>
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: can't reset
ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
ehci_hcd: probe of 0000:00:1d.7 failed with error -95
<snip>

Jurgen


