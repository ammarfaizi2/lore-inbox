Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTDSAvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 20:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTDSAvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 20:51:17 -0400
Received: from fmr01.intel.com ([192.55.52.18]:27078 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263330AbTDSAvQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 20:51:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.5.67-mm4 & IRQ balancing
Date: Fri, 18 Apr 2003 18:03:12 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401A456AA@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.67-mm4 & IRQ balancing
Thread-Index: AcMGCKnPpTxkoXeqTMKhPMYnm5BgeQABnugA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: =?iso-8859-15?Q?Philippe_Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Apr 2003 01:03:13.0101 (UTC) FILETIME=[73A587D0:01C3060F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try to stress some (e.g. aic7xxx) of them (use dd, for example), and check what happens? I assume they are not HT-capable.

Thanks,
Jun


> -----Original Message-----
> From: Philippe Gramoullé [mailto:philippe.gramoulle@mmania.com]
> Sent: Friday, April 18, 2003 4:59 PM
> To: linux-kernel@vger.kernel.org
> Subject: 2.5.67-mm4 & IRQ balancing
> Importance: High
> 
> 
> Hello,
> 
> It may be not related to -mm4 only but as i hadn't checked before ( with
> 2.5.x kernels),
> I just wonder about /proc/interrupts output:
> 
> $ cat /proc/interrupts
>            CPU0       CPU1
>   0:   47851610          0    IO-APIC-edge  timer
>   1:      51789          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:        171          0    IO-APIC-edge  serial
>   8:     772066          0    IO-APIC-edge  rtc
>  12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
>  15:         58          1    IO-APIC-edge  ide1
>  16:      47047          0   IO-APIC-level  ohci1394
>  18:     391753          0   IO-APIC-level  EMU10K1
>  19:     911863          0   IO-APIC-level  uhci-hcd
>  20:     261806          0   IO-APIC-level  eth0
>  22:     273648          0   IO-APIC-level  aic7xxx
>  23:          0          0   IO-APIC-level  uhci-hcd
> NMI:   47853468   47852927
> LOC:   47860500   47860630
> ERR:          0
> MIS:          0
> 
> Shouldn't the interrupts be balanced on both CPUs ?
> 
> DELL MT 530 Ws , SMP Xeon 1.5Ghz, 512 Mo RAM on Debian Unstable.
> 
> Thanks,
> 
> Philippe
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
