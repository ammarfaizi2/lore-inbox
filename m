Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTDSMNn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 08:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDSMNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 08:13:43 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:19912 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263383AbTDSMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 08:13:42 -0400
Date: Sat, 19 Apr 2003 08:21:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.5.67-mm4 & IRQ balancing
To: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304190825_MC3-1-3519-8F9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe wrote:


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


 I wonder what is the reason for all the NMIs? And why arent't the local
APIC interrupt counters in sync?

 With 2.5.66 I have twice as many interrupts on CPU1 as you. :)


           CPU0       CPU1       
  0:  250666330          0    IO-APIC-edge  timer
  1:        545          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
 12:        124          0    IO-APIC-edge  i8042
 15:         21          1    IO-APIC-edge  ide1
 18:       8484          0   IO-APIC-level  ide3
 19:       4679          0   IO-APIC-level  uhci-hcd, eth0
NMI:          0          0 
LOC:  250677924  250677924 
ERR:          0
MIS:          0



------
 Chuck
