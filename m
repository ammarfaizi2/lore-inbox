Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTDSNCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 09:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTDSNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 09:02:47 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:64916 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263387AbTDSNCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 09:02:45 -0400
Date: Sat, 19 Apr 2003 15:14:43 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030419151443.4d81ab78.philippe.gramoulle@mmania.com>
In-Reply-To: <200304190825_MC3-1-3519-8F9@compuserve.com>
References: <200304190825_MC3-1-3519-8F9@compuserve.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Well, my guess is that because i boot with nmi_watchdog=1 kernel boot option  ?? I don't really know.

This was what i used to troubleshoot hard lockups with previous kernels ( i may remove it now
as since a patch was made to fix that, everything runs smoothly :) 

Thanks,

Philippe


On Sat, 19 Apr 2003 08:21:38 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

  | Philippe wrote:
  | 
  | 
  | >            CPU0       CPU1       
  | >   0:   47851610          0    IO-APIC-edge  timer
  | >   1:      51789          0    IO-APIC-edge  i8042
  | >   2:          0          0          XT-PIC  cascade
  | >   3:        171          0    IO-APIC-edge  serial
  | >   8:     772066          0    IO-APIC-edge  rtc
  | >  12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
  | >  15:         58          1    IO-APIC-edge  ide1
  | >  16:      47047          0   IO-APIC-level  ohci1394
  | >  18:     391753          0   IO-APIC-level  EMU10K1
  | >  19:     911863          0   IO-APIC-level  uhci-hcd
  | >  20:     261806          0   IO-APIC-level  eth0
  | >  22:     273648          0   IO-APIC-level  aic7xxx
  | >  23:          0          0   IO-APIC-level  uhci-hcd
  | > NMI:   47853468   47852927 
  | > LOC:   47860500   47860630 
  | > ERR:          0
  | > MIS:          0
  | 
  | 
  |  I wonder what is the reason for all the NMIs? And why arent't the local
  | APIC interrupt counters in sync?
  | 
  |  With 2.5.66 I have twice as many interrupts on CPU1 as you. :)
  | 
  | 
  |            CPU0       CPU1       
  |   0:  250666330          0    IO-APIC-edge  timer
  |   1:        545          1    IO-APIC-edge  i8042
  |   2:          0          0          XT-PIC  cascade
  |  12:        124          0    IO-APIC-edge  i8042
  |  15:         21          1    IO-APIC-edge  ide1
  |  18:       8484          0   IO-APIC-level  ide3
  |  19:       4679          0   IO-APIC-level  uhci-hcd, eth0
  | NMI:          0          0 
  | LOC:  250677924  250677924 
  | ERR:          0
  | MIS:          0
  | 
  | 
  | 
  | ------
  |  Chuck
  | -
  | To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
  | the body of a message to majordomo@vger.kernel.org
  | More majordomo info at  http://vger.kernel.org/majordomo-info.html
  | Please read the FAQ at  http://www.tux.org/lkml/
