Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTELRTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTELRTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:19:25 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:6082 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262361AbTELRTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:19:04 -0400
Date: Mon, 12 May 2003 13:26:54 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Message Signalled Interrupt support?
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davem@redhat.com, willy@debian.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305121330_MC3-1-3881-E571@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Has anybody done any work, or put any thought, into MSI support?
> 
> Would things massively break if I set up MSI manually in the driver?
> 
> I heard rumblings on lkml that Intel has done some work internally w/
> MSI support in Linux, but that doesn't help me much without further
> details ;-)


I found this in my archives:

================================

Subject: RE: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
Date: Mon, 21 Apr 2003 09:34:34 -0700
From: "Nakajima, Jun" <jun.nakajima@intel.com>

<SNIP>

After (vector-based)
           CPU0       CPU1       
  0:     709682          0    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  9:          0          0   IO-APIC-level  acpi
 14:       4988          1    IO-APIC-edge  ide0
 15:         10          1    IO-APIC-edge  ide1
177:         78          0   IO-APIC-level  uhci-hcd
185:          0          0   IO-APIC-level  uhci-hcd, uhci-hcd
193:         58          0   IO-APIC-level  uhci-hcd
201:          0          0   IO-APIC-level  ehci-hcd
209:        356          0   IO-APIC-level  eth0
NMI:          0          0 
LOC:     707613     707524 
ERR:          0
MIS:          0

=========================================

  They changed things so the MSI scheme uses the vector number
directly instead of remapping it...



