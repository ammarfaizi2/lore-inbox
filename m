Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUGESeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUGESeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUGESeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:34:03 -0400
Received: from fmr99.intel.com ([192.55.52.32]:50601 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266324AbUGESeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:34:00 -0400
Subject: Re: rtc: IRQ 0 is not free.
From: Len Brown <len.brown@intel.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FEF2D@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FEF2D@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089052420.15675.21.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 14:33:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-27 at 10:26, Meelis Roos wrote:
> Latest 2.6.7+BK doe not enable the builtin RTC timer on my PC, dmesg
> shows only this:
> 
> rtc: IRQ 0 is not free.
> 
> I don't know when it actually broke since I don't depend on rtc so
> much that I would notice it breaking easyly.

it would be good if you could verify that vanilla 2.6.7 puts
rtc on IRQ8 properly for this box.

> dmesg and config are also below.

got the config, but the dmesg didn't come through, can you re-send it?

> lspnp -v shows
> 
> 03 PNP0b00 AT real-time clock
>         irq 8
>         io 0x0070-0x0071

hmmm, had never heard of lspnp (and neither does my local system)

> 
> /proc/interrupts:
> 
>            CPU0
>   0:   81450505          XT-PIC  timer
>   1:       6977          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>  10:   11071042          XT-PIC  VIA686A, uhci_hcd, uhci_hcd, eth1,
> mga@PCI:1:0:0
>  11:      36704          XT-PIC  acpi, bttv0, Ensoniq AudioPCI, Bt87x
> audio, eth0
>  12:     730526          XT-PIC  i8042
>  14:     225867          XT-PIC  ide0
>  15:     551481          XT-PIC  ide1
> NMI:          0
> LOC:   81457121
> ERR:     104354
> MIS:          0

Yep, no rtc on IRQ8...

thanks,
-Len


