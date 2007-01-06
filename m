Return-Path: <linux-kernel-owner+w=401wt.eu-S932219AbXAFWFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbXAFWFj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXAFWFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 17:05:39 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:25321 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbXAFWFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 17:05:38 -0500
Date: Sat, 6 Jan 2007 14:04:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: x86 instability with 2.6.1{8,9}
Message-Id: <20070106140459.a6b72039.randy.dunlap@oracle.com>
In-Reply-To: <20070102193459.GA19894@deepthought>
References: <20070101160158.GA26547@deepthought>
	<200701021225.57708.lenb@kernel.org>
	<20070102180425.GA18680@deepthought>
	<200701021342.32195.lenb@kernel.org>
	<20070102193459.GA19894@deepthought>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007 19:34:59 +0000 Ken Moffat wrote:

> On Tue, Jan 02, 2007 at 01:42:32PM -0500, Len Brown wrote:
> > 
> > You might remove and re-insert the DIMMS.
> > Sometimes there are poor contacts if the DIMMS are not fully seated and clicked in.
> > 
> > The real mystery is the 32 vs 64-bit thing.
> > Are the devices configured the same way -- ie are they both in IOAPIC mode
> > and /proc/interrupts looks the same for both modes?
> > 
> > -Len
> 
>  Too late, I've started memtest-86+.  If it seems ok after an
> overnight run, I'll take a look at /proc/interrupts.  How can I tell
> it is in IOAPIC mode, please ?  Google was not helpful for this, but
> if it's an override, the only things on my command lines are root=
> and video= settings.

(did anyone ever answer this?)

In IO-APIC mode, /proc/interrupts contains entries like these:

           CPU0       CPU1       
  0:  121218123          0    IO-APIC-edge  timer
  1:     715259          0    IO-APIC-edge  i8042
  6:          5          0    IO-APIC-edge  floppy
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 12:   10011272          0    IO-APIC-edge  i8042
 14:   11561548          0    IO-APIC-edge  ide0
 66:    4525183          0         PCI-MSI  libata
 74:       1711          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb6
 82:          4          0   IO-APIC-level  ohci_hcd:usb2, ohci_hcd:usb3, ohci_hcd:usb4, ohci_hcd:usb5
 98:     101326          0         PCI-MSI  HDA Intel
106:   17747181          0         PCI-MSI  eth0
169:          0          0   IO-APIC-level  uhci_hcd:usb9
177:          3          0   IO-APIC-level  ohci1394
185:         15          0   IO-APIC-level  uhci_hcd:usb8, aic79xx
193:     427962          0   IO-APIC-level  uhci_hcd:usb7, aic79xx

If not in IO-APIC mode, lots of those will say "XT-PIC" instead
of IO-APIC.

>  Certainly, it seems likely that the configs could be fairly
> different in their detail.


---
~Randy
