Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWCAXBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWCAXBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCAXBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:01:44 -0500
Received: from fmr18.intel.com ([134.134.136.17]:722 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751104AbWCAXBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:01:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Wed, 1 Mar 2006 15:01:10 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0487A1F7@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16rc5 'found' an extra CPU.
Thread-Index: AcY9gznSZ3M1/5+UTO6drPqoYYBETgAAJGrg
From: "Moore, Robert" <robert.moore@intel.com>
To: "Dave Jones" <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2006 23:01:11.0249 (UTC) FILETIME=[08659410:01C63D84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be the "ACPI core", dedicated to running the ACPI interpreter.

:-)



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Dave Jones
> Sent: Wednesday, March 01, 2006 2:47 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Subject: 2.6.16rc5 'found' an extra CPU.
> 
> This amused me.
> 
> (17:43:34:davej@nemesis:~)$ ll /proc/acpi/processor/
> total 0
> dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU1/
> dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU2/
> dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU3/
> (17:43:36:davej@nemesis:~)$
> 
> As cool as a 3-way x86-64 sounds, it's really only got 2.
> 
> Two of these..
> 
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 5
> model name      : AMD Opteron(tm) Processor 244
> stepping        : 8
> cpu MHz         : 1789.412
> cache size      : 1024 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca
> cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext
> 3dnow
> bogomips        : 3578.59
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts ttp
> 
> 
> (17:45:21:davej@nemesis:~)$ cat /proc/acpi/processor/CPU*/info
> processor id:            0
> acpi id:                 1
> bus mastering control:   no
> power management:        no
> throttling control:      yes
> limit interface:         yes
> processor id:            1
> acpi id:                 2
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
> processor id:            255
> acpi id:                 3
> bus mastering control:   no
> power management:        no
> throttling control:      no
> limit interface:         no
> 
> I guess the '255' has confused something.
> 
> This made my 'bug of the day' :)
> 
> 		Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
