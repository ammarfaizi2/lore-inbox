Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVK3Xay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVK3Xay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVK3Xay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:30:54 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:55732 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751246AbVK3Xay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:30:54 -0500
Message-ID: <042101c5f605$6c6e6250$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>  <Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr>  <018c01c5f435$9e548370$0400a8c0@dcccs>  <200511291015.55181.vda@ilport.com.ua> <fe726f4e0511290736w6931ec83q@mail.gmail.com> <Pine.LNX.4.61.0511301835270.26040@yvahk01.tjqt.qr>
Subject: Re: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)
Date: Thu, 1 Dec 2005 00:25:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


----- Original Message ----- 
From: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
To: "Carlos Martín" <carlosmn@gmail.com>
Cc: "JaniD++" <djani22@dynamicweb.hu>; <linux-kernel@vger.kernel.org>;
"Denis Vlasenko" <vda@ilport.com.ua>
Sent: Wednesday, November 30, 2005 6:35 PM
Subject: Re: ACPI: PCI Interrupt Link [LNKA] (IRQs *7)


> >> > *7)
> >> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKD]
(IRQs
> >> > *7)
> >> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKE]
(IRQs 3
> >> > 4 5 6 7 10 11 12 14 15) *0, disabled.
> >> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKF]
(IRQs 3
> >> > 4 5 6 7 10 11 12 14 15) *0, disabled.
> >> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKG]
(IRQs 3
> >> > 4 5 6 7 10 11 12 14 15) *0, disabled.
> >> > Nov 28 16:41:36 192.168.2.50 kernel: ACPI: PCI Interrupt Link [LNKH]
(IRQs 3
> >> > 4 5 6 7 *10 11 12 14 15)
> >> >
> >> > This is normal?  :-)
> >>
> >> I do not understand your question
> >
> >To answer the question, yes, it is perfectly normal to see that.
> >That's just the kernel describing how the PCI IRQs are set up. You
> >have nothing to worry about.
>
> I think it's the "disabled" that worries.

No, i worried about the " (IRQs *7)" format.
I never seen this before....

I searching the bottleneck of my system, and simply found these lines.

I have another question:

           CPU0       CPU1       CPU2       CPU3
  0:        112          0          0   12095059    IO-APIC-edge  timer
  8:          0          0          0       2005    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 14:          0          0          0    1922693    IO-APIC-edge  ide0
169:          0          0          0          0   IO-APIC-level
uhci_hcd:usb2
177:          0          0          0          0   IO-APIC-level
uhci_hcd:usb3
185:          0          0          0          0   IO-APIC-level
uhci_hcd:usb4
193:          0          0          0          0   IO-APIC-level
ehci_hcd:usb1
209:          0          0          0  204795144   IO-APIC-level  eth0
217:          0          0          0  424538586   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:   12095010   12095009   12094905   12094904
ERR:          0
MIS:          0

How can i avoid this?
(all irq on CPU 3)

The  echo /proc/irq/#smp_affinity # >smp_affinity

Has no effect. :-(

I tried it with kernel irq load balancing is on and off.
But nothing is changed. :(

Thanks

Janos



>
>
>
> Jan Engelhardt
> -- 
> | Alphagate Systems, http://alphagate.hopto.org/
> | jengelh's site, http://jengelh.hopto.org/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

