Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTHUX1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 19:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTHUX1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 19:27:42 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:40831 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262166AbTHUX1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 19:27:40 -0400
Message-ID: <3F4555F8.6020707@sbcglobal.net>
Date: Thu, 21 Aug 2003 18:30:00 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@uni-mannheim.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm3 reserve IRQ for isapnp (2.6.0-test3-mm3 <sigh>)
References: <3F440387.5090902@sbcglobal.net> <200308211223.05614.schlicht@uni-mannheim.de> <3F44B493.1080403@sbcglobal.net> <200308211647.09541.schlicht@uni-mannheim.de>
In-Reply-To: <200308211647.09541.schlicht@uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks, but it didn't work.  Right after mounting root, it locked up 
when activating a USB device...probably some sort of IRQ problem still.

If I could just force it not to take 3, 4 ,5 , and 7 for PCI, I'm sure 
it would work.

-Wes

Thomas Schlichter wrote:

>On Thursday 21 August 2003 14:01, Wes Janzen wrote:
>  
>
>>Thanks, I was supposed to try that too, but I forgot ;-)
>>
>>So I tried it.  Doesn't work...  It does change the IRQ assignments, but
>>I don't think there would be any hope of it running without ACPI.  Isn't
>>ACPI required for IRQ sharing?  If not then it might work.
>>    
>>
>
>No, ACPI is not required for interrupt sharing... So it might work ;-)
>
>  
>
>>It uses 6 IRQ's just between the IDE and USB...the thing's stuffed with
>>cards.  Add video, SB16, 2 serial ports, parallel...well, you get the
>>idea.
>>
>>Now if VIA would have made it correctly in the first place...
>>
>>Wes
>>    
>>
>
>Have you tried my patch? I'm running a kernel with this patch, ACPI enabled 
>and "pci=noacpi". 16 IRQ's won't be enough for me, too, as you can see here:
>
>           CPU0
>  0:     348795    IO-APIC-edge  timer
>  1:        627    IO-APIC-edge  i8042
>  2:          0          XT-PIC  cascade
>  4:          5    IO-APIC-edge  serial
>  8:          2    IO-APIC-edge  rtc
>  9:          0    IO-APIC-edge  acpi
> 14:      12240    IO-APIC-edge  ide0
> 15:         11    IO-APIC-edge  ide1
> 16:      31827   IO-APIC-level  nvidia
> 17:       1461   IO-APIC-level  eth0
> 18:          4   IO-APIC-level  bttv0
> 19:      13213   IO-APIC-level  EMU10K1
> 21:      11567   IO-APIC-level  uhci-hcd, uhci-hcd, uhci-hcd, ehci_hcd
>
>And everything works just fine... (despite my broken BIOS ;-)
>
>  Thomas
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

