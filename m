Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUGQHQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUGQHQC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 03:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUGQHQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 03:16:02 -0400
Received: from fmr11.intel.com ([192.55.52.31]:62637 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S266650AbUGQHP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 03:15:59 -0400
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior
	2.6.7/-mm1
From: Len Brown <len.brown@intel.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C04EC@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C04EC@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1090048541.2792.26.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Jul 2004 03:15:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 17:57, Florian Weimer wrote:
> * David Weinehall:
> 
> > Strange.  suspend works for me (T40 though, not T40p), latest
> > BIOS-version, ACPI enabled, APM disabled.
> 
> Thanks for your /proc/interrupts file.  You have a lot less IRQ
> sharing than me:
> 
>            CPU0       
>   0:    5484369          XT-PIC  timer
>   1:      13698          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>  11:     301909          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, Intel
> 82801DB-ICH4, eth0, yenta, yenta, radeon@PCI:1:0:0
>  12:      14446          XT-PIC  i8042
>  14:      63403          XT-PIC  ide0
>  15:         21          XT-PIC  ide1
> NMI:          0 
> ERR:          0

> I wonder why the system has got such a high affinity to IRQ 11.  I've
> never seen so much IRQ sharing before. 8-/

Only the BIOS knows why -- Linux doesn't move IRQs around in PIC mode.
But you can make it attempt to balance them with "acpi_irq_balance" if
you're feeling adventerous.

cheers,
-Len


