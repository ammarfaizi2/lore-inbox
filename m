Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbUJ2C5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbUJ2C5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUJ2CnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:43:17 -0400
Received: from fmr06.intel.com ([134.134.136.7]:48256 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263148AbUJ2ClU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 22:41:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Date: Fri, 29 Oct 2004 10:40:58 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFFF@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Thread-Index: AcS9Ai3uIcvk9bN0Tq+6GMX6ELl7nwAWvT5g
From: "Yu, Luming" <luming.yu@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>, "Brown, Len" <len.brown@intel.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 29 Oct 2004 02:41:12.0409 (UTC) FILETIME=[C0E6FC90:01C4BD60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Oct 28, 2004 at 01:37:52AM -0400, Len Brown wrote:
>> One way to experiment with a user-mode ACPI interpreter would be to 
>> continue to use the kernel-mode interpreter for boot up , 
>and cut over 
>> to the user-mode interpreter at /sbin/init.  The kernel-mode 
>interpreter 
>> could be sent the way of free_initmem() which is called just before 
>> /sbin/init is invoked.
>
>Is there a significant advantage to doing having a user-mode ACPI
>interpreter?  The only advantage I can think of is that the ACPI
>interpreter could now live in pageable memory.  Are there any others?

One reason for kernel-mode interpreter is to live in unpageable memory.

User-mode ACPI interpreter advantages:

1. Without losing platform functionality, user-mode interpreter
can make kernel less complex, thus more stronger.

2. Kernel can release from AML issues.
...

Thanks,
Luming
