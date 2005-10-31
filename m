Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVJaRxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVJaRxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVJaRxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:53:19 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:31227 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S932520AbVJaRxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:53:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux 2.6.14 ehci-hcd hangs machine
Date: Mon, 31 Oct 2005 09:53:15 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.14 ehci-hcd hangs machine
Thread-Index: AcXdJVEB+jFfWVnYRa+fj1BX2q5EQwBHg2gw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Borislav Petkov" <bbpetkov@yahoo.de>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <dbrownell@users.sourceforge.net>, <greg@kroah.com>
X-OriginalArrivalTime: 31 Oct 2005 17:53:18.0027 (UTC) FILETIME=[F983D9B0:01C5DE43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Borislav Petkov
>Sent: Sunday, October 30, 2005 12:36 AM
>To: Linus Torvalds
>Cc: Linux Kernel Mailing List; 
>dbrownell@users.sourceforge.net; greg@kroah.com
>Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
>
>On Thu, Oct 27, 2005 at 05:28:50PM -0700, Linus Torvalds wrote:
>> 
>> Ok, it's finally there. 
>... and it still won't boot on my machine. It hangs while initializing
>the ehci usb host controller saying:
>
><snip>
>...
>[4294691.834000] usb usb3: Product: UHCI Host Controller
>[4294691.840000] usb usb3: Manufacturer: Linux 2.6.14 uhci_hcd
>[4294691.847000] usb usb3: SerialNumber: 0000:00:1d.2
>[4294691.880000] hub 3-0:1.0: USB hub found
>[4294691.885000] hub 3-0:1.0: 2 ports detected
>[4294694.855000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level,
>				low) -> IRQ 20
>[4294694.864000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
>[4294694.870000] ehci_hcd 0000:00:1d.7: debug port 1
></snip>
>
>and dies. This bug is actually in there since 2.6.14-rc4 (see:
>http://bugzilla.kernel.org/show_bug.cgi?id=5428) and David Brownell
>supplied a patch which turned out to be useless eventually 
>since _rebooting_ 
>the kernel with the 'usb-handoff' (and without the patch) 
>solved the problem. 
>As it turns out, it actually solves the problem only for the 
>reboot case.
>My machine still hangs on an initial boot with and without 
>'usb-handoff'.
>.config attached.

Boris, 

  While running with 'usb-handoff' turned on, do you see something like
"EHCI early BIOS handoff failed" (in power on or reboot cases) ? 

Aleks.

>
>Regards,
>		Boris.
>
