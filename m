Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWIFJDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWIFJDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIFJDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:03:55 -0400
Received: from buick.jordet.net ([193.91.240.190]:29110 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1750716AbWIFJDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:03:54 -0400
Message-ID: <44FE8EBA.4060104@jordet.net>
Date: Wed, 06 Sep 2006 11:02:50 +0200
From: Stian Jordet <liste@jordet.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: akpm@osdl.org, sergio@sergiomb.no-ip.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru
Subject: Re: [NEW PATCH] VIA IRQ quirk behaviour change
References: <20060906020429.6ECE67B40A0@zog.reactivated.net>
In-Reply-To: <20060906020429.6ECE67B40A0@zog.reactivated.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Stian Jordet: You're on CC due to a discussion linked to from above where
> it appeared that you needed Bjorn's patch. Please test this patch against
> unmodified 2.6.17 or 2.6.18-rc and let us know if there are any problems.
> 
No more usb for me with this patch :P

When usb is loaded I get this in dmesg:

irq 9: nobody cared (try booting with the "irqpoll" option)
  [<c01302d3>] __report_bad_irq+0x2b/0x69
  [<c01304bd>] note_interrupt+0x1ac/0x1e3
  [<c0246175>] acpi_irq+0xb/0x14
  [<c012fadb>] handle_IRQ_event+0x23/0x49
  [<c012fbb3>] __do_IRQ+0xb2/0xe6
  [<c0104b3d>] do_IRQ+0x43/0x52
  [<c01031ea>] common_interrupt+0x1a/0x20
  [<c0101620>] default_idle+0x0/0x59
  [<c0101651>] default_idle+0x31/0x59
  [<c01016d7>] cpu_idle+0x5e/0x74
  [<c053d6d7>] start_kernel+0x353/0x35a
handlers:
[<c024616a>] (acpi_irq+0x0/0x14)
Disabling IRQ #9

and while USB has the same irq in /proc/interrupts now as earlier, usb 
doesn't work (or sometimes it does, just dog slow!). Acpi is of course 
disabled, so no acpi events neither.

I have to admit, that this computer have some weird behaviour - see 
http://bugzilla.kernel.org/show_bug.cgi?id=2874 - but still, it's been 
working well for many years now, before this patch. While I do 
understand that I seem to be the only one affected by this bug, I hope 
someone will help me look into another way to solve my problems if this 
patch get applied.

Thanks.

-Stian
