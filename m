Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269081AbUJKQPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269081AbUJKQPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUJKQKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:10:49 -0400
Received: from fmr05.intel.com ([134.134.136.6]:32641 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269048AbUJKQIU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:08:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux 2.6.9-rc4 - pls test (and no more patches)
Date: Tue, 12 Oct 2004 00:07:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8405C29CF8@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux 2.6.9-rc4 - pls test (and no more patches)
Thread-Index: AcSvpt5DddFq/9QJQBeJfIFYoiRj6gAA9uVQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, <Brice.Goglin@ens-lyon.org>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 11 Oct 2004 16:07:58.0757 (UTC) FILETIME=[79E60550:01C4AFAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>
>but yours are different:
>
>> By the way, I still see these errors during the boot, don't 
>know if it's
>> supposed to be fixed :
>> 
>>   psparse-1133: *** Error: Method execution failed 
>[\_SB_.C03E.C053.C0D1.C12E] (Node e7f9a3a8), AE_AML_UNINITIALIZED_LOCAL
>>   psparse-1133: *** Error: Method execution failed 
>[\_SB_.C03E.C053.C0D1.C13D] (Node e7f9bd68), AE_AML_UNINITIALIZED_LOCAL
>>   psparse-1133: *** Error: Method execution failed 
>[\_SB_.C19F._BTP] (Node e7fa3348), AE_AML_UNINITIALIZED_LOCAL
>

..snippets from ASL language spec.(defined in ACPI spec).

17.5.69   Localx (Method Local Data Objects)
...
On entry to a control method, these objects are uninitialized 
and cannot be used until some value or reference is stored
into the object....

I guess AML interpreter successfully catch a bug violating 
the rule above.  Please attach /proc/acpi/dsdt in bug report.

Thanks,
Luming


