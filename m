Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVCNUCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVCNUCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVCNUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:02:47 -0500
Received: from fmr18.intel.com ([134.134.136.17]:28081 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261287AbVCNUCJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:02:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Date: Mon, 14 Mar 2005 12:01:28 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502408070E2B@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUm5y8oeCr83W07QzueQEuTc6C94AB6JWew
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andi Kleen" <ak@muc.de>, "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>, <seto.hidetoshi@jp.fujitsu.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 20:01:30.0277 (UTC) FILETIME=[9D07CD50:01C528D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 12, 2005 1:38 AM Andi Kleen wrote:
>I haven't read your code in detail, just a high level remark.
>
>> +6. Enabling AER Aware Support in PCI Express Device Driver
>> +
>> +To enable AER aware support requires a software driver to configure
>> +the AER capability structure within its device, to initialize its
AER
>> +aware callback handle and to call pcie_aer_register. Sections 6.1,
>> +6.2, and 6.3 describe how to enable AER aware support in details.
>
>There is currently discussion underway for a generic portable PCI 
>error reporting interface for drivers. This is already being worked
>on by some PPC64 and IA64 people. I don't think it would be a good idea
>to add another incompatible PCI-E specific interface.
>
>So I would recommend to not apply pcie_aer_register() et.al.
>and coordinate with the others working on this area on a common
>interface.
>
>This would only impact the device driver interface; having
>a PCI Express specific interface in sysfs is probably ok.
>
>Otherwise we would end up with tons of ifdefs in the drivers
>supporting multiple error reporting interfaces for different platforms,

>which would be bad.
>
>Also in general I think the necessary callbacks should
>be part of the basic device; not provided in a separate structure.

Agree. We will coordinate with the others working on this area on a
common interface.

Thanks for your suggestions,
Long

