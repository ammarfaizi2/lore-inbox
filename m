Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUBVRiM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUBVRiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:38:12 -0500
Received: from rrcs-midsouth-24-172-39-10.biz.rr.com ([24.172.39.10]:39306
	"EHLO maunzelectronics.com") by vger.kernel.org with ESMTP
	id S261708AbUBVRiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:38:03 -0500
From: Mark Rutherford <mark@justirc.net>
To: Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NForce2 + linux 2.6.3-rc2 + acpi,apic patches
Date: Sun, 22 Feb 2004 12:42:47 -0500
User-Agent: KMail/1.6
References: <20040211012912.GA948@tesore.local>
In-Reply-To: <20040211012912.GA948@tesore.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402221242.47581.mark@justirc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse,

I saw this thread on the mailing list about your sucess with the nforce2...
I havent had much sucess with it, and was wondering if you have tried -rc3
Also, do you know if Andrew Morton's patches are cumulative?
would he have these patches in rc3-mm2 ?

I have been using my nforce2 machine in XT-PIC ... and its pretty bad.
I have some hardware that doesnt want to share the irq so it gets dicey.
I would like to get it fixed, I have posted, but I didnt get a response.

Thanks!


On Tuesday 10 February 2004 08:29 pm, Jesse Allen wrote:
> Hi,
>
> I have noticed two patches in Andrew Morton's tree, 2.6.3-rc1-mm1, that may
> be helpful for me and other nforce 2 users.  The two patches are
> nforce-irq-setup-fix.patch
> 8259-timer-ack-fix.patch
>
> I have compiled 2.6.3-rc2 with those two patches included.  Here is
> /proc/interrupts after reboot:
>   0:    2347129  local-APIC-edge  timer
>   1:       6604    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   4:       4458    IO-APIC-edge  serial
>   7:          0    IO-APIC-edge  parport0
>   8:          1    IO-APIC-edge  rtc
>   9:          0   IO-APIC-level  acpi
>  14:       4456    IO-APIC-edge  ide0
>  15:         17    IO-APIC-edge  ide1
>  20:     239364   IO-APIC-level  eth0, ohci_hcd
>  21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
>  22:          0   IO-APIC-level  ohci_hcd
>
>
> Timer is now local-APIC-edge instead of XT-PIC.  Seems to be better now. 
> I've checked to see if the problem with large clock time gain returned.  So
> far, it seems to be perfectly synced with my watch.
>
> I don't know if local-APIC or IO-APIC are really any different with the
> timer. If there is something I should know about the difference, someone
> please let me know =)
>
> Also, here's a snippet from dmesg:
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
> not connected. ..TIMER: vector=0x31 pin1=2 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ... works.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1912.0861 MHz.
> ..... host bus clock speed is 332.0671 MHz.
>
>
> Thanks Ross and Maciej for the patches!
>
> Jesse
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
