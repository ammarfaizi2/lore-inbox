Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTJXVPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTJXVPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:15:20 -0400
Received: from ida.rowland.org ([192.131.102.52]:44804 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262610AbTJXVPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:15:14 -0400
Date: Fri, 24 Oct 2003 17:15:13 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Pedro Larroy <piotr@member.fsf.org>
cc: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: aborts in usb-storage in branch 2.6
In-Reply-To: <20031023165953.GA1410@81.38.200.176>
Message-ID: <Pine.LNX.4.44L0.0310241712140.2594-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Oct 2003, Pedro Larroy wrote:

> I can send anything you need. Here it goes some extended log.
> 
> I've noticed that abort are after ACPI debug statements.
> But seems acpi and usb are not sharing irqs.
> 
>            CPU0
>   0:     298778    IO-APIC-edge  timer
>   1:       1775    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   8:          4    IO-APIC-edge  rtc
>   9:         56   IO-APIC-level  acpi
>  12:         39    IO-APIC-edge  i8042
>  14:      13833    IO-APIC-edge  ide0
>  15:          1    IO-APIC-edge  ide1
>  16:          0   IO-APIC-level  uhci_hcd
>  17:         83   IO-APIC-level  Intel 82801DB-ICH4
>  18:          0   IO-APIC-level  uhci_hcd
>  19:       1069   IO-APIC-level  uhci_hcd, eth0
>  20:          0   IO-APIC-level  yenta
>  21:          0   IO-APIC-level  yenta
>  23:      10276   IO-APIC-level  ehci_hcd
> NMI:          0
> LOC:     298713
> ERR:          0
> MIS:          0
> 
> 
> abort.log -> 2.6.0test8
> devices -> 2.6.0test8
> kernel.log -> 2.6.0testx  where x < 8
> 
> In abort.log, is the paste of the log with kernel 2.6.0test8 in kern.log
> there is a log from 2.6.0test4 or 2.6.0test4-mm
> 
> On previous 2.6.0testx kernels the bug appeared to trigger when ACPI debug
> statements were printed, notice there are aborts after ACPI printks.
> 
> On 2.6.0test8 it seems to be triggered when doing concurrent access to the
> filesystem.
> 
> I would like to help in anyway I can, but ACPI and USB is far beyond my
> kernel knowledge, so I'm not currently able to fix the bugs myself.
> 
> Just ask if you need more information.
> Thanks.
> 
> Regards.

I looked at your logs, but I can't add much to what you already know.  
This certainly does appear to be some sort of interrupt sharing/routing
problem -- the logs don't indicate anything specific to USB.  However
there's no easy way to tell what the source of that problem is.

Maybe someone who knows more about ACPI and interrupt handling can help.

Alan Stern


