Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWGATI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWGATI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWGATI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 15:08:58 -0400
Received: from mga03.intel.com ([143.182.124.21]:7842 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932079AbWGATI5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 15:08:57 -0400
X-IronPort-AV: i="4.06,198,1149490800"; 
   d="scan'208"; a="60171123:sNHT901545470"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-mm5 -  ACPI Exception (acpi_processor-0272): AE_BAD_PARAMETER, Invalid _PSS data [20060623]
Date: Sat, 1 Jul 2006 15:08:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E58B72@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-mm5 -  ACPI Exception (acpi_processor-0272): AE_BAD_PARAMETER, Invalid _PSS data [20060623]
Thread-Index: AcadOOg43QT67Du0R3mpYf3xTHTaKAABoe4Q
From: "Brown, Len" <len.brown@intel.com>
To: "Ralf Hildebrandt" <Ralf.Hildebrandt@charite.de>,
       <linux-kernel@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 01 Jul 2006 19:08:07.0884 (UTC) FILETIME=[B00EE8C0:01C69D41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Starting with -mm4 and now with -mm5 I see:
>
>> Jul  1 19:54:29 knarzkiste kernel: powernow-k8: Found 1 AMD 
>Turion(tm) 64 Mobile Technology ML-30 processors (version 2.00.00)
>> Jul  1 19:54:29 knarzkiste kernel: ACPI: Invalid package argument
>> Jul  1 19:54:29 knarzkiste kernel: ACPI Exception 
>(acpi_processor-0272): AE_BAD_PARAMETER, Invalid _PSS data [20060623]
>> Jul  1 19:54:29 knarzkiste kernel: powernow-k8:    0 : fid 
>0x0 (800 MHz), vid 0x12
>> Jul  1 19:54:29 knarzkiste kernel: powernow-k8:    1 : fid 
>0x8 (1600 MHz), vid 0x4
>> Jul  1 19:54:29 knarzkiste kernel: powernow-k8: ph2 null fid 
>transition 0x8
>
>I'm not sure if The "ACPI: Invalid package argument" and "ACPI 
>Exception" are indicative of a real problem.
>
>> Jul  1 19:54:15 knarzkiste kernel: CPU: AMD Turion(tm) 64 
>Mobile Technology ML-30 stepping 02

Two things could be happening:

1. message was always there, but was disabled before.

	Please build a previous kernel that doesn't show
	this message (say 2.6.17) with CONFIG_ACPI_DEBUG=y
	and report if you see the same message.

	Note that the patch that enabled these messages
	had been in mm before for several months
	and just dropped out for a bit before -mm4,
	so you might see this in earlier -mm's too.

2. Some other regression

	Lets hope not.

In any case, it would be good to get to the root cause.
Please open a bugzilla here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the output from acpidump found in the
latest pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

After the above, you might also check for an updated BIOS.

thanks,
-Len
