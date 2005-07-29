Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVG2V4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVG2V4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVG2V4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:56:48 -0400
Received: from fmr18.intel.com ([134.134.136.17]:2233 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262809AbVG2Vz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:55:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Fri, 29 Jul 2005 14:55:36 -0700
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
thread-index: AcWUh2KmoV/7j2ozQIqz4kosHSv4HgAAEYCQ
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <mj@ucw.cz>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2005 21:55:38.0213 (UTC) FILETIME=[414FA950:01C59488]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This define is not actually used anywhere that I know of.  I just wanted
to be consistent and correct, following what was previously done.  I
have been wondering if I should be adding devices to the pci_ids.h file
that are not being currently used.  It seems like most drivers are not
using these defines and are just using the DID's directly.  In the
future, should I only be add devices that are actually using the defines
somewhere?

Thanks,

Jason



>-----Original Message-----
>From: Jeff Garzik [mailto:jgarzik@pobox.com]
>Sent: Friday, July 29, 2005 2:49 PM
>To: Gaston, Jason D
>Cc: mj@ucw.cz; akpm@osdl.org; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
>
>Jason Gaston wrote:
>> Hello,
>>
>> This patch adds the Intel ICH7R SATA RAID DID to the pci_ids.h file.
>This patch was built against the 2.6.13-rc4 kernel.
>> If acceptable, please apply.
>>
>> Thanks,
>>
>> Jason Gaston
>>
>> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
>>
>> --- linux-2.6.13-rc4/include/linux/pci_ids.h.orig	2005-07-29
>09:06:03.841520568 -0700
>> +++ linux-2.6.13-rc4/include/linux/pci_ids.h	2005-07-29
>09:06:42.256680576 -0700
>> @@ -2454,6 +2454,7 @@
>>  #define PCI_DEVICE_ID_INTEL_ICH7_3	0x27c1
>>  #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
>>  #define PCI_DEVICE_ID_INTEL_ICH7_31	0x27bd
>> +#define PCI_DEVICE_ID_INTEL_ICH7_4	0x27c3
>>  #define PCI_DEVICE_ID_INTEL_ICH7_5	0x27c4
>>  #define PCI_DEVICE_ID_INTEL_ICH7_6	0x27c5
>>  #define PCI_DEVICE_ID_INTEL_ICH7_7	0x27c8
>
>Where is this actually used?
>
>I purposefully do not use PCI_DEVICE_ID_xxx in my drivers, because I
>feel that linux/pci_ids.h is constantly patched for little value.
>
>Device ids, unlike vendor ids, are largely single-use constants.
>
>	Jeff
>
>

