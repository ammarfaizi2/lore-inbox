Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966059AbWKIVD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966059AbWKIVD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966058AbWKIVD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:03:29 -0500
Received: from outbound-res.frontbridge.com ([63.161.60.49]:26295 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S966057AbWKIVD2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:03:28 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Thu, 9 Nov 2006 13:03:16 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071CC@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5 x86_64 irq 22: nobody cared
Thread-Index: AccD4bFW04ny4Z9NSoKoOcgHJ957OwAXxZEA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Olivier Nicolas" <olivn@trollprod.org>
cc: "Adrian Bunk" <bunk@stusta.de>, "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 09 Nov 2006 21:03:17.0172 (UTC)
 FILETIME=[7A6DD740:01C70442]
X-WSS-ID: 694D481F1AO1236720-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


           CPU0       CPU1       
  0:        214      24856   IO-APIC-edge      timer
  1:          0        359   IO-APIC-edge      i8042
  6:          0          5   IO-APIC-edge      floppy
  8:          0          0   IO-APIC-edge      rtc
  9:          0          0   IO-APIC-fasteoi   acpi
 12:          0        103   IO-APIC-edge      i8042
 14:          0        128   IO-APIC-edge      ide0
 16:          0          0   IO-APIC-fasteoi   libata
 17:          1          2   IO-APIC-fasteoi   bttv0
 20:         22       6469   IO-APIC-fasteoi   libata
 21:         11      99989   IO-APIC-fasteoi   ehci_hcd:usb2, HDA Intel
 22:          0          1   IO-APIC-fasteoi   libata, ohci_hcd:usb1
 23:          0          0   IO-APIC-fasteoi   libata
308:          8       2378   PCI-MSI-edge      eth1
309:          0          9   PCI-MSI-edge      eth1
310:          0          9   PCI-MSI-edge      eth1
311:          4       2401   PCI-MSI-edge      eth0
312:          0          0   PCI-MSI-edge      eth0
313:          0          1   PCI-MSI-edge      eth0
NMI:         74         47 
LOC:      25024      24991 
ERR:          0

But according to the irq router in pci conf, 
the ehci and audio share to use irq 20.
sata0 and ohci use irq 23
sata1 use irq 22, (MAC1 share it but kernel will use MSI)
sata2 use irq 21, (MAC0 share it but kernel will use MSI)

the ACPI report wrong GSI for them?

Can you disable the acpi and check the interrupt and lspci?

YH




