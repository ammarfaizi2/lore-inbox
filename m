Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTIACpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 22:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbTIACpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 22:45:35 -0400
Received: from fmr09.intel.com ([192.52.57.35]:4081 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262861AbTIACp2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 22:45:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: PROBLEM: no keyboard and mouse on 2.6.0-test4 (notebook)
Date: Sun, 31 Aug 2003 22:45:19 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCE1@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: no keyboard and mouse on 2.6.0-test4 (notebook)
Thread-Index: AcNvruVvXt5+EMI5SyWDSK/LHbsHJAAgvQRg
From: "Brown, Len" <len.brown@intel.com>
To: "Stefan Winter" <mail@stefan-winter.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2003 02:45:25.0776 (UTC) FILETIME=[18C5B900:01C37033]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan,
Did earlier versions of 2.6 (or 2.5) work?
Does booting 2.6.0-test4 with acpi=off make any difference?

Curious that vanilla 2.4.x has an issue with kbd interrupts on this box, but SuSE 8.2 does not.  Apparently SuSE 8.2 has a fix or workaround for this box that isn't in the baseline -- anybody know what it is?

Thanks,
-Len


> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> sunshine:/proc # cat interrupts
>            CPU0
>   0:    4574746          XT-PIC  timer
>   1:         14          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:          2          XT-PIC  ohci1394, VIA8233
>   9:          5          XT-PIC  acpi
>  10:       4029          XT-PIC  eth0
>  11:          0          XT-PIC  ehci_hcd
>  12:         89          XT-PIC  i8042
>  14:       5523          XT-PIC  ide0
>  15:         45          XT-PIC  ide1
> NMI:          0
> LOC:    4570927
> ERR:      62338
> MIS:          0
> 
> [X.] Other notes, patches, fixes, workarounds:
> the interrupt count on INT1,CPU0 (see /proc/interrupts above) does not
> increase after key pressures. It looks like the interrupt 
> from the keyboard
> isn´t caught. There is an issue on 2.4.x kernels that may 
> relate to that
> problem: after running the kernel and restarting it with 
> "init 6", the BIOS
> warns about "No interrupts from keyboard 0" and the BIOS 
> password entry
> field doesn´t catch keypresses any more [this is only an 
> issue with the
> vanilla kernel - SuSE 8.2´s patched kernel is fine]. An "init 0" and
> re-poweron solves that issue in 2.4.x kernels. Maybe the 2.6. kernel
> encounters that phenomenon earlier.
