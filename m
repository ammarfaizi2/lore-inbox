Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVHRARt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVHRARt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVHRARs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:17:48 -0400
Received: from fmr15.intel.com ([192.55.52.69]:35027 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751393AbVHRARr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:17:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Question regarding HPET the 2.6 series kernel.
Date: Wed, 17 Aug 2005 17:15:12 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005787642@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question regarding HPET the 2.6 series kernel.
Thread-Index: AcWguhxc+M3IWYJkT96HbWWiS8vZlgCz6xvg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Aug 2005 00:15:13.0660 (UTC) FILETIME=[E750B3C0:01C5A389]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When it is supported in BIOS, you will see a HPET line similar to below
in initial ACPI messages.

ACPI: OEMB (v001 A M I  AMI_OEM  0x05000510 MSFT 0x00000097) @
0xdffdf040
ACPI: HPET (v001 A M I  OEMHPET  0x05000510 MSFT 0x00000097) @
0xdffd7480


And when it is supported in BIOS, kernel always uses it.

Thanks,
Venki
  

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
>Sent: Sunday, August 14, 2005 3:22 AM
>To: linux-kernel@vger.kernel.org
>Subject: Question regarding HPET the 2.6 series kernel.
>
>
>[*] HPET Timer Support
>[*]   Provide RTC interrupt
>
>[*] HPET - High Precision Event Timer
>[*]   Allow mmap of HPET
>
>http://tlug.up.ac.za/guides/lkcg/arch_i386.html
>
>HPET Timer Support	HPET_TIMER
>This enables the use of the HPET for the kernel's internal 
>timer. HPET is 
>the next generation timer replacing legacy 8254s. You can 
>safely choose Y 
>here. However, HPET will only be activated if the platform and 
>the BIOS 
>support this feature. Otherwise the 8254 will be used for 
>timing services. 
>Choose N to continue using the legacy 8254 timer.
>
>How do I determine if my BIOS has this feature?
>
>$ dmesg | grep -i hpet
>$ dmesg | grep -i 8254
>$ dmesg | grep -i timer
>..TIMER: vector=0x31 pin1=2 pin2=-1
>PCI: Setting latency timer of device 0000:02:01.0 to 64
>$
>
>Assuming it does, is there any reason to use or not to use 
>this feature?
>
>Thanks,
>
>Justin.
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
